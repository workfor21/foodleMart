// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderListModel orderListModelFromMap(String str) =>
    OrderListModel.fromMap(json.decode(str));

String orderListModelToMap(OrderListModel data) => json.encode(data.toMap());

class OrderListModel {
  OrderListModel({
    required this.sts,
    required this.msg,
    required this.orders,
  });

  String sts;
  String msg;
  List<Order> orders;

  factory OrderListModel.fromMap(Map<String, dynamic> json) => OrderListModel(
        sts: json["sts"],
        msg: json["msg"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "sts": sts,
        "msg": msg,
        "orders": List<dynamic>.from(orders.map((x) => x.toMap())),
      };
}

class Order {
  Order({
    this.id,
    this.userId,
    this.cname,
    this.cphone,
    this.cemail,
    this.addressId,
    this.address,
    this.type,
    this.shopId,
    this.shop,
    this.amount,
    this.payType,
    this.payStatus,
    this.paytype,
    this.paystatus,
    this.status,
    this.details,
    this.orderOn,
  });

  int? id;
  int? userId;
  dynamic cname;
  dynamic cphone;
  dynamic cemail;
  int? addressId;
  Address? address;
  String? type;
  int? shopId;
  Shop? shop;
  double? amount;
  String? payType;
  String? payStatus;
  dynamic paytype;
  dynamic paystatus;
  String? status;
  String? details;
  DateTime? orderOn;

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        cname: json["cname"],
        cphone: json["cphone"],
        cemail: json["cemail"],
        addressId: json["address_id"],
        address: Address.fromMap(json["address"]),
        type: json["type"],
        shopId: json["shop_id"],
        shop: Shop.fromMap(json["shop"]),
        amount: double.parse(json["amount"].toString()),
        payType: json["pay_type"],
        payStatus: json["pay_status"],
        paytype: json["paytype"],
        paystatus: json["paystatus"],
        status: json["status"],
        details: json["details"],
        orderOn: DateTime.parse(json["order_on"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "cname": cname,
        "cphone": cphone,
        "cemail": cemail,
        "address_id": addressId,
        "address": address!.toMap(),
        "type": type,
        "shop_id": shopId,
        "shop": shop!.toMap(),
        "amount": amount,
        "pay_type": payType,
        "pay_status": payStatus,
        "paytype": paytype,
        "paystatus": paystatus,
        "status": status,
        "details": details,
        "order_on": orderOn!.toIso8601String(),
      };
}

class Address {
  Address({
    this.id,
    this.userId,
    this.addressDefault,
    this.name,
    this.mobile,
    this.phone,
    this.pincode,
    this.landmark,
    this.city,
    this.address,
    this.district,
    this.state,
    this.country,
    this.type,
    this.status,
  });

  int? id;
  int? userId;
  String? addressDefault;
  String? name;
  String? mobile;
  String? phone;
  String? pincode;
  String? landmark;
  String? city;
  String? address;
  int? district;
  int? state;
  int? country;
  String? type;
  String? status;

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        addressDefault: json["default"],
        name: json["name"],
        mobile: json["mobile"],
        phone: json["phone"],
        pincode: json["pincode"],
        landmark: json["landmark"],
        city: json["city"],
        address: json["address"],
        district: json["district"],
        state: json["state"],
        country: json["country"],
        type: json["type"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "default": addressDefault,
        "name": name,
        "mobile": mobile,
        "phone": phone,
        "pincode": pincode,
        "landmark": landmark,
        "city": city,
        "address": address,
        "district": district,
        "state": state,
        "country": country,
        "type": type,
        "status": status,
      };
}

class Shop {
  Shop({
    this.id,
    this.name,
    this.logo,
    this.deliveryCharge,
    this.deliveryTime,
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
    this.banner,
    this.photo,
    this.sign,
  });

  int? id;
  String? name;
  String? logo;
  int? deliveryCharge;
  String? deliveryTime;
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
  String? banner;
  String? photo;
  String? sign;

