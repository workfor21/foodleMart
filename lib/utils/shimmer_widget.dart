import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/models/pincode_model.dart';
import 'package:foodle_mart/provider/pincode_provider.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/views/home/home.dart';
import 'package:foodle_mart/views/main_screen/main_screen.dart';
import 'package:foodle_mart/widgets/header.dart';
import 'package:foodle_mart/widgets/search_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatefulWidget {
  const ShimmerWidget({Key? key}) : super(key: key);

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      show(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
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
                    Color.fromRGBO(166, 206, 57, 1),
                    Color.fromRGBO(72, 170, 152, 1)
                  ]))),
              automaticallyImplyLeading: false,
              title: Image.asset("assets/icons/logo1.png"),
              actions: [
                IconButton(
                    onPressed: () {},
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
                              left: 40, top: 5, bottom: 5),
                          width: double.infinity,
                          color: Color.fromRGBO(201, 228, 125, 1),
                          child: BottomPincodeSheet())
                    ],
                  ),
                  preferredSize: Size.fromHeight(80.h))),
          body: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AspectRatio(
                      aspectRatio: 10 / 4.5,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/carousal1.png"),
                                  fit: BoxFit.cover)),
                        ),
                      )),
                  SizedBox(height: 20),
                  Container(
                    // width: double.infinity,
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: ((context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, left: 18),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                    "assets/images/carousal1.png",
                                    fit: BoxFit.cover,
                                    width: 50.w,
                                    height: 50.h)),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 20),
                  Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Headerwidget(title: "Top Restaurants")),
                  SizedBox(height: 20),
                  SizedBox(
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
                  ),
                  SizedBox(height: 20),
                  Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Headerwidget(title: "Top Restaurants")),
                  SizedBox(height: 20),
                  SizedBox(
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
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

void show(BuildContext context) async {
  final pref = await SharedPreferences.getInstance();
  pref.getString("pincode").toString().isEmpty ||
          pref.getString("pincode") == null
      ? showModalBottomSheet(
          isDismissible: false,
          isScrollControlled: true,
          context: context,
          builder: (context) => WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: .5,
                    minChildSize: 0.5,
                    maxChildSize: 0.5,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Selected pincode",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            Container(
                              height: 65,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              child: CupertinoSearchTextField(),
                            ),
                            FutureBuilder(
                                future: SearchApi.pincode(),
                                builder: ((context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    List<PincodeModel> data = snapshot.data;
                                    return ListView.builder(
                                        controller: scrollController,
                                        shrinkWrap: true,
                                        itemCount: data.length,
                                        itemBuilder: ((context, index) {
                                          PincodeModel pincodes = data[index];
                                          return GestureDetector(
                                            onTap: () async {
                                              Navigator.pushNamed(
                                                  context, '/mainScreen');
                                              final prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              var pin = prefs.setString(
                                                  "pincode", pincodes.text);
                                              context
                                                  .read<pincodeProvider>()
                                                  .getPincode(pincodes.text);
                                              print(await prefs
                                                  .getString("pincode"));
                                              print('pincode received');
                                            },
                                            child: Container(
                                                height: 50,
                                                margin: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 5),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors
                                                            .grey.shade300)),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons
                                                        .location_on_outlined),
                                                    SizedBox(width: 20),
                                                    Text(pincodes.text
                                                        .toString()),
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
                    }),
              ))
      : null;
}
