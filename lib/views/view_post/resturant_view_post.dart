import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/utils/star_rating.dart';
import 'package:foodle_mart/config/constants/api_configurations.dart';
import 'package:foodle_mart/models/post_model.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/utils/star_rating.dart';
import 'package:foodle_mart/views/cart/cart.dart';
import 'package:http/http.dart' as http;

class RestuarantViewPost extends StatefulWidget {
  static const routeName = '/restuarant-view-post';

  @override
  State<RestuarantViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<RestuarantViewPost>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/cart');
            },
            child: Container(
              width: 30.w,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: const AssetImage(
                    "assets/icons/cart.png",
                  ),
                ),
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(171, 255, 255, 255),
              ),
            ),
          )
        ],
        title: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(171, 255, 255, 255),
              ),
              child: const Icon(Icons.keyboard_arrow_left_rounded,
                  color: Colors.black, size: 28)),
        ),
      ),
      body: FutureBuilder<PostModal?>(
        future: RestaurantApi.getOneRestaurant(arguments),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            int categoryLength = data?.category.values.length ?? 0;
            final shop = data!.shop;
            print('banner pic' + data.shop.banner);
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 300.h,
                    child: Stack(children: [
                      CachedNetworkImage(
                        fit: BoxFit.fill,
                        // height: 100,
                        width: MediaQuery.of(context).size.width,
                        imageUrl: "https://ebshosting.co.in${shop.banner}",
                        errorWidget: (context, url, error) => Image.network(
                            "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 7),
                            width: MediaQuery.of(context).size.width,
                            height: 80.h,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                  Color.fromARGB(255, 255, 217, 0),
                                  Color.fromARGB(255, 206, 188, 29)
                                ])),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        shop.name.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      StarRating(
                                        iconsize: 13,
                                        rating: shop.rating.toDouble(),
                                      )
                                    ]),
                                Text(shop.city.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12))
                              ],
                            )),
                      )
                    ]),
                  ),
                  DefaultTabController(
                      length: categoryLength,
                      child: Column(children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          // height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.grey.shade400, width: 0)),
                          child: TabBar(
                            indicator: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            isScrollable: true,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black,
                            tabs: data.category.values.map((e) {
                              return Tab(text: e);
                            }).toList(),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                              maxHeight: 440.h, minHeight: 400.h),
                          child: TabBarView(
                              children: List<Widget>.generate(categoryLength,
                                  (index) {
                            final productList = data.products[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: data.products.map((e) {
                                    if (data.category.keys.elementAt(index) ==
                                        e.catId.toString()) {
                                      return ViewPostsWidget(
                                        unitId: e.hasUnits.toString(),
                                        type: e.shopType.toString(),
                                        shopId: e.shopId.toString(),
                                        productId: e.id.toString(),
                                        image: e.image,
                                        name: e.name,
                                        price: e.price.toString(),
                                        status: e.status,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }).toList(),
                                ),
                              ),
                            );
                          })),
                        ),
                      ])),
                ],
              ),
            );
          }
          // else if (snapshot.data == null) {
          //   return Container(
          //       height: 500.h,
          //       child: Center(child: Text('Not Products Available')));
          // }
          else {
            var isTimedOut = true;
            // new Timer(const Duration(seconds: 5), () {
            //   isTimedOut = false;
            //   print(isTimedOut);
            // });
            return isTimedOut == true
                ? SizedBox(
                    height: 400.h,
                    child: Center(child: CircularProgressIndicator()))
                : Text('texxt');
          }
        }),
      ),
    );
  }
}

class ViewPostsWidget extends StatelessWidget {
  dynamic unitId;
  String? type;
  dynamic shopId;
  dynamic productId;
  int? itemCount;
  String? image;
  String name;
  String price;
  String status;
  ViewPostsWidget(
      {Key? key,
      this.unitId,
      this.type,
      this.shopId,
      this.productId,
      this.itemCount,
      this.image,
      required this.price,
      required this.name,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.only(bottom: 15),
        // height: 100.h,
        width: 350.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200, width: 2.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      height: 100.h,
                      width: 100.w,
                      imageUrl: "https://ebshosting.co.in/${image.toString()}",
                      errorWidget: (context, url, error) => Image.network(
                        "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Image.network(W
                  //   image!.isEmpty || image == null
                  //       ? "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"
                  //       : "https://ebshosting.co.in/${image.toString()}",
                  //   fit: BoxFit.cover,

                  // ),
                ],
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 5.h),
                  Text("₹$price", style: TextStyle(fontSize: 12)),
                  SizedBox(height: 5.h),
                  Text(status,
                      style: TextStyle(
                          fontSize: 12,
                          color: status == "Available"
                              ? Colors.green
                              : Colors.red)),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var response = await CartApi.addToCart(
                          type, productId, shopId, unitId);
                      if (response == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("product added to cart"),
                            duration: Duration(seconds: 1)));
                      }
                      print('add to cart:::::::' + response.toString());

                      print('add to cart');
                    },
                    child: Container(
                        height: 30.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 207, 0),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                            child: Text("Add To Cart",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)))),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
