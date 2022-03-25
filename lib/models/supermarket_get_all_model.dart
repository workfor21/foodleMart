// To parse this JSON data, do
//
//     final superMarketGetAllModel = superMarketGetAllModelFromJson(jsonString);

import 'dart:convert';

SuperMarketGetAllModel superMarketGetAllModelFromJson(String str) =>
    SuperMarketGetAllModel.fromJson(json.decode(str));

String superMarketGetAllModelToJson(SuperMarketGetAllModel data) =>
    json.encode(data.toJson());

class SuperMarketGetAllModel {
  SuperMarketGetAllModel({
    this.sts,
    this.msg,
    this.cartcount,
    this.supermarkets,
    this.nsupermarkets,
  });

  String? sts;
  String? msg;
  int? cartcount;
  List<Supermarket>? supermarkets;
  List<Supermarket>? nsupermarkets;

  factory SuperMarketGetAllModel.fromJson(Map<String, dynamic> json) =>
      SuperMarketGetAllModel(
        sts: json["sts"],
        msg: json["msg"],
        cartcount: json["cartcount"],
        supermarkets: List<Supermarket>.from(
            json["supermarkets"].map((x) => Supermarket.fromJson(x))),
        nsupermarkets: List<Supermarket>.from(
            json["nsupermarkets"].map((x) => Supermarket.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sts": sts,
        "msg": msg,
        "cartcount": cartcount,
        "supermarkets":
            List<dynamic>.from(supermarkets!.map((x) => x.toJson())),
        "nsupermarkets":
            List<dynamic>.from(nsupermarkets!.map((x) => x.toJson())),
      };
}

class Supermarket {
  Supermarket({
    this.id,
    this.name,
    this.logo,
    this.deliveryTime,
    this.promoted,
  });

  int? id;
  String? name;
  String? logo;
  String? deliveryTime;
  String? promoted;

  factory Supermarket.fromJson(Map<String, dynamic> json) => Supermarket(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        deliveryTime: json["delivery_time"],
        promoted: json["promoted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "delivery_time": deliveryTime,
        "promoted": promoted,
      };
}
