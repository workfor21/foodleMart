import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/models/home_model.dart';
import 'package:foodle_mart/models/res_model.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/utils/star_rating.dart';
import 'package:foodle_mart/widgets/search_button.dart';

class NearYou extends StatelessWidget {
  static const routeName = '/near-you';
  const NearYou({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            flexibleSpace: Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(246, 219, 59, 1))),
            automaticallyImplyLeading: false,
            title: Image.asset("assets/images/foodle_logo.png", width: 90),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/notification');
                  },
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
                        child: Text(
                          arguments == true
                              ? 'Restuarants near you'
                              : "Supermarkets near you",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
                preferredSize: Size.fromHeight(80.h))),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FutureBuilder(
              future: arguments == true
                  ? RestaurantApi.viewAll()
                  : SupermarketApi.viewAll(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        Nrestaurants resturants = data[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context,
                                arguments == true
                                    ? '/restuarant-view-post'
                                    : '/supermarket-view-post',
                                arguments: resturants.id.toString());
                          },
                          child: Container(
                              margin: const EdgeInsets.only(
                                  top: 15, left: 20, right: 20),
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
                                      imageUrl:
                                          "https://ebshosting.co.in${resturants.logo}",
                                      errorWidget: (context, url, error) =>
                                          Image.network(
                                              "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"),
                                    ),
                                  ),
                                  // Image.network(
                                  //   resturants.logo.toString().isEmpty ||
                                  //           resturants.logo == null
                                  //       ? "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"
                                  //       : "https://ebshosting.co.in${resturants.logo}",
                                  //   fit: BoxFit.cover,
                                  // ),
                                  SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(resturants.name.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(resturants.deliveryTime.toString(),
                                          style: TextStyle(fontSize: 12)),
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
                  return Center(child: Text('No Data Available'));
                }
              })),
        ));
  }
}
