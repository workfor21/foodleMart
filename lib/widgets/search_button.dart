import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodle_mart/views/search/search.dart';

class SearchButton extends StatelessWidget {
  final double width;
  const SearchButton({Key? key, this.width = 355}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/searchView');
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: width.w,
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 246, 227, 59),
            ),
            color: Colors.white54,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/search.svg', width: 18),
              SizedBox(width: 10),
              Text("What are you looking for..",
                  style: TextStyle(color: Color.fromARGB(156, 83, 83, 83)))
            ],
          )),
    );
  }
}
