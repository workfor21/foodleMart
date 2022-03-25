import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/provider/phone_number_provider.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/utils/shimmer_widget.dart';
import 'package:foodle_mart/utils/url_launcher.dart';
import 'package:foodle_mart/views/main_screen/main_screen.dart';
import 'package:foodle_mart/widgets/form_field_widget.dart';
import 'package:foodle_mart/widgets/named_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailOrMobile =
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
        title: Text("Login", style: TextStyle(color: Colors.white)),
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
                  SizedBox(height: 120.h),
                  Text("Hello Again!",
                      style:
                          TextStyle(fontSize: 25, color: Colors.grey.shade500)),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 200.w,
                    child: Text("Welcome back you've been missed !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade500)),
                  ),
                  SizedBox(height: 47.h),
                  FormFieldWidget(
                      controller: context
                              .watch<PhoneProvider>()
                              .phone
                              .toString()
                              .isEmpty
                          ? _emailController
                          : emailOrMobile,
                      hintText: "Enter your mobile number"),
                  SizedBox(height: 20.h),
                  FormFieldWidget(
                      obscureText: true,
                      controller: _passwordController,
                      hintText: "Enter your password"),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "reset password",
                            style: TextStyle(
                                color: Color.fromARGB(150, 139, 195, 74)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('reset password');
                              })
                      ]))
                    ],
                  ),
                  SizedBox(height: 40.h),
                  LoginButton(
                      context.watch<PhoneProvider>().phone.toString().isEmpty
                          ? _emailController
                          : emailOrMobile,
                      _passwordController)
                ],
              ),
              SizedBox(height: 160.h),
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
                          text: "Terms of Services and Privacy Policy",
                          style: TextStyle(
                              color: Color.fromARGB(255, 135, 167, 48)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              print("redirect to url");
                              const url = 'https://twitter.com';
                              UrlLauncher.launhcUrl(url);
                            })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButton extends HookWidget {
  final TextEditingController emailormobile;
  final TextEditingController password;
  const LoginButton(
    this.emailormobile,
    this.password, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useState(true);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Color.fromRGBO(246, 219, 59, 1),
          borderRadius: BorderRadius.circular(10)),
      child: state.value
          ? TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                state.value = false;
                var response =
                    await AuthCustomer.login(emailormobile.text, password.text);
                print(response);
                if (emailormobile.text.isNotEmpty && password.text.isNotEmpty) {
                  if (response == true) {
                    state.value = true;
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                prefs.getString("pincode").toString().isEmpty ||
                                        prefs.getString("pincode") == null
                                    ? ShimmerWidget()
                                    : MainScreen()));
                  } else if (response == "Error") {
                    state.value = true;
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Please check the information.')));
                  }
                } else {
                  state.value = true;
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill the form')));
                }
              },
              child: Text("Continue",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
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
