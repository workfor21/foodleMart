// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.sts,
    this.msg,
    this.user,
  });

  String? sts;
  String? msg;
  User? user;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        sts: json["sts"],
        msg: json["msg"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "sts": sts,
        "msg": msg,
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.name,
    this.email,
    this.password,
    this.mobile,
    this.joinOn,
    this.id,
  });

  String? name;
  String? email;
  String? password;
  String? mobile;
  String? joinOn;
  int? id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        mobile: json["mobile"],
        joinOn: json["join_on"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "mobile": mobile,
        "join_on": joinOn,
        "id": id,
      };
}
