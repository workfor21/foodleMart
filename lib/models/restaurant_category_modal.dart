// To parse this JSON data, do
//
//     final categoryModal = categoryModalFromJson(jsonString);

import 'dart:convert';

CategoryModal categoryModalFromJson(String str) =>
    CategoryModal.fromJson(json.decode(str));

String categoryModalToJson(CategoryModal data) => json.encode(data.toJson());

class CategoryModal {
  CategoryModal({
    this.sts,
    this.msg,
    this.cartcount,
    this.products,
  });

  String? sts;
  String? msg;
  int? cartcount;
  List<ProductModal>? products;

  factory CategoryModal.fromJson(Map<String, dynamic> json) => CategoryModal(
        sts: json["sts"],
        msg: json["msg"],
        cartcount: json["cartcount"],
        products: List<ProductModal>.from(
            json["products"].map((x) => ProductModal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sts": sts,
        "msg": msg,
        "cartcount": cartcount,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class ProductModal {
  ProductModal({
    this.id,
    this.catId,
    this.shopType,
    this.shopId,
    this.shopName,
    this.type,
    this.name,
    this.price,
    this.offerprice,
    this.status,
    this.image,
    this.hasUnits,
    this.units,
  });

  int? id;
  int? catId;
  String? shopType;
  int? shopId;
  String? shopName;
  String? type;
  String? name;
  int? price;
  int? offerprice;
  String? status;
  String? image;
  String? hasUnits;
  List<Unit>? units;

  factory ProductModal.fromJson(Map<String, dynamic> json) => ProductModal(
        id: json["id"],
        catId: json["cat_id"],
        shopType: json["shop_type"],
        shopId: json["shop_id"],
        shopName: json["shop_name"],
        type: json["type"],
        name: json["name"],
        price: json["price"],
        offerprice: json["offerprice"],
        status: json["status"],
        image: json["image"],
        hasUnits: json["has_units"],
        units: List<Unit>.from(json["units"].map((x) => Unit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "shop_type": shopType,
        "shop_id": shopId,
        "shop_name": shopName,
        "type": type,
        "name": name,
        "price": price,
        "offerprice": offerprice,
        "status": status,
        "image": image,
        "has_units": hasUnits,
        "units": List<dynamic>.from(units!.map((x) => x.toJson())),
      };
}

enum Type { NON_VEG, VEG }

final typeValues = EnumValues({"Non-Veg": Type.NON_VEG, "Veg": Type.VEG});

class Unit {
  Unit({
    this.id,
    this.productId,
    this.name,
    this.price,
    this.offerprice,
    this.dispOrder,
    this.status,
  });

  int? id;
  int? productId;
  String? name;
  int? price;
  int? offerprice;
  int? dispOrder;
  String? status;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        productId: json["product_id"],
        name: json["name"],
        price: json["price"],
        offerprice: json["offerprice"],
        dispOrder: json["disp_order"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "name": name,
        "price": price,
        "offerprice": offerprice,
        "disp_order": dispOrder,
        "status": status,
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
