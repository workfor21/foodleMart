// To parse this JSON data, do
//
//     final searchAllModel = searchAllModelFromJson(jsonString);

import 'dart:convert';

SearchAllModel searchAllModelFromJson(String str) =>
    SearchAllModel.fromJson(json.decode(str));

String searchAllModelToJson(SearchAllModel data) => json.encode(data.toJson());

class SearchAllModel {
  SearchAllModel({
    this.sts,
    this.msg,
    this.restCategories,
    this.superCategories,
    this.restaurants,
    this.supermarkets,
    this.restproducts,
    this.superproducts,
  });

  String? sts;
  String? msg;
  List<Category>? restCategories;
  List<Category>? superCategories;
  List<Supermarket>? restaurants;
  List<Supermarket>? supermarkets;
  List<Product>? restproducts;
  List<Product>? superproducts;

  factory SearchAllModel.fromJson(Map<String, dynamic> json) => SearchAllModel(
        sts: json["sts"],
        msg: json["msg"],
        restCategories: List<Category>.from(
            json["restCategories"].map((x) => Category.fromJson(x))),
        superCategories: List<Category>.from(
            json["superCategories"].map((x) => Category.fromJson(x))),
        restaurants: List<Supermarket>.from(
            json["restaurants"].map((x) => Product.fromJson(x))),
        supermarkets: List<Supermarket>.from(
            json["supermarkets"].map((x) => Supermarket.fromJson(x))),
        restproducts: List<Product>.from(
            json["restproducts"].map((x) => Product.fromJson(x))),
        superproducts: List<Product>.from(
            json["superproducts"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sts": sts,
        "msg": msg,
        "restCategories":
            List<dynamic>.from(restCategories!.map((x) => x.toJson())),
        "superCategories":
            List<dynamic>.from(superCategories!.map((x) => x.toJson())),
        "restaurants": List<dynamic>.from(restaurants!.map((x) => x.toJson())),
        "supermarkets":
            List<dynamic>.from(supermarkets!.map((x) => x.toJson())),
        "restproducts":
            List<dynamic>.from(restproducts!.map((x) => x.toJson())),
        "superproducts":
            List<dynamic>.from(superproducts!.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.image,
  });

  int? id;
  String? name;
  String? image;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}

class Product {
  Product({
    this.id,
    this.name,
    this.type,
    this.image,
    this.restname,
    this.supername,
  });

  int? id;
  String? name;
  String? type;
  String? image;
  String? restname;
  String? supername;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        image: json["image"],
        restname: json["restname"] == null ? null : json["restname"],
        supername: json["supername"] == null ? null : json["supername"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "image": image,
        "restname": restname == null ? null : restname,
        "supername": supername == null ? null : supername,
      };
}

class Supermarket {
  Supermarket({
    this.id,
    this.name,
    this.image,
    this.rating,
  });

  int? id;
  String? name;
  String? image;
  int? rating;

  factory Supermarket.fromJson(Map<String, dynamic> json) => Supermarket(
        id: json["id"],
        name: json["name"],
        image: json["logo"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "rating": rating,
      };
}
