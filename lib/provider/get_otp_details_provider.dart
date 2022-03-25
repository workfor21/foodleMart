import 'package:flutter/material.dart';

class GetOtpDetails extends ChangeNotifier {
  String _number = '';
  String _name = '';
  String _email = '';

  String get phone => _number;
  String get email => _email;
  String get name => _name;

  void getDetails(name, email, number) {
    _number = number;
    _email = email;
    _name = name;
    notifyListeners();
  }
}
