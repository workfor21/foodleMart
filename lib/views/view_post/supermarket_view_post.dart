import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/models/supermarket_model.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/utils/star_rating.dart';

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
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            int categoryLength = data?.category!.values.length ?? 0;
            final shop = data!.shop;
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
                              const Color.fromARGB(218, 166, 206, 57),
                              Color.fromARGB(195, 72, 170, 152)
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
                      height: 100,
                      width: 100,
                      imageUrl: "https://ebshosting.co.in/${image.toString()}",
                      errorWidget: (context, url, error) => Image.network(
                          "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"),
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
            SizedBox(width: 15),
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
                          color: status == "available"
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
                                    fontWeight: FontWeight.w500)))),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
