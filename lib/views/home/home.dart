import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/models/home_model.dart';
import 'package:foodle_mart/models/res_model.dart';
import 'package:foodle_mart/provider/cart_notify_provider.dart';
import 'package:foodle_mart/provider/getLocation_provider.dart';
import 'package:foodle_mart/provider/pincode_provider.dart';
import 'package:foodle_mart/provider/pincode_search_provider.dart';
import 'package:foodle_mart/provider/total_amount_provider.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/utils/getLocation.dart';
import 'package:foodle_mart/utils/star_rating.dart';
import 'package:foodle_mart/views/notification/notification.dart';
import 'package:foodle_mart/views/view_post/resturant_view_post.dart';
import 'package:foodle_mart/widgets/header.dart';
import 'package:foodle_mart/widgets/search_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class Home extends StatelessWidget {
//   static const routeName = '/home';
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

class Home extends StatelessWidget {
  static const routeName = '/home';
  var currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                  Color.fromRGBO(246, 219, 59, 1),
                  Color.fromARGB(255, 246, 227, 59)
                ]))),
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
                  }, //
                  icon: Icon(Icons.notifications_none, color: Colors.black)),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  icon: Icon(Icons.local_grocery_store_outlined,
                      color: Colors.black)),
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
                        height: 30,
                        padding: const EdgeInsets.only(
                          left: 40,
                        ),
                        width: double.infinity,
                        color: Color.fromARGB(255, 252, 235, 82),
                        child: const BottomLocationSelectionSheet())
                  ],
                ),
                preferredSize: Size.fromHeight(80.h))),
        body: Stack(children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageCarousel(),
                SizedBox(height: 20.h),
                Container(
                    height: 80.h,
                    child: FutureBuilder(
                        future: HomeApi.categories(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<CategoryModel> data = snapshot.data;
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: ((context, index) {
                                  CategoryModel category = data[index];
                                  return CircleWidget(
                                      id: category.id.toString(),
                                      title: category.name ?? '',
                                      image:
                                          "https://ebshosting.co.in${category.image}");
                                }));
                          } else {
                            return SizedBox(
                              // width: double.infinity,
                              height: 40,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 7,
                                itemBuilder: ((context, index) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10,
                                          left: 18,
                                          top: 12,
                                          bottom: 12),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.asset(
                                            "assets/images/carousal1.png",
                                            fit: BoxFit.cover,
                                            width: 50.w,
                                          )),
                                    ),
                                  );
                                }),
                              ),
                            );
                          }
                        })),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/near-you',
                            arguments: false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 246, 227, 59)),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset("assets/images/carousal1.png",
                                width: 180.w,
                                height: 100.h,
                                fit: BoxFit.cover)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/near-you',
                            arguments: true);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 246, 227, 59)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset("assets/images/carousal1.png",
                              width: 180.w, height: 100.h, fit: BoxFit.fill),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Headerwidget(
                    title: "Top Restaurants",
                    route: '/restaurantsviewmore',
                    type: "Restaurants"),
                SizedBox(height: 20),
                Container(
                    constraints: BoxConstraints(maxHeight: 175, minHeight: 160),
                    child: FutureBuilder(
                        future: HomeApi.restaurants(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<Nrestaurants> data = snapshot.data;
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: ((context, index) {
                                  Nrestaurants restaurant = data[index];
                                  return Cards(
                                      status: restaurant.status ?? false,
                                      route: '/restuarant-view-post',
                                      itemId: restaurant.id.toString(),
                                      title: restaurant.name.toString(),
                                      time: restaurant.deliveryTime.toString(),
                                      ratings: restaurant.rating ?? 0,
                                      image:
                                          "https://ebshosting.co.in${restaurant.logo}");
                                }));
                          } else {
                            return SizedBox(
                              height: 170,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: ((context, index) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Cards(
                                        route: '',
                                        isRating: false,
                                      ),
                                    );
                                  })),
                            );
                          }
                        })),
                SizedBox(height: 20),
                Headerwidget(
                    title: "Top Super Markets",
                    route: '/supermarketsviewmore',
                    type: "Supermarkets"),
                SizedBox(height: 20),
                Container(
                    constraints: BoxConstraints(maxHeight: 175, minHeight: 160),
                    child: FutureBuilder(
                        future: HomeApi.supermarket(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<Nrestaurants> data = snapshot.data;
                            if (data.length == 0) {}
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: ((context, index) {
                                  Nrestaurants supermarket = data[index];
                                  return Cards(
                                      status: supermarket.status,
                                      itemId: supermarket.id.toString(),
                                      route: '/supermarket-view-post',
                                      title: supermarket.name.toString(),
                                      time: supermarket.deliveryTime ?? "",
                                      image:
                                          "https://ebshosting.co.in/${supermarket.logo}");
                                }));
                          } else {
                            return SizedBox(
                              height: 170,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: ((context, index) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Cards(
                                        route: '',
                                        isRating: false,
                                      ),
                                    );
                                  })),
                            );
                          }
                        })),
                SizedBox(height: 20),
                Headerwidget(
                    isMore: false,
                    title: "Top Products",
                    route: '/productsviewmore',
                    type: "Products"),
                SizedBox(height: 20),
                ///////////////////////////////////////////////
                //add to cart button -- plus and minus button//
                Container(
                    constraints: BoxConstraints(maxHeight: 230, minHeight: 160),
                    child: FutureBuilder(
                        future: HomeApi.restProducts(),
                        builder: (context, AsyncSnapshot snapshot) {
                          print(snapshot.data);
                          if (snapshot.hasData) {
                            List<RestproductModel> data = snapshot.data;
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: ((context, index) {
                                  RestproductModel products = data[index];
                                  print('products units ::::: ' +
                                      products.units.toString());
                                  return AddToCartHomeButton(
                                    status: products.status,
                                    title: products.name,
                                    price: products.offerprice.toString(),
                                    ratings: 3,
                                    image: products.image,
                                    hasUnit: products.hasUnits,
                                    unit: products.units,
                                    type: products.shopType.toString(),
                                    productId: products.id,
                                    shopId: products.shopId,
                                  );
                                }));
                          } else {
                            return SizedBox(
                              height: 170,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: ((context, index) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Cards(
                                        route: '',
                                        isRating: false,
                                      ),
                                    );
                                  })),
                            );
                          }
                        })),
                SizedBox(height: 20),
                ImageCarousel(
                  sorf: false,
                )
              ],
            ),
          ),
          Positioned(
              height: 50,
              bottom: 0,
              child: context.watch<CartNotifyProvider>().isCart == true
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Color.fromRGBO(166, 206, 57, 1),
                              Color.fromRGBO(72, 170, 152, 1)
                            ]),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${context.watch<CartNotifyProvider>().count} items | ₹${context.watch<TotalAmount>().totalAmount}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/cart');
                            },
                            child: Row(
                              children: [
                                Text('View Cart',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400)),
                                Icon(
                                  Icons.view_stream_outlined,
                                  size: 20,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          )
                        ],
                      ))
                  : SizedBox())
        ]),
      ),
    );
  }
}

