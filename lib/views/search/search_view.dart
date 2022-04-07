import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodle_mart/models/home_model.dart';
import 'package:foodle_mart/models/res_model.dart';
import 'package:foodle_mart/models/restaurant_category_modal.dart';
import 'package:foodle_mart/provider/search_all_provider.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/views/home/home.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
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
          title: Text('Search',
              style: TextStyle(fontSize: 16, color: Colors.black))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                height: 40,
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                        hintStyle: TextStyle(fontSize: 12),
                        hintText: 'Search for restaurants, supermarkets',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/icons/search.svg',
                          ),
                        )),
                    onChanged: (value) {
                      context.read<SearchAllProvider>().getQuery(value);
                      // print(value);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                  height: 90.h,
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
                                        "https://ebshosting.co.in/${category.image}");
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: FutureBuilder(
                    future: context.watch<SearchAllProvider>().SearchResults(),
                    builder: ((context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List data = snapshot.data;
                        return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: ((context, index) {
                              final products = data[index];
                              return GestureDetector(
                                onTap: () {
                                  products['type'] == 'restaurant'
                                      ? Navigator.pushNamed(
                                          context, '/restuarant-view-post',
                                          arguments: products['id'].toString())
                                      : Navigator.pushNamed(
                                          context, '/supermarket-view-post',
                                          arguments: products['id'].toString());
                                  print('redirection');
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(
                                      top: 15,
                                    ),
                                    width: 300.w,
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade200,
                                            width: 2.w)),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.contain,
                                            width: 100,
                                            // height: 50,
                                            imageUrl: products['type'] ==
                                                    'restaurant'
                                                ? "https://ebshosting.co.in${products['logo']}"
                                                : "https://ebshosting.co.in${products['image']}",
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    'assets/images/empty.png',
                                                    width: 100.h,
                                                    fit: BoxFit.cover),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                  products['name'].toString(),
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            SizedBox(height: 5.h),
                                            // Text(
                                            //     products['rating']
                                            //         .toString(),
                                            //     style: TextStyle(fontSize: 12.sp)),
                                            SizedBox(height: 5.h),
                                            // StarRating(
                                            //   rating: resturants.rating!.toDouble(),
                                            // )
                                          ],
                                        ),
                                      ],
                                    )),
                              );
                            }));
                      } else {
                        return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: ((context, index) {
                            return Container(
                                margin: const EdgeInsets.only(
                                  top: 15,
                                ),
                                width: 300.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey.shade200,
                                        width: 2.w)),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                            "assets/images/carousal1.png",
                                            width: 90,
                                            height: 90,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: SizedBox(
                                              width: 150,
                                              height: 0,
                                              child: Text('',
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Text('',
                                                style:
                                                    TextStyle(fontSize: 12.sp)),
                                          ),
                                          SizedBox(height: 5.h),
                                          // StarRating(
                                          //   rating: resturants.rating!.toDouble(),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                          }),
                        );
                      }
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
