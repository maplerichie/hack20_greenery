import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../models/auth.dart';
import '../models/user.dart';
import '../config/app.dart';
import 'navi.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  String _boxName = "authBox";
  Auth _auth;
  Status _status = Status.Uninitialized;

  dynamic get auth => _auth;
  Status get status => _status;

  AuthProvider() {
    getAuthBox().then((auth) {
      if (auth != null) {
        _auth = auth;
        jwt = auth.jwt;
        _status = Status.Authenticated;
      } else {
        _status = Status.Unauthenticated;
        _auth = null;
      }
      notifyListeners();
    });
  }

  Future<bool> login({String username, String password}) async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
      return await login(username: username, password: password)
          .then((dynamic res) {
        if (res is bool) {
          _status = Status.Unauthenticated;
          notifyListeners();
          return res;
        }
        _auth = new Auth(
          jwt: res['jwt'],
          role: 1,
          status: 1,
          user: User.fromJson(json.encode(res['data'])),
        );
        jwt = res['jwt'];
        updateAuthBox(_auth);
        _status = Status.Authenticated;
        notifyListeners();
        return true;
      });
    } catch (e) {
      print('login catch $e');
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    resetAuth();
    notifyListeners();
  }

  Future<bool> loginAnonymous(bool isSuccess) async {
    print('LoginAnonymous');
    _status = Status.Authenticating;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 800), () {
      if (isSuccess) {
        _auth = new Auth(
            jwt: '0',
            role: 0,
            status: 1,
            user: new User(
              email: 'john@example.com',
              firstName: 'John',
              lastName: 'Doe',
            ));
        jwt = '0';
        _status = Status.Authenticated;
        notifyListeners();
      } else {
        _status = Status.Unauthenticated;
        notifyListeners();
      }
    });
    return isSuccess;
  }

  void resetAuth() {
    try {
      Hive.deleteBoxFromDisk(_boxName);
    } catch (e) {
      print(e);
    }
    _auth = null;
    _status = Status.Unauthenticated;
  }

  Future<Auth> getAuthBox() async {
    var authBox = await Hive.openBox(_boxName);
    if (authBox.length < 1) {
      return _auth = null;
    } else {
      _auth = authBox.getAt(0);
    }
    return _auth;
  }

  void updateAuthBox(Auth auth) async {
    var authBox = await Hive.openBox(_boxName);
    authBox.add(auth);
    _auth = auth;
  }
}
