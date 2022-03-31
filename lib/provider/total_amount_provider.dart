import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:foodle_mart/config/constants/api_configurations.dart';
import 'package:foodle_mart/models/cart_modal.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TotalAmount extends ChangeNotifier {
  double _totalAmount = 0;

  double get totalAmount => _totalAmount;

  Future<dynamic> GetAllAmounts() async {
    _totalAmount = 0;
    List<dynamic> _allAmount = [];
    final prefs = await SharedPreferences.getInstance();
    final userId = await prefs.getString('Id');
    var response =
        await http.post(Uri.parse(Api.cart.getcart), body: {"user_id": userId});
    var responseBody = json.decode(response.body);
    // print(responseBody['cart']);
    for (var i in responseBody['cart']) {
      print(i['offerprice'] * i['quantity']);
      var amount = (i['offerprice'] as num) * (i['quantity'] as num);
      _allAmount.add(amount);
    }

    _allAmount.forEach((e) => _totalAmount += e);
    print(_allAmount);
    print(_totalAmount);
    notifyListeners();
    return _totalAmount;
  }
}
