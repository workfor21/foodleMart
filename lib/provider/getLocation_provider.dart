// import 'package:flutter/cupertino.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// class GetLocation extends ChangeNotifier {
//   String _pincode = '';
//   String _location = 'location';

//   String get pincode => _pincode;
//   String get location => _location;

//   Future getCurrentLocation() async {
//     bool? serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled == await Geolocator.isLocationServiceEnabled();
//     if (serviceEnabled == true) {
//       Fluttertoast.showToast(msg: 'Please keep your location on.');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         Fluttertoast.showToast(msg: 'Location permission is denied.');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       Fluttertoast.showToast(msg: 'Permission is denied forever.');
//     }
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(position.latitude, position.longitude);
//       Placemark place = placemarks[0];
//       _pincode = '${place.postalCode}';
//       _location = '${place.street} ${place.postalCode}';
//       notifyListeners();
//       print(place);
//     } catch (e) {
//       print(e);
//     }
//   }
// }
