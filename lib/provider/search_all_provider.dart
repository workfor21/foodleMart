import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:foodle_mart/config/constants/api_configurations.dart';
import 'package:http/http.dart' as http;

class SearchAllProvider extends ChangeNotifier {
  String _query = '';

  void getQuery(query) {
    _query = query;
  }

  Future<List<String>?> SearchResults() async {
    var response = await http.post(Uri.parse(Api.search.allsearch));
    var responseBody = json.decode(response.body);

    List<String> results = [];
    List<String> searchResults = [];

    for (var i in responseBody['superCategories']) {
      // results.add(i[])
    }
    print(responseBody);
  }
}
