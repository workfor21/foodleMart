import 'package:meta/meta.dart';
import 'dart:convert';

PostModal postModalfromJson(String str) => PostModal.fromJson(json.decode(str));

String postModalToMap(PostModal data) => json.encode(data.toMap());

class PostModal {
  PostModal({
    required this.sts,
    required this.msg,
    required this.cartcount,
    required this.shop,
    required this.category,
    required this.products,
  });

  String sts;
  String msg;
  int cartcount;
  Shop shop;
  Map<String, String> category;
  List<Product> products;

  factory PostModal.fromJson(Map<String, dynamic> json) => PostModal(
        sts: json["sts"],
        msg: json["msg"],
        cartcount: json["cartcount"],
        shop: Shop.fromJson(json["shop"]),
        category: Map.from(json["category"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "sts": sts,
        "msg": msg,
        "cartcount": cartcount,
        "shop": shop.toMap(),
        "category":
            Map.from(category).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
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
    required this.units,
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
  List<UnitModel> units;

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
        units: List<UnitModel>.from(
            json["units"].map((x) => UnitModel.fromJson(x))),
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
        "units": List<dynamic>.from(units.map((x) => x.toMap())),
      };
}

class UnitModel {
  UnitModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.offerprice,
    required this.dispOrder,
    required this.status,
  });

  int id;
  int productId;
  String name;
  int price;
  int offerprice;
  int dispOrder;
  String status;

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        id: json["id"],
        productId: json["product_id"],
        name: json["name"],
        price: json["price"],
        offerprice: json["offerprice"],
        dispOrder: json["disp_order"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "product_id": productId,
        "name": name,
        "price": price,
        "offerprice": offerprice,
        "disp_order": dispOrder,
        "status": status,
      };
}

class Shop {
  Shop({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.slugName,
    required this.type,
    required this.serviceType,
    required this.rating,
    required this.email,
    required this.mobile,
    required this.phone,
    required this.password,
    required this.desc,
    required this.notes,
    required this.gstNo,
    required this.licence,
    required this.aadhar,
    required this.openTime,
    required this.closeTime,
    required this.hours,
    required this.deliveryTime,
    required this.deliveryCharge,
    required this.payoutOptions,
    required this.verifiedStore,
    required this.promoted,
    required this.paymentDetails,
    required this.address,
    required this.pincode,
    required this.city,
    required this.district,
    required this.state,
    required this.country,
    required this.agentId,
    required this.franchiseId,
    required this.franchiseCommession,
    required this.adminCommession,
    required this.status,
    required this.hasTax,
    required this.taxValue,
    required this.logo,
    required this.banner,
    required this.photo,
    required this.sign,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String ownerName;
  String slugName;
  String type;
  int serviceType;
  int rating;
  String email;
  String mobile;
  String phone;
  String password;
  String desc;
  String notes;
  String gstNo;
  String licence;
  String aadhar;
  int openTime;
  int closeTime;
  String hours;
  String deliveryTime;
  int deliveryCharge;
  String payoutOptions;
  String verifiedStore;
  String promoted;
  String paymentDetails;
  String address;
  String pincode;
  String city;
  int district;
  int state;
  int country;
  int agentId;
  int franchiseId;
  int franchiseCommession;
  int adminCommession;
  String status;
  String hasTax;
  int taxValue;
  String logo;
  String banner;
  String photo;
  String sign;
  String latitude;
  String longitude;
  DateTime createdAt;
  DateTime updatedAt;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        name: json["name"],
        ownerName: json["owner_name"],
        slugName: json["slug_name"],
        type: json["type"],
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
        hasTax: json["has_tax"],
        taxValue: json["tax_value"],
        logo: json["logo"],
        banner: json["banner"],
        photo: json["photo"],
        sign: json["sign"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "owner_name": ownerName,
        "slug_name": slugName,
        "type": type,
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
        "has_tax": hasTax,
        "tax_value": taxValue,
        "logo": logo,
        "banner": banner,
        "photo": photo,
        "sign": sign,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class PostModalResponse {
  late final List<PostModal>? postModal;
  late final String? error;
  PostModalResponse({
    this.postModal,
    this.error,
  });
  factory PostModalResponse.fromJson(Map<String, dynamic> json) {
    try {
      return PostModalResponse(
        postModal: json["post_modal"] == null
            ? null
            : List<PostModal>.from(
                json["post_modal"].map((x) => PostModal.fromJson(x))),
        error: json["error"],
      );
    } catch (e) {
      return PostModalResponse(
        postModal: null,
        error: "Something went wrong",
      );
    }
  }
}
