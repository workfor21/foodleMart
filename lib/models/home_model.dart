// To parse this JSON data, do
//
//     final supermarketModel = supermarketModelFromJson(jsonString);

import 'dart:convert';

SupermarketModel supermarketModelFromJson(String str) =>
    SupermarketModel.fromJson(json.decode(str));

String supermarketModelToJson(SupermarketModel data) =>
    json.encode(data.toJson());

class SupermarketModel {
  SupermarketModel({
    this.sts,
    this.msg,
    this.cartcount,
    this.categories,
    this.fbanners,
    this.sbanners,
    this.restaurants,
    this.nrestaurants,
    this.supermarkets,
    this.nsupermarkets,
    this.restproducts,
    this.nrestproducts,
  });

  String? sts;
  String? msg;
  int? cartcount;
  List<CategoryModel>? categories;
  List<BannerModel>? fbanners;
  List<BannerModel>? sbanners;
  List<Nrestaurant>? restaurants;
  List<Nrestaurant>? nrestaurants;
  List<Nrestaurant>? supermarkets;
  List<dynamic>? nsupermarkets;
  List<RestproductModel>? restproducts;
  List<dynamic>? nrestproducts;

  factory SupermarketModel.fromJson(Map<String, dynamic> json) =>
      SupermarketModel(
        sts: json["sts"],
        msg: json["msg"],
        cartcount: json["cartcount"],
        categories: List<CategoryModel>.from(
            json["categories"].map((x) => CategoryModel.fromJson(x))),
        fbanners: List<BannerModel>.from(
            json["fbanners"].map((x) => BannerModel.fromJson(x))),
        sbanners: List<BannerModel>.from(
            json["sbanners"].map((x) => BannerModel.fromJson(x))),
        restaurants: List<Nrestaurant>.from(
            json["restaurants"].map((x) => Nrestaurant.fromJson(x))),
        nrestaurants: List<Nrestaurant>.from(
            json["nrestaurants"].map((x) => Nrestaurant.fromJson(x))),
        supermarkets: List<Nrestaurant>.from(
            json["supermarkets"].map((x) => Nrestaurant.fromJson(x))),
        nsupermarkets: List<dynamic>.from(json["nsupermarkets"].map((x) => x)),
        restproducts: List<RestproductModel>.from(
            json["restproducts"].map((x) => RestproductModel.fromJson(x))),
        nrestproducts: List<dynamic>.from(json["nrestproducts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sts": sts,
        "msg": msg,
        "cartcount": cartcount,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "fbanners": List<dynamic>.from(fbanners!.map((x) => x.toJson())),
        "sbanners": List<dynamic>.from(sbanners!.map((x) => x.toJson())),
        "restaurants": List<dynamic>.from(restaurants!.map((x) => x.toJson())),
        "nrestaurants":
            List<dynamic>.from(nrestaurants!.map((x) => x.toJson())),
        "supermarkets":
            List<dynamic>.from(supermarkets!.map((x) => x.toJson())),
        "nsupermarkets": List<dynamic>.from(nsupermarkets!.map((x) => x)),
        "restproducts":
            List<dynamic>.from(restproducts!.map((x) => x.toJson())),
        "nrestproducts": List<dynamic>.from(nrestproducts!.map((x) => x)),
      };
}

class CategoryModel {
  CategoryModel({
    this.id,
    this.type,
    this.name,
    this.dispOrder,
    this.image,
  });

  int? id;
  CategoryType? type;
  String? name;
  int? dispOrder;
  String? image;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        type: categoryTypeValues.map[json["type"]],
        name: json["name"],
        dispOrder: json["disp_order"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": categoryTypeValues.reverse![type],
        "name": name,
        "disp_order": dispOrder,
        "image": image,
      };
}

enum CategoryType { RESTAURANT }

final categoryTypeValues = EnumValues({"Restaurant": CategoryType.RESTAURANT});

class BannerModel {
  BannerModel({
    this.id,
    this.type,
    this.name,
    this.image,
    this.url,
    this.disporder,
  });

  int? id;
  String? type;
  String? name;
  String? image;
  String? url;
  int? disporder;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        image: json["image"],
        url: json["url"],
        disporder: json["disporder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "image": image,
        "url": url,
        "disporder": disporder,
      };
}

class Nrestaurant {
  Nrestaurant(
      {this.id,
      this.name,
      this.logo,
      this.deliveryTime,
      this.promoted,
      this.rating,
      this.status});

  int? id;
  String? name;
  String? logo;
  DeliveryTime? deliveryTime;
  String? promoted;
  int? rating;
  bool? status;

  factory Nrestaurant.fromJson(Map<String, dynamic> json) => Nrestaurant(
      id: json["id"],
      name: json["name"],
      logo: json["logo"],
      deliveryTime: deliveryTimeValues.map[json["delivery_time"]],
      promoted: json["promoted"],
      rating: json["rating"],
      status: false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "delivery_time": deliveryTimeValues.reverse![deliveryTime],
        "promoted": promoted,
        "rating": rating,
      };
}

enum DeliveryTime { THE_45_MINUTES, THE_30_MINUTES }

final deliveryTimeValues = EnumValues({
  "30Minutes": DeliveryTime.THE_30_MINUTES,
  "45Minutes": DeliveryTime.THE_45_MINUTES
});

class RestproductModel {
  RestproductModel(
      {this.id,
      this.name,
      this.type,
      this.catId,
      this.hasUnits,
      this.price,
      this.offerprice,
      this.image,
      this.restname,
      this.status = false});

  int? id;
  String? name;
  RestproductType? type;
  int? catId;
  String? hasUnits;
  int? price;
  int? offerprice;
  String? image;
  late String? restname;
  bool status;

  factory RestproductModel.fromJson(Map<String, dynamic> json) =>
      RestproductModel(
          id: json["id"],
          name: json["name"],
          type: restproductTypeValues.map[json["type"]],
          catId: json["cat_id"],
          hasUnits: json["has_units"],
          price: json["price"],
          offerprice: json["offerprice"],
          image: json["image"],
          restname: json["restname"],
          status: false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": restproductTypeValues.reverse![type],
        "cat_id": catId,
        "has_units": hasUnits,
        "price": price,
        "offerprice": offerprice,
        "image": image,
        "restname": restname,
        "status": status
      };
}

enum RestproductType { VEG, NON_VEG }

final restproductTypeValues = EnumValues(
    {"Non-Veg": RestproductType.NON_VEG, "Veg": RestproductType.VEG});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
