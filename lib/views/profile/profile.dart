import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/utils/url_launcher.dart';
import 'package:foodle_mart/views/cart/cart.dart';
import 'package:foodle_mart/views/notification/notification.dart';
import 'package:foodle_mart/views/profile/address/your_address.dart';
import 'package:foodle_mart/widgets/header.dart';
import 'package:share/share.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
            title: Image.asset("assets/images/foodle_logo.png", width: 90),
            actions: [
              IconButton(
                  onPressed: () {
                    print('notification');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => NotificationScreen()));
                  },
                  icon: Icon(Icons.notifications_none, color: Colors.black)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Cart()));
                  },
                  icon: Icon(Icons.local_grocery_store_outlined,
                      color: Colors.black)),
            ],
            bottom: PreferredSize(
              child: Column(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset("assets/images/profile.png")),
                Text("Janvi",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 5),
                Text("janvi@gmail.com", style: TextStyle(fontSize: 12)),
                SizedBox(height: 5),
                Text("09467328823", style: TextStyle(fontSize: 12)),
              ]),
              preferredSize: Size.fromHeight(200),
            )),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("your information"),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 20),
                  child: Column(
                    children: [
                      ProfileButtons(
                          title: "your order",
                          image: 'assets/icons/order_history.png',
                          function: () {
                            print("your orders");
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Cart()));
                          }),
                      ProfileButtons(
                          title: "address book",
                          image: 'assets/icons/address.png',
                          function: () async {
                            var states = await SearchApi.searchState();
                            var district = await SearchApi.searchDistrict();
                            print("address book");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => YourAddress()));
                          }),
                      ProfileButtons(
                          title: "notification",
                          image: 'assets/icons/notification.png',
                          function: () {
                            print("notification");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => NotificationScreen()));
                          }),
                    ],
                  ),
                ),
                Text("others"),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      ProfileButtons(
                          title: "support",
                          image: 'assets/icons/support.png',
                          function: () {
                            print("support");
                          }),
                      ProfileButtons(
                          title: "share the app",
                          image: 'assets/icons/share.png',
                          function: () {
                            Share.share('how are you');
                            print("share the app");
                          }),
                      ProfileButtons(
                          title: "about us",
                          image: 'assets/icons/info.png',
                          function: () {
                            var url = "https://twitter.com";
                            UrlLauncher.launhcUrl(url);
                            print("about us");
                          }),
                      ProfileButtons(
                          title: "logout",
                          image: 'assets/icons/logout.png',
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
    return GestureDetector(
      onTap: () => function(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5)),
                child: Image.asset(image, height: 25, width: 25)),
            SizedBox(width: 10),
            Container(
                child:
                    Text(title, style: TextStyle(fontWeight: FontWeight.w600))),
          ],
        ),
      ),
    );
  }
}
