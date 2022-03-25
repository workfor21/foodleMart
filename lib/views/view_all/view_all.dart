import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/models/restaurant_category_modal.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/views/home/home.dart';
import 'package:foodle_mart/views/notification/notification.dart';
import 'package:foodle_mart/widgets/search_button.dart';

class ViewAll extends StatelessWidget {
  static const routeName = '/viewall';
  const ViewAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
              decoration:
                  BoxDecoration(color: Color.fromRGBO(246, 219, 59, 1))),
          automaticallyImplyLeading: false,
          title: Image.asset("assets/images/foodle_logo.png", width: 90),
          bottom: PreferredSize(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back)),
                      SearchButton(width: 330)
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.only(
                          left: 40, top: 5, bottom: 5, right: 30),
                      width: double.infinity,
                      color: Color.fromARGB(255, 246, 227, 59),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category List",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          // Image.asset("assets/icons/filter.png")
                        ],
                      ))
                ],
              ),
              preferredSize: Size.fromHeight(80.h))),
      body: FutureBuilder(
          future: RestaurantApi.restaurantCategory(arguments),
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<ProductModal> data = snapshot.data;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    ProductModal categoryProducts = data[index];
                    return Container(
                        margin:
                            const EdgeInsets.only(top: 15, left: 20, right: 20),
                        width: 300.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.grey.shade200, width: 2.w)),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.contain,
                                width: 100,
                                // height: 50,
                                imageUrl:
                                    "https://ebshosting.co.in${categoryProducts.image}",
                                errorWidget: (context, url, error) =>
                                    Image.network(
                                  "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Image.network(
                            //   categoryProducts.image.toString().isEmpty ||
                            //           categoryProducts.image == null
                            //       ? "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"
                            //       : "https://ebshosting.co.in${categoryProducts.image}",
                            //   fit: BoxFit.cover,
                            // ),
                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(categoryProducts.name.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                ),
                                SizedBox(height: 5.h),
                                Text(categoryProducts.status.toString(),
                                    style: TextStyle(fontSize: 12)),
                                SizedBox(height: 5.h),
                                // StarRating(
                                //   rating: resturants.rating!.toDouble(),
                                // )
                              ],
                            ),
                          ],
                        ));
                  }));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })),
    );
  }
}
