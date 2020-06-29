import 'package:flutter/material.dart';
import '../config/app.dart';

class NaviProvider with ChangeNotifier {
  int currentIndex = 0;
  bool showActions = true;
  bool showAppbar = true;
  String appBarTitle = appName;

  // get currentIndex => _currentIndex;

  // get showAppbar => _showAppbar;

  // get appBarTitle => _appBarTitle;

  void setActiveIndex(int index, bool appbar, bool actions, String title) {
    currentIndex = index;
    showAppbar = appbar;
    showActions = actions;
    appBarTitle = title;
    notifyListeners();
  }

  // set currentIndex(int index) {
  //   _currentIndex = index;
  //   notifyListeners();
  // }

  // set showAppbar(bool show) {
  //   _showAppbar = show;
  //   notifyListeners();
  // }

  // set appBarTitle(String title) {
  //   _appBarTitle = title;
  //   notifyListeners();
  // }
}
