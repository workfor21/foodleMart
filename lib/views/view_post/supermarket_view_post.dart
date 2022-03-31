import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/models/cart_modal.dart';
import 'package:foodle_mart/models/post_model.dart';
import 'package:foodle_mart/models/supermarket_model.dart';
import 'package:foodle_mart/provider/cart_notify_provider.dart';
import 'package:foodle_mart/provider/total_amount_provider.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/utils/star_rating.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class SupermarketViewPost extends StatefulWidget {
  static const routeName = '/supermarket-view-post';

  @override
  State<SupermarketViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<SupermarketViewPost>
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
      body: FutureBuilder<SuperMarketModel?>(
        future: SupermarketApi.getOne(arguments),
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            SuperMarketModel data = snapshot.data;
            int categoryLength = data.category!.values.length;
            final shop = data.shop;
            print('banner pic' + data.shop!.banner.toString());
            return Column(
              children: [
                Stack(children: [
                  Container(
                    height: 300.h,
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         image: AssetImage("assets/images/carousal1.png"),
                    //         fit: BoxFit.cover)),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      // height: 100,
                      width: MediaQuery.of(context).size.width,
                      imageUrl:
                          "https://ebshosting.co.in${shop!.banner.toString()}",
                      errorWidget: (context, url, error) => Image.network(
                          "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"),
                    ),
                    // Image.asset(
                    //   "assets/images/carousal1.png",
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 7),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                              Color.fromARGB(255, 253, 215, 0),
                                  Color.fromARGB(255, 246, 227, 59),
                            ])),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    shop.name.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  StarRating(
                                    iconsize: 13,
                                    rating: shop.rating!.toDouble(),
                                  )
                                ]),
                            Text(shop.city!.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12))
                          ],
                        )),
                  )
                ]),
                DefaultTabController(
                    length: categoryLength,
                    child: Column(children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                              border: Border.all(color: Colors.grey.shade400)),
                          isScrollable: true,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black,
                          tabs: data.category!.values.map((e) {
                            return Tab(text: e);
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 450.h,
                        child: TabBarView(
                            children:
                                List<Widget>.generate(categoryLength, (index) {
                          final productList = data.products![index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                children: data.products!.map((e) {
                                  if (data.category!.keys.elementAt(index) ==
                                      e.catId.toString()) {
                                    return ViewPostsWidget(
                                      unit: e.units,
                                      hasUnit: e.hasUnits,
                                      type: e.shopType.toString(),
                                      shopId: e.shopId.toString(),
                                      productId: e.id.toString(),
                                      image: e.image,
                                      name: e.name.toString(),
                                      price: e.price.toString(),
                                      status: e.status.toString(),
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
            );
          }
          // else if (snapshot.data!.products.length == 0 ||
          //     snapshot.data!.products == null) {
          //   return Container(
          //       height: 500.h,
          //       child: Center(child: Text('Not Products Available')));
          // }
          else {
            return Container(
                height: 500.h,
                child: Center(child: CircularProgressIndicator()));
          }
        }),
      ),
    );
  }
}

class ViewPostsWidget extends HookWidget {
  List? unit;
  dynamic hasUnit;
  String? unitId;
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
      this.unit,
      this.unitId,
      this.hasUnit,
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
    final currentButton = useState(false);
    final currentNumber = useState(1);
    // final currentNumber = useState(0);
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
                      imageUrl: "https://ebshosting.co.in$image",
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
                  Text("₹$price", style: TextStyle(fontSize: 12.sp)),
                  SizedBox(height: 5.h),
                  Text(status,
                      style: TextStyle(
                          fontSize: 12.sp,
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
                  currentButton.value == false
                      ? GestureDetector(
                          onTap: () async {
                            if (int.parse(hasUnit) == 1) {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) =>
                                      DraggableScrollableSheet(
                                          expand: false,
                                          initialChildSize: .35,
                                          minChildSize: 0.35,
                                          maxChildSize: 0.35,
                                          builder: (BuildContext context,
                                              ScrollController
                                                  scrollController) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20, top: 20),
                                              child: ListView.builder(
                                                  itemCount: unit!.length,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    SuperMarketUnitModel
                                                        unitList = unit![index];
                                                    print(unitList.id);
                                                    return SubProductsViewPost(
                                                      unitId: unitList.id
                                                          .toString(),
                                                      type: type,
                                                      shopId: shopId,
                                                      productId:
                                                          unitList.productId,
                                                      name: unitList.name
                                                          .toString(),
                                                      price: unitList.price
                                                          .toString(),
                                                      status: unitList.status
                                                          .toString(),
                                                    );
                                                  })),
                                            );
                                          }));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.pop(context);
                                    });
                                    return AlertDialog(
                                      title: Text(
                                          'Product is being added to cart',
                                          style: TextStyle(fontSize: 12.sp)),
                                    );
                                  });
                              currentButton.value = true;
                              var response = await CartApi.addToCart(
                                  type, productId, shopId, unitId);
                              if (response == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("product added to cart"),
                                        duration: Duration(seconds: 1)));
                                context.read<CartNotifyProvider>().addCount();
                                context.read<TotalAmount>().GetAllAmounts();
                              }
                              print('add to cart:::::::' + response.toString());

                              print('add to cart');
                            }
                          },
                          child: Container(
                              height: 30.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[
                                        Color.fromRGBO(246, 219, 59, 1),
                                        Color.fromARGB(255, 246, 227, 59),
                                      ]),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                  child: Text("Add To Cart",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)))))
                      : Container(
                          height: 30.h,
                          width: 90.w,
                          // margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 2)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                    onTap: () async {
                                      print('minus');
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      var cart = prefs.getString('cart');
                                      var cartBody = jsonDecode(cart!);
                                      var dcartBody = jsonDecode(cartBody);

                                      for (var i in dcartBody['cart']) {
                                        if (name == i['productname']) {
                                          context
                                              .read<TotalAmount>()
                                              .GetAllAmounts();
                                          currentNumber.value =
                                              currentNumber.value - 1;
                                          if (currentNumber.value <= 0)
                                            currentNumber.value = 1;

                                          var response =
                                              await CartApi.updateCart(
                                                  i['id'].toString(),
                                                  currentNumber.value
                                                      .toString());
                                          print(response);
                                        }
                                      }
                                    },
                                    child: Container(
                                        // padding: const EdgeInsets.symmetric(horizontal: 1),
                                        width: 15.w,
                                        height: 15.h,
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Divider(
                                          thickness: 2,
                                          color: Colors.white,
                                        ))),
                                SizedBox(width: 10),
                                Text("${currentNumber.value}"), //quantity
                                SizedBox(width: 10),
                                GestureDetector(
                                    onTap: () async {
                                      print('add');
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      var cart = prefs.getString('cart');
                                      var cartBody = jsonDecode(cart!);
                                      var dcartBody = jsonDecode(cartBody);

                                      for (var i in dcartBody['cart']) {
                                        print(
                                            "${name} :::: ${i['productname']}");
                                        print(name == i['productname']);
                                        if (name == i['productname']) {
                                          context
                                              .read<TotalAmount>()
                                              .GetAllAmounts();
                                          currentNumber.value =
                                              currentNumber.value + 1;
                                          if (currentNumber.value >= 10)
                                            currentNumber.value = 10;
                                          var response =
                                              await CartApi.updateCart(
                                                  i['id'].toString(),
                                                  currentNumber.value
                                                      .toString());
                                          print(response);
                                          print(i);
                                        }
                                      }
                                    },
                                    child: Container(
                                        width: 15.w,
                                        height: 15.h,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Icon(Icons.add,
                                            color: Colors.white, size: 15))),
                              ])),
                ],
              ),
            ),
          ],
        ));
  }
}

