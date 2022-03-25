import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/views/category/category.dart';
import 'package:foodle_mart/views/home/home.dart';
import 'package:foodle_mart/views/orders/orders.dart';
import 'package:foodle_mart/views/profile/profile.dart';
import 'package:foodle_mart/views/view_post/resturant_view_post.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main';
  MainScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          bottomNavigationBar: menu(),
          body: const TabBarView(children: [
            Home(),
            Category(),
            Orders(),
            Profile(),
          ])),
    );
  }
}

Widget menu() {
  return Container(
    child: const TabBar(
      indicator: BoxDecoration(
          border: Border(
              top: BorderSide(
        color: Colors.black,
        width: 3,
      ))),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black,
      labelStyle: TextStyle(color: Colors.black, fontSize: 12),
      indicatorSize: TabBarIndicatorSize.tab,
      // indicatorPadding: EdgeInsets.only(bottom: 5),
      indicatorColor: Colors.black,
      tabs: [
        Tab(
          text: "Home",
          icon: Icon(
            Icons.home_outlined,
            size: 22,
          ),
        ),
        Tab(
          text: "Category",
          icon: Icon(
            Icons.category_outlined,
            size: 22,
          ),
        ),
        Tab(
          text: "Orders",
          icon: Icon(
            Icons.local_grocery_store_outlined,
            size: 22,
          ),
        ),
        Tab(
          text: "Account",
          icon: Icon(
            Icons.person_outline_outlined,
            size: 22,
          ),
        ),
      ],
    ),
  );
}
