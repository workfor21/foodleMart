// To parse this JSON data, do
//
//     final superMarketModel = superMarketModelFromJson(jsonString);

import 'dart:convert';

SuperMarketModel superMarketModelFromJson(String str) =>
    SuperMarketModel.fromJson(json.decode(str));

String superMarketModelToJson(SuperMarketModel data) =>
    json.encode(data.toJson());

class SuperMarketModel {
  SuperMarketModel({
    this.sts,
    this.msg,
    this.cartcount,
    this.shop,
    this.category,
    this.brands,
    this.products,
  });
//
  String? sts;
  String? msg;
  int? cartcount;
  Shop? shop;
  Map<String, String>? category;
  List<dynamic>? brands;
  List<Product>? products;

  factory SuperMarketModel.fromJson(Map<String, dynamic> json) =>
      SuperMarketModel(
        sts: json["sts"],
        msg: json["msg"],
        cartcount: json["cartcount"],
        shop: Shop.fromJson(json["shop"]),
        category: Map.from(json["category"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        brands: List<dynamic>.from(json["brands"].map((x) => x)),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sts": sts,
        "msg": msg,
        "cartcount": cartcount,
        "shop": shop!.toJson(),
        "category":
            Map.from(category!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "brands": List<dynamic>.from(brands!.map((x) => x)),
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.catId,
    required this.shopType,
    required this.shopId,
    required this.type,
    required this.name,
    required this.price,
    required this.offerprice,
    required this.status,
    required this.image,
    required this.hasUnits,
  });

  int id;
  int catId;
  String shopType;
  int shopId;
  String type;
  String name;
  int price;
  int offerprice;
  String status;
  String image;
  String hasUnits;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        catId: json["cat_id"],
        shopType: json["shop_type"],
        shopId: json["shop_id"],
        type: json["type"],
        name: json["name"],
        price: json["price"],
        offerprice: json["offerprice"],
        status: json["status"],
        image: json["image"],
        hasUnits: json["has_units"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cat_id": catId,
        "shop_type": shopType,
        "shop_id": shopId,
        "type": type,
        "name": name,
        "price": price,
        "offerprice": offerprice,
        "status": status,
        "image": image,
        "has_units": hasUnits,
      };

  toJson() {}
}

enum Status { AVAILABLE }

final statusValues = EnumValues({"Available": Status.AVAILABLE});

enum Type { EMPTY, VEG }

final typeValues = EnumValues({"": Type.EMPTY, "Veg": Type.VEG});

class Shop {
  Shop({
    this.id,
    this.name,
    this.ownerName,
    this.slugName,
    this.serviceType,
    this.rating,
    this.email,
    this.mobile,
    this.phone,
    this.password,
    this.desc,
    this.notes,
    this.gstNo,
    this.licence,
    this.aadhar,
    this.openTime,
    this.closeTime,
    this.hours,
    this.deliveryTime,
    this.deliveryCharge,
    this.payoutOptions,
    this.verifiedStore,
    this.promoted,
    this.paymentDetails,
    this.address,
    this.pincode,
    this.city,
    this.district,
    this.state,
    this.country,
    this.agentId,
    this.franchiseId,
    this.franchiseCommession,
    this.adminCommession,
    this.status,
    this.logo,
    this.banner,
    this.photo,
    this.sign,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? ownerName;
  String? slugName;
  int? serviceType;
  int? rating;
  String? email;
  String? mobile;
  String? phone;
  String? password;
  String? desc;
  String? notes;
  String? gstNo;
  String? licence;
  String? aadhar;
  int? openTime;
  int? closeTime;
  String? hours;
  String? deliveryTime;
  int? deliveryCharge;
  String? payoutOptions;
  String? verifiedStore;
  String? promoted;
  String? paymentDetails;
  String? address;
  String? pincode;
  String? city;
  int? district;
  int? state;
  int? country;
  int? agentId;
  int? franchiseId;
  int? franchiseCommession;
  int? adminCommession;
  String? status;
  String? logo;
  String? banner;
  String? photo;
  String? sign;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        name: json["name"],
        ownerName: json["owner_name"],
        slugName: json["slug_name"],
        serviceType: json["service_type"],
        rating: json["rating"],
        email: json["email"],
        mobile: json["mobile"],
        phone: json["phone"],
        password: json["password"],
        desc: json["desc"],
        notes: json["notes"],
        gstNo: json["gst_no"],
        licence: json["licence"],
        aadhar: json["aadhar"],
        openTime: json["open_time"],
        closeTime: json["close_time"],
        hours: json["hours"],
        deliveryTime: json["delivery_time"],
        deliveryCharge: json["delivery_charge"],
        payoutOptions: json["payout_options"],
        verifiedStore: json["verified_store"],
        promoted: json["promoted"],
        paymentDetails: json["payment_details"],
        address: json["address"],
        pincode: json["pincode"],
        city: json["city"],
        district: json["district"],
        state: json["state"],
        country: json["country"],
        agentId: json["agent_id"],
        franchiseId: json["franchise_id"],
        franchiseCommession: json["franchise_commession"],
        adminCommession: json["admin_commession"],
        status: json["status"],
        logo: json["logo"],
        banner: json["banner"],
        photo: json["photo"],
        sign: json["sign"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "owner_name": ownerName,
        "slug_name": slugName,
        "service_type": serviceType,
        "rating": rating,
        "email": email,
        "mobile": mobile,
        "phone": phone,
        "password": password,
        "desc": desc,
        "notes": notes,
        "gst_no": gstNo,
        "licence": licence,
        "aadhar": aadhar,
        "open_time": openTime,
        "close_time": closeTime,
        "hours": hours,
        "delivery_time": deliveryTime,
        "delivery_charge": deliveryCharge,
        "payout_options": payoutOptions,
        "verified_store": verifiedStore,
        "promoted": promoted,
        "payment_details": paymentDetails,
        "address": address,
        "pincode": pincode,
        "city": city,
        "district": district,
        "state": state,
        "country": country,
        "agent_id": agentId,
        "franchise_id": franchiseId,
        "franchise_commession": franchiseCommession,
        "admin_commession": adminCommession,
        "status": status,
        "logo": logo,
        "banner": banner,
        "photo": photo,
        "sign": sign,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