  factory Shop.fromMap(Map<String, dynamic> json) => Shop(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        deliveryCharge: json["delivery_charge"],
        deliveryTime: json["delivery_time"],
        ownerName: json["owner_name"] == null ? null : json["owner_name"],
        slugName: json["slug_name"] == null ? null : json["slug_name"],
        serviceType: json["service_type"] == null ? null : json["service_type"],
        rating: json["rating"] == null ? null : json["rating"],
        email: json["email"] == null ? null : json["email"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        phone: json["phone"] == null ? null : json["phone"],
        password: json["password"] == null ? null : json["password"],
        desc: json["desc"] == null ? null : json["desc"],
        notes: json["notes"] == null ? null : json["notes"],
        gstNo: json["gst_no"] == null ? null : json["gst_no"],
        licence: json["licence"] == null ? null : json["licence"],
        aadhar: json["aadhar"] == null ? null : json["aadhar"],
        openTime: json["open_time"] == null ? null : json["open_time"],
        closeTime: json["close_time"] == null ? null : json["close_time"],
        hours: json["hours"] == null ? null : json["hours"],
        payoutOptions:
            json["payout_options"] == null ? null : json["payout_options"],
        verifiedStore:
            json["verified_store"] == null ? null : json["verified_store"],
        promoted: json["promoted"] == null ? null : json["promoted"],
        paymentDetails:
            json["payment_details"] == null ? null : json["payment_details"],
        address: json["address"] == null ? null : json["address"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        city: json["city"] == null ? null : json["city"],
        district: json["district"] == null ? null : json["district"],
        state: json["state"] == null ? null : json["state"],
        country: json["country"] == null ? null : json["country"],
        agentId: json["agent_id"] == null ? null : json["agent_id"],
        franchiseId: json["franchise_id"] == null ? null : json["franchise_id"],
        franchiseCommession: json["franchise_commession"] == null
            ? null
            : json["franchise_commession"],
        adminCommession:
            json["admin_commession"] == null ? null : json["admin_commession"],
        status: json["status"] == null ? null : json["status"],
        banner: json["banner"] == null ? null : json["banner"],
        photo: json["photo"] == null ? null : json["photo"],
        sign: json["sign"] == null ? null : json["sign"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "logo": logo,
        "delivery_charge": deliveryCharge,
        "delivery_time": deliveryTime,
        "owner_name": ownerName == null ? null : ownerName,
        "slug_name": slugName == null ? null : slugName,
        "service_type": serviceType == null ? null : serviceType,
        "rating": rating == null ? null : rating,
        "email": email == null ? null : email,
        "mobile": mobile == null ? null : mobile,
        "phone": phone == null ? null : phone,
        "password": password == null ? null : password,
        "desc": desc == null ? null : desc,
        "notes": notes == null ? null : notes,
        "gst_no": gstNo == null ? null : gstNo,
        "licence": licence == null ? null : licence,
        "aadhar": aadhar == null ? null : aadhar,
        "open_time": openTime == null ? null : openTime,
        "close_time": closeTime == null ? null : closeTime,
        "hours": hours == null ? null : hours,
        "payout_options": payoutOptions == null ? null : payoutOptions,
        "verified_store": verifiedStore == null ? null : verifiedStore,
        "promoted": promoted == null ? null : promoted,
        "payment_details": paymentDetails == null ? null : paymentDetails,
        "address": address == null ? null : address,
        "pincode": pincode == null ? null : pincode,
        "city": city == null ? null : city,
        "district": district == null ? null : district,
        "state": state == null ? null : state,
        "country": country == null ? null : country,
        "agent_id": agentId == null ? null : agentId,
        "franchise_id": franchiseId == null ? null : franchiseId,
        "franchise_commession":
            franchiseCommession == null ? null : franchiseCommession,
        "admin_commession": adminCommession == null ? null : adminCommession,
        "status": status == null ? null : status,
        "banner": banner == null ? null : banner,
        "photo": photo == null ? null : photo,
        "sign": sign == null ? null : sign
      };
}
