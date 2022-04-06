import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodle_mart/models/address_model.dart';
import 'package:foodle_mart/models/cart_modal.dart';
import 'package:foodle_mart/models/hive_cart_model.dart';
import 'package:foodle_mart/provider/cart_charges.dart';
import 'package:foodle_mart/provider/cart_notify_provider.dart';
import 'package:foodle_mart/provider/get_cart_provider.dart';
import 'package:foodle_mart/provider/pincode_provider.dart';
import 'package:foodle_mart/provider/total_amount_provider.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/repository/hive_repo.dart';
import 'package:foodle_mart/utils/pop_up_message.dart';
import 'package:foodle_mart/views/profile/address/your_address.dart';
import 'package:foodle_mart/widgets/named_button.dart';
import 'package:foodle_mart/widgets/search_button.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Cart extends StatefulWidget {
  static const routeName = '/cart';
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

final _razorpay = Razorpay();

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  // @override
  // void dispost() {
  //   super.dispose();
  //   // Hive.box('cart').close();
  //   _razorpay.clear(); // Removes all listeners
  // }

  @override
  Widget build(BuildContext context) {
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
            title: Image.asset("assets/images/foodle_logo.png", width: 70.h),
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
                        SearchButton(width: 330.w)
                      ],
                    ),
                    Container(
                        padding:
                            const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                        width: double.infinity,
                        color: Color.fromRGBO(246, 219, 59, 1),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Delivery to :",
                                style: TextStyle(fontSize: 12)),
                            Icon(Icons.location_on_outlined, size: 15),
                            Container(
                              padding: const EdgeInsets.only(top: 12),
                              width: 250,
                              height: 40,
                              child: Text(
                                  "${context.watch<pincodeProvider>().pincode}",
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ],
                        ))
                  ],
                ),
                preferredSize: Size.fromHeight(80.h))),
        body: CartBody());
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
}

// class CartBody extends HookWidget {
//   CartBody({Key? key}) : super(key: key);
//   List totalAmount = [];
//   List errorWidget = [
//     Image.asset('assets/images/empty.png'),
//     CircularProgressIndicator()
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     context.read<TotalAmount>().GetAllAmounts();
//     final totalAmount = useState(0);
//     final currentPage = useState(1);
//     final refreshHook = useState(0);
//     return FutureBuilder<CartModal?>(
//         future: context.watch<GetCartProvider>().getCart(),
//         builder: (context, AsyncSnapshot snapshot) {
//           print('cart snapshotData ::: ' + snapshot.data.toString());
//           if (snapshot.hasData) {
//             CartModal data = snapshot.data;
//             int length = data.cart!.length;
//             return Column(
//               children: [
//                 Container(
//                   constraints:
//                       BoxConstraints(maxHeight: 440.h, minHeight: 420.h),
//                   // height: MediaQuery.of(context).size.height * 3,
//                   // width: 500.h,
//                   child: ListView.builder(
//                       primary: true,
//                       shrinkWrap: true,
//                       itemCount: length,
//                       itemBuilder: ((context, index) {
//                         return Container(
//                             margin: const EdgeInsets.only(
//                                 top: 15, left: 20, right: 20, bottom: 10),
//                             width: 300.w,
//                             height: 110.h,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                     color: Colors.grey.shade200, width: 2.w)),
//                             child: CalculateTheTotal(
//                               quantity: data.cart![index].quantity ?? 1,
//                               unitText:
//                                   ' (${data.cart![index].unitname.toString()})',
//                               cartId: data.cart![index].id.toString(),
//                               image:
//                                   "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png",
//                               title: data.cart![index].productname.toString(),
//                               discountprice: data.cart![index].price == ""
//                                   ? 0
//                                   : data.cart![index].price,
//                               price: data.cart![index].offerprice == ""
//                                   ? 0
//                                   : int.parse(
//                                       data.cart![index].offerprice ?? '0'),
//                             ));
//                       })),
//                 ),
//                 Column(
//                   children: [
//                     Container(
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 20),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 5),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(
//                                 color: Colors.grey.shade200, width: 2.w)),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Delivery charges"),
//                                 Text("₹${data.deliveryCharge}"),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Taxes and Charges"),
//                                 Text("₹${data.taxValue}"),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Total Amount",
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.w600)),
//                                 Text(
//                                     "₹${context.watch<TotalAmount>().totalAmount + double.parse(data.deliveryCharge.toString()) + double.parse(data.taxValue.toString())}",
//                                     style: TextStyle(color: Colors.green))
//                               ],
//                             ),
//                           ],
//                         )),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: NamedButton(
//                         title: "Place Order",
//                         function: () {
//                           show(context);
//                           print('order placed');
//                         },
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             );
//           }
//           // else if (snapshot.data == 'no data') {
//           //   return SizedBox(
//           //       height: 470.h, child: Center(child: Text('No Data Available')));
//           // }
//           else {
//             Future.delayed(Duration(seconds: 5), () {
//               currentPage.value = 0;
//             });
//             return SizedBox(
//                 height: 470.h,
//                 child: Center(child: errorWidget[currentPage.value]));
//           }
//         });
//   }
// }

