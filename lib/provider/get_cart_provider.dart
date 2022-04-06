import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:foodle_mart/config/constants/api_configurations.dart';
import 'package:foodle_mart/models/cart_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetCartProvider extends ChangeNotifier {
  Future<CartModal?> getCart() async {
    // try {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("Id");
    var response =
        await http.post(Uri.parse(Api.cart.getcart), body: {"user_id": userId});

    print('cart respons :::: ${response.body}');
    Map<String, dynamic> data = json.decode(response.body);
    return CartModal.fromJson(data);
  }
}
