// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:foodle_mart/repository/customer_repo.dart';
// import 'package:foodle_mart/views/category/category.dart';
// import 'package:foodle_mart/views/home/home.dart';
// import 'package:foodle_mart/views/orders/orders.dart';
// import 'package:foodle_mart/views/profile/profile.dart';
// import 'package:foodle_mart/views/view_post/resturant_view_post.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class MainScreen extends StatelessWidget {
//   static const routeName = '/main';
//   MainScreen({Key? key}) : super(key: key);

//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//           bottomNavigationBar: menu(),
//           body: TabBarView(children: [
//             Home(),
//             Category(),
//             Orders(),
//             Profile(),
//           ])),
//     );
//   }
// }

// Widget menu() {
//   return Container(
//     child: const TabBar(
//       indicator: BoxDecoration(
//           border: Border(
//               top: BorderSide(
//         color: Colors.black,
//         width: 3,
//       ))),
//       labelColor: Colors.black,
//       unselectedLabelColor: Colors.black,
//       labelStyle: TextStyle(color: Colors.black, fontSize: 12),
//       indicatorSize: TabBarIndicatorSize.tab,
//       // indicatorPadding: EdgeInsets.only(bottom: 5),
//       indicatorColor: Colors.black,
//       tabs: [
//         Tab(
//           text: "Home",
//           icon: Icon(
//             Icons.home_outlined,
//             size: 22,
//           ),
//         ),
//         Tab(
//           text: "Category",
//           icon: Icon(
//             Icons.category_outlined,
//             size: 22,
//           ),
//         ),
//         Tab(
//           text: "Orders",
//           icon: Icon(
//             Icons.local_grocery_store_outlined,
//             size: 22,
//           ),
//         ),
//         Tab(
//           text: "Account",
//           icon: Icon(
//             Icons.person_outline_outlined,
//             size: 22,
//           ),
//         ),
//       ],
//     ),
//   );
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodle_mart/models/user_model.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/views/cart/cart.dart';
import 'package:foodle_mart/views/category/category.dart';
import 'package:foodle_mart/views/home/home.dart';
import 'package:foodle_mart/views/notification/notification.dart';
import 'package:foodle_mart/views/orders/orders.dart';
import 'package:foodle_mart/views/profile/profile.dart';
import 'package:foodle_mart/views/view_post/resturant_view_post.dart';
import 'package:foodle_mart/widgets/search_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    Home(),
    Category(),
    Orders(),
    Profile(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _selectedIndex == 3
            ? AppBar(
                elevation: 0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                        Color.fromRGBO(246, 219, 59, 1),
                        Color.fromARGB(255, 246, 227, 59),
                        Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 255, 255, 255),
                      ])),
                ),
                automaticallyImplyLeading: false,
                title: Image.asset(
                  "assets/images/foodle_logo.png",
                  width: 70.w,
                ),
                actions: [
                  SizedBox(
                    width: 45,
                    child: TextButton(
                        onPressed: () {
                          print('notification');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => NotificationScreen()));
                        },
                        child:
                            SvgPicture.asset('assets/icons/notification.svg')),
                  ),
                  SizedBox(
                      width: 45,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/cart');
                          },
                          child: SvgPicture.asset('assets/icons/cart.svg'))),
                  SizedBox(width: 10)
                ],
                bottom: PreferredSize(
                  child: FutureBuilder(
                      future: HomeApi.userProfile(),
                      builder: ((context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          print('user profile ::: ' + snapshot.data.toString());
                          UserModel user = snapshot.data;
                          return Column(children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child:
                                    Image.asset("assets/images/profile.png")),
                            Text(user.user!.name ?? '',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 5),
                            Text(user.user!.email ?? '',
                                style: TextStyle(fontSize: 12.sp)),
                            SizedBox(height: 5),
                            Text(user.user!.mobile ?? '',
                                style: TextStyle(fontSize: 12.sp)),
                          ]);
                        } else {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Column(children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child:
                                      Image.asset("assets/images/profile.png")),
                              SizedBox(height: 10),
                              Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                      height: 8,
                                      width: 55,
                                      color: Colors.grey)),
                              SizedBox(height: 5),
                              Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                      height: 8,
                                      width: 85,
                                      color: Colors.grey)),
                              SizedBox(height: 5),
                              Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                      height: 8,
                                      width: 65,
                                      color: Colors.grey)),
                            ]),
                          );
                        }
                      })),
                  preferredSize: Size.fromHeight(160),
                ))
            : AppBar(
                elevation: 0,
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                      Color.fromRGBO(246, 219, 59, 1),
                      Color.fromARGB(255, 246, 227, 59),
                    ]))),
                automaticallyImplyLeading: false,
                title: Image.asset(
                  "assets/images/foodle_logo.png",
                  width: 70.w,
                ),
                actions: [
                  SizedBox(
                    width: 45,
                    child: TextButton(
                        onPressed: () {
                          print('notification');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => NotificationScreen()));
                        },
                        child:
                            SvgPicture.asset('assets/icons/notification.svg')),
                  ),
                  SizedBox(
                      width: 45,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/cart');
                          },
                          child: SvgPicture.asset('assets/icons/cart.svg'))),
                  SizedBox(width: 10)
                ],
                bottom: PreferredSize(
                    child: Column(
                      children: [
                        SearchButton(),
                        // TypeAheadField(
                        //   suggestionsCallback: suggestionsCallback,
                        //   itemBuilder: itemBuilder,
                        //   onSuggestionSelected: onSuggestionSelected),
                        Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            width: double.infinity,
                            color: Color.fromARGB(255, 255, 226, 58),
                            child: const BottomLocationSelectionSheet())
                      ],
                    ),
                    preferredSize: Size.fromHeight(90.h))),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              iconSize: 26,
              currentIndex: _selectedIndex,
              onTap: (index) {
                _onItemTap(index);
              },
              items: [
                BottomNavigationBarItem(
                    label: 'home',
                    icon: SvgPicture.asset('assets/icons/home.svg'),
                    activeIcon: SvgPicture.asset('assets/icons/home_bold.svg')),
                BottomNavigationBarItem(
                    label: 'category',
                    icon: SvgPicture.asset('assets/icons/category.svg'),
                    activeIcon:
                        SvgPicture.asset('assets/icons/categories_bold.svg')),
                BottomNavigationBarItem(
                    label: 'orders',
                    icon: SvgPicture.asset('assets/icons/orders.svg'),
                    activeIcon:
                        SvgPicture.asset('assets/icons/orders_bold.svg')),
                BottomNavigationBarItem(
                    label: 'account',
                    icon: SvgPicture.asset('assets/icons/person.svg'),
                    activeIcon:
                        SvgPicture.asset('assets/icons/person_bold.svg')),
              ]),
        ),
        body: pages[_selectedIndex]);
  }
}
