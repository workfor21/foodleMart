import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/views/authentication/forgot_password.dart';
import 'package:foodle_mart/views/authentication/login.dart';
import 'package:foodle_mart/views/authentication/otp_verify.dart';
import 'package:foodle_mart/views/authentication/phone.dart';
import 'package:foodle_mart/views/authentication/signup.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/authScreen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: GestureDetector(
              onTap: () {
                print('go back');
              },
              child: Icon(Icons.arrow_back, color: Colors.white)),
          title: Text("login", style: TextStyle(color: Colors.white)),
        ),
        body: Phone());
  }
}
