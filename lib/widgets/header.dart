import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Headerwidget extends StatelessWidget {
  String? route;
  String? type;
  String? id;
  bool isMore;
  final String title;
  Headerwidget(
      {Key? key,
      this.isMore = true,
      this.route,
      this.type,
      this.id,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, route!, arguments: type);
            },
            child: isMore == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("more",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(97, 180, 127, 1))),
                      Icon(Icons.keyboard_double_arrow_right_outlined,
                          size: 18, color: Color.fromRGBO(97, 180, 127, 1))
                    ],
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
