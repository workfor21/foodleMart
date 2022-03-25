import 'dart:convert';

class PincodeModel {
  PincodeModel({
    required this.text,
  });

  String text;

  static PincodeModel fromJson(Map<String, dynamic> json) => PincodeModel(
        text: json["text"],
      );
}
