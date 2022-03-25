import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/models/home_model.dart';
import 'package:foodle_mart/models/res_model.dart';
import 'package:foodle_mart/models/restaurant_category_modal.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/utils/star_rating.dart';
import 'package:foodle_mart/views/home/home.dart';
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
            decoration: BoxDecoration(color: Color.fromRGBO(246, 219, 59, 1))),
        title: Image.asset("assets/icons/logo1.png"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                height: 50,
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                      hintText: 'Enter a search term',
                    ),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                  horizontal: 20.0,
                ),
                child: FutureBuilder(
                    future: RestaurantApi.viewAll(),
                    builder: ((context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<Nrestaurants> data = snapshot.data;
                        return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: ((context, index) {
                              Nrestaurants categoryProducts = data[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          width: 100,
                                          imageUrl:
                                              "https://ebshosting.co.in${categoryProducts.logo}",
                                          errorWidget: (context, url, error) =>
                                              Image.network(
                                            "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png",
                                            fit: BoxFit.cover,
                                          ),
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
                                            width: 180,
                                            child: Text(
                                                categoryProducts.name
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          SizedBox(height: 5.h),
                                          StarRating(
                                            rating:
                                                categoryProducts.rating ?? 3,
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                              categoryProducts.status == true
                                                  ? 'Active'
                                                  : "Not Available",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      categoryProducts.status ==
                                                              true
                                                          ? Colors.green
                                                          : Colors.red)),
                                        ],
                                      ),
                                    ],
                                  ));
                            }));
                      } else {
                        return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: 7,
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
                                              child: Text(
                                                  'categoryProducts.name',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Text(
                                                'categoryProducts.status',
                                                style: TextStyle(fontSize: 12)),
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