import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pincodeProvider extends ChangeNotifier {
  String _pincode = '';
  String _display = 'location';

  String get pincode => _display;

  void isDisplayPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('display_pin').toString().isEmpty
        ? _display = 'location'
        : _display = prefs.getString('display_pin').toString();
    if (prefs.getString('display_pin')!.isEmpty ||
        prefs.getString('pincode')!.isEmpty) {
      // print('both empty');
      // print('display_pin'+ prefs.getString('display_pin').toString())
      _display = 'location';
    } else if (prefs.getString('location')!.isNotEmpty) {
      _display = prefs.getString('location')!;
    } else if (prefs.getString('pincode')!.isNotEmpty) {
      _display = prefs.getString('pincode')!;
    }
    notifyListeners();
  }

  void getPincode(pincode) async {
    _pincode = pincode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pincode', _pincode);
    notifyListeners();
  }

  void setDummy(dummy) {
    _display = dummy;
    notifyListeners();
  }

  void updatepincode(pincode) async {
    _pincode = pincode;
    _display = pincode.toString();
    notifyListeners();
  }

  void updateLocation(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('location', location);
    _display = location;
    notifyListeners();
  }
}