class CartBody extends HookWidget {
  CartBody({Key? key}) : super(key: key);
  List totalAmount = [];
  List errorWidget = [
    Image.asset('assets/images/empty.png'),
    CircularProgressIndicator()
  ];

  @override
  Widget build(BuildContext context) {
    context.read<TotalAmount>().GetAllAmounts();
    final totalAmount = useState(0);
    final currentPage = useState(1);
    return FutureBuilder(
        future: CartApi.getCart(),
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            CartModal data = snapshot.data;
            return Column(
              children: [
                Container(
                  constraints:
                      BoxConstraints(maxHeight: 440.h, minHeight: 420.h),
                  // height: MediaQuery.of(context).size.height * 3,
                  child: ValueListenableBuilder<Box<HiveCart>>(
                      valueListenable: Boxes.getHiveCart().listenable(),
                      builder: (context, box, _) {
                        CartModal cartList = data;
                        final cartdata = box.values.toList().cast<HiveCart>();
                        if (cartdata.length != 0) {
                          return ListView.builder(
                              primary: true,
                              shrinkWrap: true,
                              itemCount: cartdata.length,
                              itemBuilder: ((context, index) {
                                if (cartList.cart![index].productId ==
                                    cartdata[index].productId) {
                                  print(
                                      '${cartList.cart![index].productId} :: ${cartdata[index].productId}');
                                }
                                return Container(
                                    margin: const EdgeInsets.only(
                                        top: 15,
                                        left: 20,
                                        right: 20,
                                        bottom: 10),
                                    width: 300.w,
                                    height: 110.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade200,
                                            width: 2.w)),
                                    child: CalculateTheTotal(
                                      currentindex: index,
                                      cartIndex: cartdata[index].key,
                                      quantity: int.parse(
                                          cartdata[index].quantity.toString()),
                                      unitText:
                                          ' (${cartdata[index].unitname.toString()})',
                                      cartId:
                                          cartList.cart![index].id.toString(),
                                      image:
                                          "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png",
                                      title: cartdata[index]
                                          .productname
                                          .toString(),
                                      discountprice:
                                          cartdata[index].offerprice == ""
                                              ? 0
                                              : cartdata[index].price,
                                      price: cartdata[index].offerprice == ""
                                          ? 0
                                          : int.parse(
                                              cartdata[index].offerprice ??
                                                  '0'),
                                    ));
                              }));
                        } else {
                          return Center(child: Text('no cart yet..'));
                        }
                      }),
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey.shade200, width: 2.w)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Delivery charges"),
                                    Text("₹${data.deliveryCharge}"),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Taxes and Charges"),
                                    Text("₹${data.taxValue}"),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Amount",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    Text(
                                        "₹${context.watch<TotalAmount>().totalAmount + double.parse(data.deliveryCharge.toString()) + double.parse(data.taxValue.toString())}",
                                        style: TextStyle(color: Colors.green))
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: NamedButton(
                            title: "Place Order",
                            function: () {
                              show(context);
                              print('order placed');
                            },
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            );
          } else {
            Future.delayed(Duration(seconds: 3), () {
              currentPage.value = 0;
            });
            return Center(
              child: errorWidget[currentPage.value],
            );
          }
        }));
  }
}

