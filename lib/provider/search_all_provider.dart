import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:foodle_mart/config/constants/api_configurations.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchAllProvider extends ChangeNotifier {
  String _query = '';

  Future<List> SearchResults() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("Id");
    final pincode = prefs.getString("pincode");
    var response = await http.post(Uri.parse(Api.search.allsearch),
        body: {"user_id": userId, "pincode": pincode});
    var responseBody = json.decode(response.body);
    print(responseBody);
    List results = [];
    List searchResults = [];
    // for (var i in responseBody['superCategories']) {
    //   i['type'] = 'supermarket';
    //   results.add(i);
    // }
    // for (var i in responseBody['restCategories']) {
    //   i['type'] = 'restaurant';
    //   results.add(i);
    // }
    for (var i in responseBody['restaurants']) {
      i['type'] = 'restaurant';
      results.add(i);
    }
    for (var i in responseBody['supermarkets']) {
      i['type'] = 'supermarket';
      results.add(i);
    }
    // for (var i in responseBody['restproducts']) {
    //   i['type'] = 'restaurant';
    //   results.add(i);
    // }
    // for (var i in responseBody['superproducts']) {
    //   i['type'] = 'restaurant';
    //   results.add(i);
    // }
    for (var i in results) {
      if (i['name'].toString().toLowerCase().contains(_query.toLowerCase())) {
        // print('$_query + ${i['name'].toString().toLowerCase()}');
        print(i);
        searchResults.add(i);
      }
    }
    print(_query.length);
    if (_query.length == 0) {
      // print('results printed');
      return results;
    } else {
      return searchResults;
    }
  }

  void getQuery(query) {
    _query = query;
    notifyListeners();
  }
}
