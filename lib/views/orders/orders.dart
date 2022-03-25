import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/models/order_list_model.dart';
import 'package:foodle_mart/models/orders_model.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/views/cart/cart.dart';
import 'package:foodle_mart/views/notification/notification.dart';
import 'package:foodle_mart/widgets/search_button.dart';

class Orders extends StatelessWidget {
  static const routeName = '/orders';
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    print('notification');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => NotificationScreen()));
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
                    SearchButton(),
                    Container(
                        padding: const EdgeInsets.only(
                            left: 40, top: 5, bottom: 5, right: 30),
                        width: double.infinity,
                        color: Color.fromARGB(255, 246, 227, 59),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Your Orders",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Image.asset("assets/icons/filter.png")
                          ],
                        ))
                  ],
                ),
                preferredSize: Size.fromHeight(80.h))),
        body: FutureBuilder(
          future: OrderApi.allOrder(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print('snapshot');
              print(snapshot.data);
              OrderListModel data = snapshot.data;
              return ListView.builder(
                  itemCount: data.orders.length,
                  itemBuilder: ((context, index) {
                    final orders = data.orders[index];
                    return Container(
                        margin: const EdgeInsets.only(
                            top: 5, left: 20, right: 20, bottom: 5),
                        width: 300.w,
                        // height: 100.h,
                        // constraints: BoxC,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.grey.shade200, width: 2.w)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://ebshosting.co.in/${orders.shop?.logo}",
                                  placeholder: (context, url) => Image.network(
                                      "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png",
                                      fit: BoxFit.cover,
                                      height: 120.h),
                                  errorWidget: (context, url, error) =>
                                      Image.network(
                                          "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png",
                                          fit: BoxFit.cover,
                                          height: 120.h),
                                ),
                              ),
                              // Image.network(
                              //   "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png"
                              //   // 'https://ebshosting.co.in/${orders.shop?.logo}'
                              //   ,
                              //   fit: BoxFit.contain,
                              //   width: 60,
                              //   height: 60,
                              // ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(orders.shop!.name ?? '',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(height: 5.h),
                                  Text(orders.shop!.deliveryTime ?? '',
                                      style: TextStyle(fontSize: 12)),
                                  SizedBox(height: 8.h),
                                  Text(orders.status ?? 'pending',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.red)),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text("₹${orders.amount ?? 'N/A'}",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600))),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Order Canceled.'),
                                          duration: Duration(seconds: 1),
                                        ));
                                        print("close");
                                      },
                                      icon: Icon(Icons.cancel_rounded,
                                          size: 20,
                                          color: Colors.grey.shade800)),
                                ],
                              ),
                            )
                          ],
                        ));
                  }));
            } else {
              return
                  // Center(child: CircularProgressIndicator());
                  Center(
                      child: Text('No orders yet!!',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)));
            }
          },
        ));
  }
}
