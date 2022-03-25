// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) =>
    StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  StateModel({
    this.sts,
    this.msg,
    this.districts,
  });

  String? sts;
  String? msg;
  List<District>? districts;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        sts: json["sts"],
        msg: json["msg"],
        districts: List<District>.from(
            json["districts"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sts": sts,
        "msg": msg,
        "districts": List<dynamic>.from(districts!.map((x) => x.toJson())),
      };
}

class District {
  District({
    this.id,
    this.country,
    this.state,
    this.name,
  });

  int? id;
  int? country;
  int? state;
  String? name;

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        country: json["country"],
        state: json["state"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "state": state,
        "name": name,
      };
}
