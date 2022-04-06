import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void flutterToast(String message) {
  Fluttertoast.showToast(
      msg: message, backgroundColor: Color.fromARGB(255, 153, 202, 19));
}
