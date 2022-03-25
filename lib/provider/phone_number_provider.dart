import 'package:flutter/cupertino.dart';

class PhoneProvider extends ChangeNotifier {
  String _number = '';

  String get phone => _number;

  void getNumber(String number) {
    _number = number;
    notifyListeners();
  }
}
