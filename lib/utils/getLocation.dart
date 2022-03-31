import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodle_mart/provider/pincode_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetLocation {
  static Future getCurrentLocation(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? serviceEnabled;
    LocationPermission permission;

    serviceEnabled == await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled == true) {
      Fluttertoast.showToast(msg: 'Please keep your location on.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permission is denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Permission is denied forever.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      var pincode = '${place.postalCode}';
      var location = '${place.street} ${place.postalCode}';
      print(location);
      prefs.setString('display_pin', pincode);
      prefs.setString('location', location);
      context.read<pincodeProvider>().setDummy(location);
      print(place);
    } catch (e) {
      print(e);
    }
  }
}
