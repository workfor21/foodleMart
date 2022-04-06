import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/config/routes/routes.dart';
import 'package:foodle_mart/models/cart_modal.dart';
import 'package:foodle_mart/models/hive_cart_model.dart';
import 'package:foodle_mart/provider/address_provider.dart';
import 'package:foodle_mart/provider/cart_charges.dart';
import 'package:foodle_mart/provider/cart_notify_provider.dart';
import 'package:foodle_mart/provider/getLocation_provider.dart';
import 'package:foodle_mart/provider/get_cart_provider.dart';
import 'package:foodle_mart/provider/get_otp_details_provider.dart';
import 'package:foodle_mart/provider/phone_number_provider.dart';
import 'package:foodle_mart/provider/pincode_provider.dart';
import 'package:foodle_mart/provider/pincode_search_provider.dart';
import 'package:foodle_mart/provider/product_map_provider.dart';
import 'package:foodle_mart/provider/search_all_provider.dart';
import 'package:foodle_mart/provider/total_amount_provider.dart';
import 'package:foodle_mart/views/authentication/phone.dart';
import 'package:foodle_mart/views/main_screen/main_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // String userId;
  WidgetsFlutterBinding.ensureInitialized();
  //Hive initialization
  await Hive.initFlutter();

  Hive.registerAdapter(HiveCartAdapter());
  await Hive.openBox<HiveCart>('cart');

  var prefs = await SharedPreferences.getInstance();
  print(prefs.getString('Id').toString().isNotEmpty);
  print(prefs.getString('Id'));
  var userId = prefs.getString('Id');
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PhoneProvider()),
        ChangeNotifierProvider(create: (_) => GetOtpDetails()),
        ChangeNotifierProvider(create: (_) => CartExtraCharges()),
        ChangeNotifierProvider(create: (_) => pincodeProvider()),
        ChangeNotifierProvider(create: (_) => PincodeSearchProvider()),
        ChangeNotifierProvider(create: (_) => SearchAllProvider()),
        ChangeNotifierProvider(create: (_) => TotalAmount()),
        ChangeNotifierProvider(create: (_) => ProductMapProvider()),
        ChangeNotifierProvider(create: (_) => AddressApiProvider()),
        ChangeNotifierProvider(create: (_) => GetCartProvider()),
        ChangeNotifierProvider(create: (_) => CartNotifyProvider())
      ],
      builder: (context, child) {
        // var userId = Provider.of<LoggedIn>(context).userId;
        // Future loggedIn() async {
        WidgetsFlutterBinding.ensureInitialized();
        //   var prefs = await SharedPreferences.getInstance();
        //   print(prefs.getString('Id') == null);
        //   // print(prefs.getString('Id'));
        //   userId = prefs.getString('Id').toString();
        // }

        return ScreenUtilInit(
            designSize: const Size(393, 830),
            builder: () => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: MainScreen(),
                  // DefaultTabController(length: 2, child: Phone()),
                  initialRoute: userId.toString().isEmpty || userId == null
                      ? '/phone'
                      : '/mainScreen',
                  onGenerateRoute: Routes.generateRoute,
                ));
      }));
}

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   var userId;
//   @override
//   void initState() {
//     super.initState();
//     loggedIn();
//   }

//   Future loggedIn() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     var prefs = await SharedPreferences.getInstance();
//     print(prefs.getString('Id') == null);
//     // print(prefs.getString('Id'));
//     userId = prefs.getString('Id') == null ? true : false;
//   }

//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//         designSize: const Size(393, 830),
//         builder: () => MaterialApp(
//               debugShowCheckedModeBanner: false,
//               home: DefaultTabController(length: 4, child: Phone()),
//               initialRoute: userId == null ? '/login' : 'mainScreen',
//               onGenerateRoute: Routes.generateRoute,
//             ));
//   }
// }