class AddToCartHomeButton extends HookWidget {
  bool? status;
  String? title;
  String? price;
  String? image;
  double ratings;
  bool isRating;
  List? unit;
  String? type;
  dynamic hasUnit;
  dynamic shopId;
  dynamic productId;
  AddToCartHomeButton(
      {Key? key,
      this.image,
      this.status,
      this.isRating = true,
      this.ratings = 0,
      this.price,
      this.title,
      this.hasUnit,
      this.type,
      this.unit,
      this.shopId,
      this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentButton = useState(false);
    final currentNumber = useState(1);
    return Container(
      margin: const EdgeInsets.only(right: 5, left: 5),
      padding: const EdgeInsets.only(left: 2, right: 2, top: 4),
      width: 120.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 110.h,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: CachedNetworkImage(
              imageUrl: "https://ebshosting.co.in$image",
              errorWidget: (context, url, error) => Image.network(
                  "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png",
                  height: 110.h),
            ),
            // Image.network(
            //   image,
            //   fit: BoxFit.cover,
            // ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      constraints: BoxConstraints(maxHeight: 30, minHeight: 10),
                      width: 100,
                      child: Text(title.toString(),
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  // height: 20.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isRating
                          ? StarRating(
                              rating: ratings,
                              iconsize: 12,
                            )
                          : SizedBox(),
                      Text("₹$price",
                          style: TextStyle(
                              fontSize: 9.sp,
                              color: Color.fromRGBO(100, 120, 47, 1)))
                    ],
                  ),
                ),
                Column(
                  children: [
                    currentButton.value == false
                        ? GestureDetector(
                            onTap: () async {
                              if (status == false) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "This product is not currently available."),
                                    duration: Duration(seconds: 1)));
                              } else {
                                if (hasUnit.toString() == 1.toString()) {
                                  print('unit :::::: ' + unit.toString());
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 20),
                                                  child: ListView.builder(
                                                      itemCount: unit!.length,
                                                      itemBuilder:
                                                          ((context, index) {
                                                        Unit unitList =
                                                            unit![index];
                                                        print(unitList.id);
                                                        return SubProductsViewPost(
                                                          unitId: unitList.id
                                                              .toString(),
                                                          type: type,
                                                          shopId: shopId,
                                                          productId: unitList
                                                              .productId,
                                                          name: unitList.name
                                                              .toString(),
                                                          price: unitList.price
                                                              .toString(),
                                                          status: unitList
                                                              .status
                                                              .toString(),
                                                        );
                                                      })),
                                                );
                                              }));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          Navigator.pop(context);
                                        });
                                        return AlertDialog(
                                          title: Text(
                                              'Product is being added to cart',
                                              style:
                                                  TextStyle(fontSize: 12.sp)),
                                        );
                                      });
                                  currentButton.value = true;
                                  var response = await CartApi.addToCart(
                                      type, productId, shopId, 0);
                                  if (response == true) {
                                    context
                                        .read<CartNotifyProvider>()
                                        .addCount();
                                    context.read<TotalAmount>().GetAllAmounts();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("product added to cart"),
                                            duration: Duration(seconds: 1)));
                                  }
                                  print('add to cart:::::::' +
                                      response.toString());

                                  print('add to cart');
                                }
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                      onTap: () async {
                                        print('minus');
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        var cart = prefs.getString('cart');
                                        var cartBody = jsonDecode(cart!);
                                        var dcartBody = jsonDecode(cartBody);

                                        for (var i in dcartBody['cart']) {
                                          if (title.toString() ==
                                              i['productname'].toString()) {
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
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        var cart = prefs.getString('cart');
                                        var cartBody = jsonDecode(cart!);
                                        var dcartBody = jsonDecode(cartBody);

                                        for (var i in dcartBody['cart']) {
                                          print(
                                              "${title} :::: ${i['unit_id']}");
                                          print(title == i['unit_id']);
                                          if (title.toString() ==
                                              i['productname'].toString()) {
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Future getCartDetails() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var cart = prefs.getString('cart');
  //   var cartbody = json.decode(cart!);

  //   List<CartListModel> data = json.decode(cartbody['cart']);
  //   return data;
  // }
}

class ImageCarousel extends HookWidget {
  bool sorf;
  ImageCarousel({
    Key? key,
    this.sorf = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _index = useState(0);
    final _imageState = useState(0);
    return FutureBuilder(
        future: sorf ? HomeApi.fbanner() : HomeApi.sbanner(),
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<BannerModel> data = snapshot.data;
            return Column(
              children: [
                CarouselSlider.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index, realIndex) {
                      BannerModel banners = data[index];
                      return CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 1,
                        imageUrl:
                            "https://ebshosting.co.in/${banners.image.toString()}",
                        errorWidget: (context, url, error) => Image.network(
                            "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"),
                      );

                      // Image.network(
                      //     "https://ebshosting.co.in/${banners.image.toString()}",
                      //     fit: BoxFit.cover,
                      //     width: MediaQuery.of(context).size.width * 1);
                    },
                    options: CarouselOptions(
                        aspectRatio: 10 / 4.5,
                        viewportFraction: 1,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          _index.value = index;
                          _imageState.value = index;
                        })),
                !sorf
                    ? SizedBox()
                    : SizedBox(
                        height: 20,
                        child: AnimatedSmoothIndicator(
                            activeIndex: _index.value,
                            count: data.length,
                            effect: WormEffect(
                                dotWidth: 10.w,
                                dotHeight: 5.h,
                                dotColor: Colors.grey.shade300,
                                activeDotColor:
                                    Color.fromRGBO(201, 228, 125, 1),
                                strokeWidth: 1)))
              ],
            );
          } else {
            return AspectRatio(
              aspectRatio: 10 / 4.5,
              child: Image.asset(
                "assets/images/foodle_logo.png",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
            );
          }
        }));
  }
}

