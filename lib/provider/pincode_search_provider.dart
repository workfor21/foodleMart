import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:foodle_mart/config/constants/api_configurations.dart';
import 'package:http/http.dart' as http;

class PincodeSearchProvider extends ChangeNotifier {
  String _pincode = '';

  String get pincode => _pincode;

  Future<List<String>?> searchResults() async {
    print('working0');
    var response = await http.get(Uri.parse(Api.search.pincodes));
    var responseBody = json.decode(response.body);
    print('working0.1');

    List<String> results = [];
    print('working1');
    List<String> searchResults = [];
    print('working');
    print(responseBody);

    for (var i in responseBody['results']) {
      results.add(i['text']);
    }

    print(results);

    for (var i in results) {
      if (i.contains(_pincode)) {
        searchResults.add(i);
      }
    }

    print("results" + results.toString());
    print('searchResults' + searchResults.toString());
    return searchResults;
    // if (_pincode.isEmpty) {
    //   return results;
    // } else {
    //   return searchResults;
    // }
  }

  void getPincode(pincode) {
    _pincode = pincode;
    notifyListeners();
  }
}
