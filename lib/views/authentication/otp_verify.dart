import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/provider/get_otp_details_provider.dart';
import 'package:foodle_mart/provider/phone_number_provider.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/widgets/form_field_widget.dart';
import 'package:foodle_mart/widgets/named_button.dart';
import 'package:provider/provider.dart';

class OTPVerify extends StatelessWidget {
  var otp;
  static const routeName = '/otp-verify';
  OTPVerify({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        title: Text("Verify Otp", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: MediaQuery.of(context).size.height * 7,
        // alignment: Alignment.center,
        child: SingleChildScrollView(child: GetNewOtp()),
      ),
    );
  }
}

class GetNewOtp extends HookWidget {
  GetNewOtp({Key? key}) : super(key: key);
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final otp = useState('');
    final provider = context.watch<GetOtpDetails>();
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 170.h),
        Text("Verify",
            style: TextStyle(fontSize: 25.sp, color: Colors.grey.shade500)),
        SizedBox(height: 20.h),
        Container(
          width: 240.w,
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
                text:
                    "Enter confirmation code we sent to +91 ********${context.watch<PhoneProvider>().phone.substring(context.watch<PhoneProvider>().phone.length - 2)}.",
                style: TextStyle(color: Colors.grey.shade600)),
            TextSpan(
                text: " Request new one",
                style: TextStyle(color: Color.fromARGB(150, 139, 195, 74)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    var responseOtp = await AuthCustomer.registerOtp(
                        provider.name, provider.email, provider.phone);
                    print(otp.value.isEmpty);
                    // print(otp);
                    print(responseOtp["otp"]);
                    otp.value = responseOtp["otp"].toString();
                    print('url redirect');
                  })
          ])),
        ),
        SizedBox(height: 47.h),
        FormFieldWidget(controller: _otpController, hintText: "otp"),
        SizedBox(height: 20.h),
        OtpButton(_otpController,
            otp.value.isNotEmpty ? otp.value : arguments.toString())
      ],
    );
  }
}

class OtpButton extends HookWidget {
  final TextEditingController otp;
  final String checkOtp;
  const OtpButton(
    this.otp,
    this.checkOtp, {
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
                print(otp.text == checkOtp);
                print(checkOtp);
                state.value = false;
                if (otp.text.isNotEmpty || checkOtp.isNotEmpty) {
                  if (otp.text == checkOtp) {
                    state.value = true;
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/mainScreen');
                  } else {
                    state.value = true;
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Please provide a valid otp.')));
                  }
                } else {
                  state.value = true;
                }
              },
              child: Text("Continue",
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
