import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:foodle_mart/config/constants/api_configurations.dart';
import 'package:foodle_mart/models/cart_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProductMapProvider extends ChangeNotifier {
  Future<dynamic> getCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('Id');
      var response = await http
          .post(Uri.parse(Api.cart.getcart), body: {"user_id": userId});
      var responseBody = json.decode(response.body);

      responseBody['cart'].map((e) {
        print(e);
      });

      // print('cart api');
      // print(responseBody['cart']);

      // List<CartListModal> cartList = [];
      // for (var i in responseBody['cart']) {
      //   cartList.add(CartListModal.fromJson(i));
      // }

      print('cart respons :::: ${response.body}');
      Map<String, dynamic> data = json.decode(response.body);
      return CartModal.fromJson(data);
    } catch (e) {
      return null;
    }
  }
}