class CircleWidget extends StatelessWidget {
  String? id;
  String title;
  String image;
  CircleWidget(
      {Key? key,
      this.title = 'not available',
      this.id,
      this.image =
          "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('category-One');
        Navigator.pushNamed(context, '/viewall', arguments: id);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 18),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                width: 50,
                height: 50,
                imageUrl: image,
                placeholder: (context, url) => Image.network(
                    "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"),
                errorWidget: (context, url, error) => Image.network(
                    "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"),
              ),
            ),
            SizedBox(height: 4.h),
            Text(title,
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  String? type;
  String? shopId;
  String? unitId;
  bool? status;
  String route;
  String? itemId;
  String title;
  String time;
  double ratings;
  String image;
  bool isRating;
  Cards(
      {Key? key,
      this.type,
      this.shopId,
      this.unitId,
      this.status,
      required this.route,
      this.itemId,
      this.title = "not available",
      this.time = "!!",
      this.image =
          "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png",
      this.ratings = 4.5,
      this.isRating = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (status == true) {
          Navigator.pushNamed(context, route, arguments: itemId);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("This restaurant is unavailable!!"),
              duration: Duration(milliseconds: 500)));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 5, left: 5),
        padding: const EdgeInsets.only(left: 2, right: 2, top: 4),
        width: 120.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 110.h,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: image,
                errorWidget: (context, url, error) => Image.network(
                    "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"),
              ),
              // Image.network(
              //   image,
              //   fit: BoxFit.cover,
              // ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      constraints: BoxConstraints(maxHeight: 30, minHeight: 10),
                      width: 110,
                      child: Text(title,
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  height: 20.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isRating
                          ? StarRating(
                              rating: ratings,
                              iconsize: 12,
                            )
                          : SizedBox(),
                      Text(time,
                          style: TextStyle(
                              fontSize: 8.sp,
                              color: Color.fromRGBO(100, 120, 47, 1)))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomLocationSelectionSheet extends StatefulWidget {
  const BottomLocationSelectionSheet({Key? key}) : super(key: key);

  @override
  State<BottomLocationSelectionSheet> createState() =>
      _BottomLocationSelectionSheetState();
}

class _BottomLocationSelectionSheetState
    extends State<BottomLocationSelectionSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    context.read<pincodeProvider>().isDisplayPin();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Delivery to :", style: TextStyle(color: Colors.grey.shade600)),
        TextButton(
          child: Text("${context.watch<pincodeProvider>().pincode}",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
          onPressed: () {
            showModalBottomSheet(
                isDismissible: true,
                isScrollControlled: true,
                context: context,
                builder: (context) => DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: .3,
                    minChildSize: 0.3,
                    maxChildSize: 0.3,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Where do you want the delivery",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(height: 7),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Select the pincode to see product availability",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w300)),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SelectLocationButton(
                                    title: "Add Address",
                                    icon: Icons.location_on_outlined,
                                    function: () {
                                      print('add address');
                                      Navigator.pushNamed(
                                          context, '/add-new-address');
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SelectLocationButton(
                                    title: "Enter Pincode",
                                    icon: Icons.location_on_outlined,
                                    function: () {
                                      Navigator.pop(context);
                                      show(context);
                                      print('enter pincode');
                                    },
                                  ),
                                  SelectLocationButton(
                                    title: "Detect Location",
                                    icon: Icons.my_location_sharp,
                                    function: () {
                                      GetLocation.getCurrentLocation(context);
                                      print('location detection');
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }));
          },
        )
      ],
    );

    // RichText(
    //     text: TextSpan(children: [
    //   TextSpan(
    //       text: "Delivery to :", style: TextStyle(color: Colors.grey.shade600)),
    //   TextSpan(
    //       text: " ${context.watch<pincodeProvider>().pincode}",
    //       style: TextStyle(color: Colors.grey.shade600),
    //       recognizer: TapGestureRecognizer()
    //         ..onTap = () async {
    //           final response = await RestaurantApi.viewAll();
    //           final pref = await SharedPreferences.getInstance();
    //           print(pref.getString('Id'));
    //           print(response);
    //           print('location select manually');
    //           showModalBottomSheet(
    //               isDismissible: true,
    //               isScrollControlled: true,
    //               context: context,
    //               builder: (context) => DraggableScrollableSheet(
    //                   expand: false,
    //                   initialChildSize: .3,
    //                   minChildSize: 0.3,
    //                   maxChildSize: 0.3,
    //                   builder: (BuildContext context,
    //                       ScrollController scrollController) {
    //                     return SingleChildScrollView(
    //                       child: Padding(
    //                         padding: const EdgeInsets.symmetric(horizontal: 20),
    //                         child: Column(
    //                           children: [
    //                             SizedBox(height: 20),
    //                             Row(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Text("Where do you want the delivery",
    //                                     style: TextStyle(
    //                                         fontSize: 14.sp,
    //                                         fontWeight: FontWeight.w600)),
    //                               ],
    //                             ),
    //                             SizedBox(height: 7),
    //                             Row(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Text(
    //                                     "Select the pincode to see product availability",
    //                                     style: TextStyle(
    //                                         fontSize: 12.sp,
    //                                         fontWeight: FontWeight.w300)),
    //                               ],
    //                             ),
    //                             SizedBox(height: 20),
    //                             Row(
    //                               mainAxisAlignment: MainAxisAlignment.center,
    //                               children: [
    //                                 SelectLocationButton(
    //                                   title: "Add Address",
    //                                   icon: Icons.location_on_outlined,
    //                                   function: () {
    //                                     print('add address');
    //                                     Navigator.pushNamed(
    //                                         context, '/add-new-address');
    //                                   },
    //                                 ),
    //                               ],
    //                             ),
    //                             SizedBox(height: 10),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceAround,
    //                               children: [
    //                                 SelectLocationButton(
    //                                   title: "Enter Pincode",
    //                                   icon: Icons.location_on_outlined,
    //                                   function: () {
    //                                     Navigator.pop(context);
    //                                     show(context);
    //                                     print('enter pincode');
    //                                   },
    //                                 ),
    //                                 SelectLocationButton(
    //                                   title: "Detect Location",
    //                                   icon: Icons.my_location_sharp,
    //                                   function: () {
    //                                     GetLocation.getCurrentLocation(context);
    //                                     print('location detection');
    //                                   },
    //                                 ),
    //                               ],
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     );
    //                   }));
    //         })
    // ]));
  }
}

