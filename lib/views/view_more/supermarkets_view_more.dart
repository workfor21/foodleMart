import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/models/res_model.dart';
import 'package:foodle_mart/models/restaurant_category_modal.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/views/home/home.dart';
import 'package:foodle_mart/views/notification/notification.dart';
import 'package:foodle_mart/widgets/search_button.dart';

class SupermarketsViewMore extends StatelessWidget {
  static const routeName = '/supermarketsviewmore';
  const SupermarketsViewMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
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
          automaticallyImplyLeading: false,
          title: Image.asset("assets/images/foodle_logo.png", width: 70.w),
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
                      color: Color.fromARGB(255, 255, 226, 58),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SuperMarkets List",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          // Image.asset("assets/icons/filter.png")
                        ],
                      ))
                ],
              ),
              preferredSize: Size.fromHeight(80.h))),
      body: FutureBuilder(
          future: SupermarketApi.viewAll(),
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Nrestaurants> data = snapshot.data;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    Nrestaurants products = data[index];
                    return GestureDetector(
                      onTap: () {
                        if (products.status == true) {
                          Navigator.pushNamed(context, '/supermarket-view-post',
                              arguments: products.id.toString());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'This supermarket is currently unAvailable.'),
                            duration: Duration(seconds: 1),
                          ));
                        }
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
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  fit: BoxFit.contain,
                                  width: 100,
                                  // height: 50,
                                  imageUrl:
                                      "https://ebshosting.co.in${products.logo}",
                                  errorWidget: (context, url, error) =>
                                      Image.asset('assets/images/empty.png',
                                          fit: BoxFit.cover, width: 100.h),
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Text(products.name.toString(),
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                      products.status == true
                                          ? 'Available'
                                          : 'NotAvaiable',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: products.status == true
                                              ? Colors.green
                                              : Colors.red)),
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
            } else if (snapshot.data == null) {
              return const Center(child: Text(" Not Available"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })),
    );
  }
}