class CalculateTheTotal extends HookWidget {
  int quantity;
  String unitText;
  String? cartId;
  String image;
  int cartIndex;
  String title;
  dynamic discountprice;
  int? price;
  int currentindex;
  CalculateTheTotal(
      {Key? key,
      required this.currentindex,
      this.quantity = 1,
      this.cartId,
      required this.cartIndex,
      this.unitText = '',
      this.image =
          "https://westsiderc.org/wp-content/uploads/2019/08/Image-Not-Available.png",
      this.title = "productName",
      this.discountprice,
      this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentNumber = useState(quantity);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          child: Image.network(
            image,
            fit: BoxFit.cover,
            width: 100.w,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        SizedBox(width: 10.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150.w,
              child: RichText(
                  text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: [TextSpan(text: title), TextSpan(text: unitText)],
              )),
            ),
            SizedBox(height: 5.h),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "₹$discountprice",
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey.shade600,
                      fontSize: 12.sp)),
              TextSpan(
                  text: " ₹${price! * currentNumber.value.toInt()}",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    // fontSize: 12.sp
                  ))
            ])),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade300, width: 2)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {
                        context.read<TotalAmount>().GetAllAmounts();
                        currentNumber.value = currentNumber.value - 1;
                        if (currentNumber.value <= 0) currentNumber.value = 1;
                        HiveCartRepo.editHiveCart(
                            currentNumber.value, cartIndex, cartId);
                      },
                      child: Container(
                          // padding: const EdgeInsets.symmetric(horizontal: 1),
                          width: 15.w,
                          height: 15.h,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Divider(
                            thickness: 2,
                            color: Colors.white,
                          ))),
                  SizedBox(width: 10),
                  Text("$quantity"),
                  SizedBox(width: 10),
                  GestureDetector(
                      onTap: () async {
                        context.read<TotalAmount>().GetAllAmounts();
                        currentNumber.value = currentNumber.value + 1;
                        if (currentNumber.value >= 10) currentNumber.value = 10;
                        print('cart cartindex ::: ' + cartIndex.toString());
                        HiveCartRepo.editHiveCart(
                            currentNumber.value, cartIndex, cartId);
                      },
                      child: Container(
                          width: 15.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child:
                              Icon(Icons.add, color: Colors.white, size: 15)))
                ],
              ),
            )
          ],
        ),
        Spacer(),
        IconButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Please Confirm.'),
                      content: Text('Are you sure to remove  the product.'),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              context.read<TotalAmount>().GetAllAmounts();
                              HiveCartRepo.deleteHivecart(cartIndex);
                              var response = await CartApi.removeCart(cartId);
                              context.read<CartNotifyProvider>().removeCount();
                              // context.watch<GetCartProvider>().getCart();
                              if (response == true) {
                                Navigator.pop(context);
                                print(response);
                              }
                            },
                            child: Text('Yes')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No')),
                      ],
                    );
                  });
            },
            icon: Icon(Icons.delete_forever_outlined,
                color: Color.fromARGB(255, 180, 51, 42))),
        SizedBox(width: 10.w),
      ],
    );
  }
}

void selectpayment(BuildContext context) async {
  showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: .2,
          minChildSize: 0.2,
          maxChildSize: 0.2,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(child: SelectPayment());
          }));
}

class SelectPayment extends StatelessWidget {
  const SelectPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Text('Payment Method',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        ),
        GestureDetector(
          onTap: () async {
            var response = await OrderApi.placeOrder('CoD');
            if (response == true) {
              Hive.close();
              flutterToast('Order placed successfuly');
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/mainScreen', (Route<dynamic> route) => false);
            } else {
              flutterToast('something went wrong..!!');
            }
          },
          child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Cash On Delivery',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen)),
                  Text('pay cash when deliver items doorsteps',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ))
                ],
              )),
        ),
      ],
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
          initialChildSize: .6,
          minChildSize: 0.6,
          maxChildSize: 0.6,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(child: AddressBody());
          }));
}

class AddressBody extends HookWidget {
  AddressBody({Key? key}) : super(key: key);
  List errorWidget = [
    Image.asset('assets/images/add_address.png'),
    CircularProgressIndicator()
  ];

  @override
  Widget build(BuildContext context) {
    final state = useState(0);
    final currentPage = useState(1);
    final isAddress = useState(false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            children: [
              Text('Select Address For Delivery',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/add-new-address');
                  print("add");
                },
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.lightGreen),
                    Text('Add new', style: TextStyle(color: Colors.lightGreen))
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
            height: 380.h,
            child: FutureBuilder(
                future: AddressApi.addressList(),
                builder: ((context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<AddressListModel> data = snapshot.data;
                    if (data.length != 0) {
                      isAddress.value = true;
                      currentPage.value = 0;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: ((context, index) {
                            AddressListModel addressList = data[index];
                            return GestureDetector(
                              onTap: () async {
                                await AddressApi.defualtAddress(
                                    addressList.id.toString());
                                state.value = index;
                              },
                              child: SelectableAddressWidget(
                                defaultAddr: addressList.addressDefault,
                                id: addressList.id.toString(),
                                addresstype: addressList.type.toString(),
                                address: addressList.address.toString(),
                                phone: addressList.mobile.toString(),
                                pincode: addressList.pincode.toString(),
                              ),
                            );
                          }));
                    } else {
                      Future.delayed(Duration(seconds: 5), () {
                        currentPage.value = 0;
                      });
                      return Center(
                          child: Center(child: errorWidget[currentPage.value]));
                    }
                  } else {
                    Future.delayed(Duration(seconds: 5), () {
                      currentPage.value = 0;
                    });
                    return Center(
                        child: Center(child: errorWidget[currentPage.value]));
                  }
                }))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: NamedButton(
            title: "Deliver here",
            function: () {
              print(isAddress.value);
              if (isAddress.value == true) {
                Navigator.pop(context);
                selectpayment(context);
                print('order placed');
              } else {
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     elevation: 2,
                //     content: Text("Please add a delivery address"),
                //     duration: Duration(seconds: 3)));
                Fluttertoast.showToast(
                    msg: 'Please add a delivery address',
                    backgroundColor: Color.fromARGB(255, 153, 202, 19));
              }
            },
          ),
        )
      ],
    );
  }
}
