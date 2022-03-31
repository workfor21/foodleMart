import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormFieldWidget extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;
  const FormFieldWidget(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        obscureText: obscureText,
        style: TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.shade800, fontSize: 14.sp),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade800),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade200)),
        ),
      ),
    );
  }
}