class SelectLocationButton extends StatelessWidget {
  String? title;
  IconData? icon;
  Function? function;
  SelectLocationButton({Key? key, this.title, this.icon, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => function!(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6)),
          child: TextButton(
              onPressed: () => function!(),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(icon, size: 15, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  title ?? '',
                  style: TextStyle(color: Colors.green),
                )
              ])),
        )
        // Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        //     decoration: BoxDecoration(
        //         border: Border.all(width: 1, color: Colors.grey.shade400),
        //         borderRadius: BorderRadius.circular(6)),
        //     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //       Icon(icon, size: 15, color: Colors.green),
        //       SizedBox(width: 10),
        //       Text(
        //         title ?? '',
        //         style: TextStyle(color: Colors.green),
        //       )
        //     ])),
        );
  }
}

void show(BuildContext context) async {
  showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: .5,
          minChildSize: 0.5,
          maxChildSize: 0.5,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select pincode",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Container(
                      height: 65,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          context.read<PincodeSearchProvider>().getPincode(val);
                        },
                      )),
                  FutureBuilder(
                      future: context
                          .watch<PincodeSearchProvider>()
                          .searchResults(),
                      builder: ((context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<String> data = snapshot.data;
                          return ListView.builder(
                              controller: scrollController,
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: ((context, index) {
                                String pincodes = data[index];
                                return GestureDetector(
                                  onTap: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    var pin =
                                        prefs.setString("pincode", pincodes);
                                    context
                                        .read<pincodeProvider>()
                                        .updatepincode(pincodes);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/mainScreen');
                                    print(await prefs.getString("pincode"));
                                    print('pincode received');
                                  },
                                  child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20, top: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 2,
                                              color: Colors.grey.shade300)),
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          SizedBox(width: 20),
                                          Text(pincodes.toString()),
                                        ],
                                      )),
                                );
                              }));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }))
                ],
              ),
            );
          }));
}
