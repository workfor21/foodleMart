import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NamedButton extends StatelessWidget {
  final Function? function;
  final String title;
  final double size;
  NamedButton({Key? key, this.size = 14, this.function, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Color.fromRGBO(246, 219, 59, 1),
            borderRadius: BorderRadius.circular(10)),
        child: TextButton(
            onPressed: () => function!(),
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .5))));
  }
}
