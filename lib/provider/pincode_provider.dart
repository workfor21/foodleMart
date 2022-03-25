import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pincodeProvider extends ChangeNotifier {
  String _pincode = '';

  String get pincode => _pincode;

  Future getPincode(pincode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _pincode = pincode.toString().isEmpty
        ? prefs.getString('pincode').toString()
        : pincode.toString();
    notifyListeners();
  }
}
