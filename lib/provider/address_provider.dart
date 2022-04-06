import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:foodle_mart/config/constants/api_configurations.dart';
import 'package:foodle_mart/models/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddressApiProvider extends ChangeNotifier {
  Future address() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('Id');
    var response = await http
        .post(Uri.parse(Api.address.getAddress), body: {"user_id": userId});
    var responseBody = json.decode(response.body);

    // print(responseBody['address']);
    print("response : -");
    List<AddressListModel> addressList = [];
    for (var i in responseBody['address']) {
      addressList.add(AddressListModel.fromJson(i));
    }

    return addressList;
  }

  notifyListeners();
}
