import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:foodle_mart/provider/get_otp_details_provider.dart';
import 'package:foodle_mart/provider/phone_number_provider.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/utils/url_launcher.dart';
import 'package:foodle_mart/views/authentication/otp_verify.dart';
import 'package:foodle_mart/views/main_screen/main_screen.dart';
import 'package:foodle_mart/widgets/form_field_widget.dart';
import 'package:foodle_mart/widgets/named_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatelessWidget {
  static const routeName = '/signup';
  SignUp({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpassController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final phoneController =
        TextEditingController(text: "${context.watch<PhoneProvider>().phone}");
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              print('go back');
            },
            child: Icon(Icons.arrow_back, color: Colors.white)),
        title: Text("Register", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: MediaQuery.of(context).size.height * 7,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 40.h),
                  Text("Hello!",
                      style: TextStyle(
                          fontSize: 25.sp, color: Colors.grey.shade500)),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 200.w,
                    child: Text(
                        "Enter your informations below to join out family!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp, color: Colors.grey.shade500)),
                  ),
                  SizedBox(height: 47.h),
                  FormFieldWidget(
                      controller: _nameController, hintText: "Enter your name"),
                  SizedBox(height: 20.h),
                  FormFieldWidget(
                      controller: _emailController,
                      hintText: "Enter your mail"),
                  SizedBox(height: 20.h),
                  FormFieldWidget(
                      controller: context
                              .watch<PhoneProvider>()
                              .phone
                              .toString()
                              .isEmpty
                          ? _phoneController
                          : phoneController,
                      hintText: "Enter your phone number"),
                  SizedBox(height: 20.h),
                  FormFieldWidget(
                      controller: _passwordController,
                      hintText: "Enter your password"),
                  SizedBox(height: 20.h),
                  FormFieldWidget(
                      controller: _confirmpassController,
                      hintText: "re-enter your password"),
                  SizedBox(height: 40.h),
                  RegisterButton(
                      _nameController,
                      _emailController,
                      context.watch<PhoneProvider>().phone.toString().isEmpty
                          ? _phoneController
                          : phoneController,
                      _passwordController,
                      _confirmpassController),
                  SizedBox(height: 20.h),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Already have an account.?",
                        style: TextStyle(color: Colors.grey.shade600)),
                    TextSpan(
                        text: "Login",
                        style:
                            TextStyle(color: Color.fromARGB(255, 246, 227, 59)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/login');
                            print('redirect to login page');
                          })
                  ]))
                ],
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: 235.w,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "By continuing, you agree to our ",
                          style: TextStyle(color: Colors.grey.shade600)),
                      TextSpan(
                          text: "Terms of Services ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 246, 227, 59)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              print("redirect to url");
                              const url =
                                  'https://ebshosting.co.in/app/contactus/terms';
                              UrlLauncher.launhcUrl(url);
                            }),
                      TextSpan(
                          text: "and",
                          style: TextStyle(color: Colors.grey.shade600)),
                      TextSpan(
                          text: " Privacy Policy ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 246, 227, 59)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              print(" redirect to url");
                              const url =
                                  'https://ebshosting.co.in/app/contactus/privacy';
                              UrlLauncher.launhcUrl(url);
                            }),
                      TextSpan(
                          text: "and",
                          style: TextStyle(color: Colors.grey.shade600)),
                      TextSpan(
                          text: " Return Policy",
                          style: TextStyle(
                              color: Color.fromARGB(255, 246, 227, 59)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              print(" redirect to url");
                              const url =
                                  'https://ebshosting.co.in/app/contactus/return';
                              UrlLauncher.launhcUrl(url);
                            })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterButton extends HookWidget {
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  const RegisterButton(
    this.name,
    this.email,
    this.phone,
    this.password,
    this.confirmPassword, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useState(true);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Color.fromRGBO(246, 219, 59, 1),
          borderRadius: BorderRadius.circular(10)),
      child: state.value
          ? TextButton(
              onPressed: () async {
                state.value = false;
                if (name.text.isNotEmpty &&
                    email.text.isNotEmpty &&
                    phone.text.isNotEmpty &&
                    password.text.isNotEmpty &&
                    confirmPassword.text.isNotEmpty) {
                  if (password.text == confirmPassword.text) {
                    var response = await AuthCustomer.signUp(
                        name.text, email.text, phone.text, password.text);

                    var otp = await AuthCustomer.registerOtp(
                        name.text, email.text, phone.text);
                    context
                        .read<GetOtpDetails>()
                        .getDetails(name.text, email.text, phone.text);
                    print(response);
                    print(otp);
                    if (response == true && otp["sts"] == "01") {
                      print('sign up success');
                      state.value = true;
                      print(response);
                      print("done");
                      Navigator.pushNamed(context, '/otp-verify',
                          arguments: otp["otp"]);
                      state.value = true;
                    } else if (response == 'Error') {
                      state.value = true;
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Something went wrong. Check the information if correct and try again.')));
                    } else {
                      state.value = true;
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Something went wrong. Check the information if correct and try again.')));
                    }
                  } else {
                    state.value = true;
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content:
                            Text('confirm password does not match password')));
                  }
                } else {
                  state.value = true;
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill the empty fields')));
                }
              },
              child: Text("Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: .5)))
          : FittedBox(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
    );
  }
}
