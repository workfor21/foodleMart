import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/widgets/form_field_widget.dart';
import 'package:foodle_mart/widgets/named_button.dart';

class ForgotPassword extends StatelessWidget {
  static const routeName = '/forgot-password';
  ForgotPassword({Key? key}) : super(key: key);

  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

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
        title: Text("Forgot Password", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: MediaQuery.of(context).size.height * 7,
        // alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 130.h),
              Text("Forgot ?",
                  style:
                      TextStyle(fontSize: 25.sp, color: Colors.grey.shade500)),
              SizedBox(height: 20.h),
              Container(
                width: 240.w,
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Enter confirmation code we sent to +91 *******96.",
                      style: TextStyle(color: Colors.grey.shade600)),
                  TextSpan(
                      text: " Request new one",
                      style:
                          TextStyle(color: Color.fromARGB(150, 139, 195, 74)),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('url redirect');
                        })
                ])),
              ),
              SizedBox(height: 47.h),
              FormFieldWidget(controller: _otpController, hintText: "otp"),
              SizedBox(height: 20.h),
              FormFieldWidget(
                  controller: _passwordController,
                  hintText: "Enter new password"),
              SizedBox(height: 20.h),
              FormFieldWidget(
                  controller: _confirmpasswordController,
                  hintText: "Re-enter new password"),
              SizedBox(height: 20.h),
              NamedButton(
                  title: 'Reset',
                  function: () {
                    print(_otpController.text);
                    print(_passwordController.text);
                    print(_confirmpasswordController.text);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
