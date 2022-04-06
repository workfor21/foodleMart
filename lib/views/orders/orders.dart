import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/models/order_list_model.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/views/cart/cart.dart';
import 'package:foodle_mart/views/notification/notification.dart';
import 'package:foodle_mart/widgets/search_button.dart';

class Orders extends StatefulWidget {
  static const routeName = '/orders';
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var currentPage = 1;
  List errorWidget = [
    Image.asset('assets/images/empty.png'),
    CircularProgressIndicator()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changepage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     elevation: 0,
        //     flexibleSpace: Container(
        //         decoration: BoxDecoration(
        //             gradient: LinearGradient(
        //                 begin: Alignment.topLeft,
        //                 end: Alignment.bottomRight,
        //                 colors: <Color>[
        //           Color.fromRGBO(166, 206, 57, 1),
        //           Color.fromRGBO(72, 170, 152, 1)
        //         ]))),
        //     automaticallyImplyLeading: false,
        //     title: Image.asset("assets/icons/logo1.png"),
        //     actions: [
        //       IconButton(
        //           onPressed: () {
        //             print('notification');
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (_) => NotificationScreen()));
        //           },
        //           icon: Icon(Icons.notifications_none, color: Colors.black)),
        //       IconButton(
        //           onPressed: () {
        //             Navigator.push(
        //                 context, MaterialPageRoute(builder: (_) => Cart()));
        //           },
        //           icon: Icon(Icons.local_grocery_store_outlined,
        //               color: Colors.black)),
        //     ],
        //     bottom: PreferredSize(
        //         child: Column(
        //           children: [
        //             SearchButton(),
        //             Container(
        //                 padding: const EdgeInsets.only(
        //                     left: 40, top: 5, bottom: 5, right: 30),
        //                 width: double.infinity,
        //                 color: Color.fromRGBO(201, 228, 125, 1),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text(
        //                       "Your Items",
        //                       style: TextStyle(fontWeight: FontWeight.w500),
        //                     ),
        //                     // Image.asset("assets/icons/filter.png")
        //                   ],
        //                 ))
        //           ],
        //         ),
        //         preferredSize: Size.fromHeight(80.h))),
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
                              errorWidget: (context, url, error) => Image.asset(
                                  'assets/images/empty.png',
                                  fit: BoxFit.cover,
                                  height: 100.h),
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
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5.h),
                              Text(orders.shop!.deliveryTime ?? '',
                                  style: TextStyle(fontSize: 10.sp)),
                              SizedBox(height: 5.h),
                              Text(orders.status ?? 'pending',
                                  style: TextStyle(
                                      fontSize: 10.sp, color: Colors.red)),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Text("₹${orders.amount ?? 'N/A'}",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600))),
                        orders.status == 'Rejected' ||
                                orders.status == 'Cancelled'
                            ? const SizedBox()
                            : Expanded(
                                flex: 2,
                                child: Container(
                                  height: 100.h,
                                  // color: Colors.blue,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        Text('Please Confirm.'),
                                                    content: Text(
                                                        'Are you sure to remove  the order.'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () async {
                                                            // var response = await CartApi.removeCart(cartId);
                                                            // if (response == true) {
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                  'Order Canceled.'),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          1),
                                                            ));
                                                            print("close");
                                                            //   print(response);
                                                            // }
                                                          },
                                                          child: Text('Yes')),
                                                      TextButton(
                                                          onPressed: () {},
                                                          child: Text('No')),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: Icon(Icons.cancel_rounded,
                                              size: 20,
                                              color: Colors.grey.shade800)),
                                    ],
                                  ),
                                ),
                              )
                      ],
                    ));
              }));
        } else {
          return
              // Center(child: CircularProgressIndicator());
              Center(child: Center(child: errorWidget[currentPage]));
        }
      },
    ));
  }

  void changepage() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        currentPage = 0;
      });
    });
  }
}
