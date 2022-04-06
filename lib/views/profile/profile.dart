import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodle_mart/models/user_model.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/utils/url_launcher.dart';
import 'package:foodle_mart/views/cart/cart.dart';
import 'package:foodle_mart/views/notification/notification.dart';
import 'package:foodle_mart/views/profile/address/your_address.dart';
import 'package:foodle_mart/widgets/header.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //     elevation: 0,
        //     flexibleSpace: Container(
        //       decoration: BoxDecoration(
        //           gradient: LinearGradient(
        //               begin: Alignment.topCenter,
        //               end: Alignment.bottomCenter,
        //               colors: <Color>[
        //             Color.fromRGBO(166, 206, 57, 1),
        //             Color.fromARGB(255, 160, 224, 203),
        //             Color.fromARGB(255, 255, 255, 255),
        //             Color.fromARGB(255, 255, 255, 255),
        //           ])),
        //     ),
        //     automaticallyImplyLeading: false,
        //     title: Image.asset("assets/icons/logo1.png"),
        //     actions: [
        //       IconButton(
        //           onPressed: () {
        //             print('notification');
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (_) => NotificationScreen()));
        //           },
        //           icon: Icon(Icons.notifications_none, color: Colors.black)),
        //       IconButton(
        //           onPressed: () {
        //             Navigator.push(
        //                 context, MaterialPageRoute(builder: (_) => Cart()));
        //           },
        //           icon: Icon(Icons.local_grocery_store_outlined,
        //               color: Colors.black)),
        //     ],
        //     bottom: PreferredSize(
        //       child: FutureBuilder(
        //           future: HomeApi.userProfile(),
        //           builder: ((context, AsyncSnapshot snapshot) {
        //             if (snapshot.hasData) {
        //               print('user profile ::: ' + snapshot.data.toString());
        //               UserModel user = snapshot.data;
        //               return Column(children: [
        //                 ClipRRect(
        //                     borderRadius: BorderRadius.circular(100),
        //                     child: Image.asset("assets/images/profile.png")),
        //                 Text(user.user!.name ?? '',
        //                     style: TextStyle(
        //                         fontSize: 16.sp, fontWeight: FontWeight.w600)),
        //                 SizedBox(height: 5),
        //                 Text(user.user!.email ?? '',
        //                     style: TextStyle(fontSize: 12.sp)),
        //                 SizedBox(height: 5),
        //                 Text(user.user!.mobile ?? '',
        //                     style: TextStyle(fontSize: 12.sp)),
        //               ]);
        //             } else {
        //               return Shimmer.fromColors(
        //                 baseColor: Colors.grey.shade300,
        //                 highlightColor: Colors.grey.shade100,
        //                 child: Column(children: [
        //                   ClipRRect(
        //                       borderRadius: BorderRadius.circular(100),
        //                       child: Image.asset("assets/images/profile.png")),
        //                   SizedBox(height: 10),
        //                   Shimmer.fromColors(
        //                       baseColor: Colors.grey.shade300,
        //                       highlightColor: Colors.grey.shade100,
        //                       child: Container(
        //                           height: 8, width: 55, color: Colors.grey)),
        //                   SizedBox(height: 5),
        //                   Shimmer.fromColors(
        //                       baseColor: Colors.grey.shade300,
        //                       highlightColor: Colors.grey.shade100,
        //                       child: Container(
        //                           height: 8, width: 85, color: Colors.grey)),
        //                   SizedBox(height: 5),
        //                   Shimmer.fromColors(
        //                       baseColor: Colors.grey.shade300,
        //                       highlightColor: Colors.grey.shade100,
        //                       child: Container(
        //                           height: 8, width: 65, color: Colors.grey)),
        //                 ]),
        //               );
        //             }
        //           })),
        //       preferredSize: Size.fromHeight(200),
        //     )),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("your information"),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 0, bottom: 20),
                  child: Column(
                    children: [
                      ProfileButtons(
                          title: "your cart",
                          image: 'assets/icons/order_history.svg',
                          function: () {
                            print("your orders");
                            Navigator.pushNamed(context, '/cart');
                          }),
                      ProfileButtons(
                          title: "address book",
                          image: 'assets/icons/address.svg',
                          function: () async {
                            // var states = await SearchApi.searchState();
                            // var district = await SearchApi.searchDistrict();
                            print("address book");
                            Navigator.pushNamed(context, '/your-address');
                          }),
                      ProfileButtons(
                          title: "notification",
                          image: 'assets/icons/notification.svg',
                          function: () {
                            print("notification");
                            Navigator.pushNamed(context, '/notification');
                          }),
                    ],
                  ),
                ),
                Text("others"),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(
                    children: [
                      ProfileButtons(
                          title: "support",
                          image: 'assets/icons/support.svg',
                          function: () {
                            print("support");
                          }),
                      ProfileButtons(
                          title: "share the app",
                          image: 'assets/icons/share.svg',
                          function: () {
                            Share.share('how are you');
                            print("share the app");
                          }),
                      ProfileButtons(
                          title: "about us",
                          image: 'assets/icons/info.svg',
                          function: () {
                            var url =
                                "https://ebshosting.co.in/app/contactus/aboutus";
                            UrlLauncher.launhcUrl(url);
                            print("about us");
                          }),
                      ProfileButtons(
                          title: "logout",
                          image: 'assets/icons/logout.svg',
                          function: () async {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/authScreen', (route) {
                              print('rout name  ${route.settings.name}');
                              return false;
                            });
                            await AuthCustomer.logout();
                            // Navigator.pushNamed(context, '/authScreen');
                            print("logout");
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class ProfileButtons extends StatelessWidget {
  final String image;
  final String title;
  final Function function;
  const ProfileButtons(
      {Key? key,
      required this.title,
      required this.image,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        style: TextButton.styleFrom(primary: Colors.lightGreen),
        onPressed: () => function(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5)),
                child: SvgPicture.asset(image)),
            SizedBox(width: 10),
            Container(
                child: Text(title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black))),
          ],
        ),
      ),
    );
    // Padding(
    //   padding: const EdgeInsets.only(bottom: 8.0),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Container(
    //           padding: const EdgeInsets.all(4),
    //           decoration: BoxDecoration(
    //               color: Colors.grey.shade200,
    //               borderRadius: BorderRadius.circular(5)),
    //           child: Image.asset(image, height: 25, width: 25)),
    //       SizedBox(width: 10),
    //       Container(
    //           child:
    //               Text(title, style: TextStyle(fontWeight: FontWeight.w600))),
    //     ],
    //   ),
    // ),
  }
}
