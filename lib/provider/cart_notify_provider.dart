import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:foodle_mart/config/constants/api_configurations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartNotifyProvider extends ChangeNotifier {
  bool _isCart = false;
  int _count = 0;

  bool get isCart => _isCart;
  int get count => _count;

  void addCount() {
    _count += 1;
    _isCart = true;
    notifyListeners();
  }

  void removeCount() {
    _count -= 1;
    if (_count == 0) {
      _isCart = false;
    } else if (_count < 0) {
      _count = 0;
    }
    notifyListeners();
  }
}
