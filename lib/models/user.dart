import 'dart:convert';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  int id;
  @HiveField(0)
  String email;
  @HiveField(1)
  String firstName;
  @HiveField(2)
  String lastName;
  String idNo;
  String contactNo;
  String address1;
  String address2;
  String postcode;
  String city;
  String state;
  String country;
  String idUrl;
  String avatar;
  int status;

  User(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.idNo,
      this.contactNo,
      this.address1,
      this.address2,
      this.postcode,
      this.city,
      this.state,
      this.country,
      this.idUrl,
      this.avatar,
      this.status});

  User.initial()
      : id = 0,
        email = '',
        firstName = '',
        lastName = '',
        idNo = '',
        contactNo = '',
        address1 = '',
        address2 = '',
        postcode = '',
        city = '',
        state = '',
        country = '',
        idUrl = '',
        avatar = '',
        status = 0;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['idNo'] = this.idNo;
    data['contactNo'] = this.contactNo;
    data['address1'] = this.address1;
    if (this.address2.length > 0) {
      data['address2'] = this.address2;
    }
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    if (this.idUrl != null) {
      data['idUrl'] = this.idUrl;
    }
    data['avatar'] = this.avatar;
    if (this.status != null) {
      data['status'] = this.status;
    }
    return data;
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      idNo: map['idNo'],
      contactNo: map['contactNo'],
      address1: map['address1'],
      address2: map['address2'],
      postcode: map['postcode'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      idUrl: map['idUrl'],
      avatar: map['avatar'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String src) => fromMap(json.decode(src));
}