class SubProductsViewPost extends HookWidget {
  dynamic unitId;
  String? type;
  dynamic shopId;
  dynamic productId;
  int? itemCount;
  String? image;
  String name;
  String price;
  String status;
  SubProductsViewPost(
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
    final currentButton = useState(false);
    final currentNumber = useState(1);
    // final currentNumber = useState(0);
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
            SizedBox(width: 15.w),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 5.h),
                  Text("₹$price", style: TextStyle(fontSize: 12.sp)),
                  SizedBox(height: 5.h),
                  Text(status,
                      style: TextStyle(
                          fontSize: 12.sp,
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
                  currentButton.value == false
                      ? GestureDetector(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  Future.delayed(Duration(seconds: 2), () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("product added to cart"),
                                            duration: Duration(seconds: 1)));
                                    Navigator.pop(context);
                                  });
                                  return AlertDialog(
                                    title: Text(
                                        'Product is being added to cart',
                                        style: TextStyle(fontSize: 12.sp)),
                                  );
                                });
                            currentButton.value = true;
                            var response = await CartApi.addToCart(
                                type, productId, shopId, unitId);
                            context.read<CartNotifyProvider>().addCount();
                            context.read<TotalAmount>().GetAllAmounts();
                            print('add to cart:::::::' + response.toString());

                            print('add to cart');
                          },
                          child: Container(
                              height: 30.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[
                                        const Color.fromRGBO(166, 206, 57, 1),
                                        const Color.fromRGBO(72, 170, 152, 1)
                                      ]),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                  child: Text("Add To Cart",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)))))
                      : Container(
                          height: 30.h,
                          width: 90.w,
                          // margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 2)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                    onTap: () async {
                                      print('minus');
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      var cart = prefs.getString('cart');
                                      var cartBody = jsonDecode(cart!);
                                      var dcartBody = jsonDecode(cartBody);

                                      for (var i in dcartBody['cart']) {
                                        if (unitId.toString() ==
                                            i['unit_id'].toString()) {
                                          context
                                              .read<TotalAmount>()
                                              .GetAllAmounts();
                                          currentNumber.value =
                                              currentNumber.value - 1;
                                          if (currentNumber.value <= 0)
                                            currentNumber.value = 1;

                                          var response =
                                              await CartApi.updateCart(
                                                  i['id'].toString(),
                                                  currentNumber.value
                                                      .toString());
                                          print(response);
                                        }
                                      }
                                    },
                                    child: Container(
                                        // padding: const EdgeInsets.symmetric(horizontal: 1),
                                        width: 15.w,
                                        height: 15.h,
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Divider(
                                          thickness: 2,
                                          color: Colors.white,
                                        ))),
                                SizedBox(width: 10),
                                Text("${currentNumber.value}"), //quantity
                                SizedBox(width: 10),
                                GestureDetector(
                                    onTap: () async {
                                      print('add');
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      var cart = prefs.getString('cart');
                                      var cartBody = jsonDecode(cart!);
                                      var dcartBody = jsonDecode(cartBody);

                                      for (var i in dcartBody['cart']) {
                                        print("${unitId} :::: ${i['unit_id']}");
                                        print(unitId == i['unit_id']);
                                        if (unitId.toString() ==
                                            i['unit_id'].toString()) {
                                          context
                                              .read<TotalAmount>()
                                              .GetAllAmounts();
                                          currentNumber.value =
                                              currentNumber.value + 1;
                                          if (currentNumber.value >= 10)
                                            currentNumber.value = 10;
                                          var response =
                                              await CartApi.updateCart(
                                                  i['id'].toString(),
                                                  currentNumber.value
                                                      .toString());
                                          print(response);
                                          print(i);
                                        }
                                      }
                                    },
                                    child: Container(
                                        width: 15.w,
                                        height: 15.h,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Icon(Icons.add,
                                            color: Colors.white, size: 15))),
                              ])),
                ],
              ),
            ),
          ],
        ));
  }
}
