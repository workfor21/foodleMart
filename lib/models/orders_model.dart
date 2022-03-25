// // To parse required this JSON data, do
// //
// //     final ordersModel = ordersModelFromJson(jsonString);

// import 'dart:convert';

// OrdersModel ordersModelFromJson(String str) =>
//     OrdersModel.fromJson(json.decode(str));

// String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

// class OrdersModel {
//   OrdersModel({
//     required this.sts,
//     required this.msg,
//     required this.orders,
//   });

//   String sts;
//   String msg;
//   List<OrderListModel> orders;

//   factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
//         sts: json["sts"],
//         msg: json["msg"],
//         orders: List<OrderListModel>.from(
//             json["orders"].map((x) => OrderListModel.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "sts": sts,
//         "msg": msg,
//         "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
//       };
// }

// class OrderListModel {
//   OrderListModel({
//     required this.id,
//     required this.userId,
//     required this.cname,
//     required this.cphone,
//     required this.cemail,
//     required this.addressId,
//     required this.address,
//     required this.type,
//     required this.shopId,
//     required this.shop,
//     required this.amount,
//     required this.payType,
//     required this.payStatus,
//     required this.paytype,
//     required this.paystatus,
//     required this.status,
//     required this.details,
//     required this.orderOn,
//   });

//   int id;
//   int userId;
//   dynamic cname;
//   dynamic cphone;
//   dynamic cemail;
//   int addressId;
//   Address address;
//   String type;
//   int shopId;
//   Shop shop;
//   int amount;
//   String payType;
//   String payStatus;
//   dynamic paytype;
//   dynamic paystatus;
//   String status;
//   String details;
//   DateTime orderOn;

//   factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
//         id: json["id"],
//         userId: json["user_id"],
//         cname: json["cname"],
//         cphone: json["cphone"],
//         cemail: json["cemail"],
//         addressId: json["address_id"],
//         address: Address.fromJson(json["address"]),
//         type: json["type"],
//         shopId: json["shop_id"],
//         shop: Shop.fromJson(json["shop"]),
//         amount: json["amount"],
//         payType: json["pay_type"],
//         payStatus: json["pay_status"],
//         paytype: json["paytype"],
//         paystatus: json["paystatus"],
//         status: json["status"],
//         details: json["details"],
//         orderOn: DateTime.parse(json["order_on"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "cname": cname,
//         "cphone": cphone,
//         "cemail": cemail,
//         "address_id": addressId,
//         "address": address.toJson(),
//         "type": type,
//         "shop_id": shopId,
//         "shop": shop.toJson(),
//         "amount": amount,
//         "pay_type": payType,
//         "pay_status": payStatus,
//         "paytype": paytype,
//         "paystatus": paystatus,
//         "status": status,
//         "details": details,
//         "order_on": orderOn.toIso8601String(),
//       };
// }

// class Address {
//   Address({
//     required this.id,
//     required this.userId,
//     required this.addressDefault,
//     required this.name,
//     required this.mobile,
//     required this.phone,
//     required this.pincode,
//     required this.landmark,
//     required this.city,
//     required this.address,
//     required this.district,
//     required this.state,
//     required this.country,
//     required this.type,
//     required this.status,
//   });

//   int id;
//   int userId;
//   String addressDefault;
//   String name;
//   String mobile;
//   String phone;
//   String pincode;
//   String landmark;
//   String city;
//   String address;
//   int district;
//   int state;
//   int country;
//   String type;
//   String status;

//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//         id: json["id"],
//         userId: json["user_id"],
//         addressDefault: json["default"],
//         name: json["name"],
//         mobile: json["mobile"],
//         phone: json["phone"],
//         pincode: json["pincode"],
//         landmark: json["landmark"],
//         city: json["city"],
//         address: json["address"],
//         district: json["district"],
//         state: json["state"],
//         country: json["country"],
//         type: json["type"],
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "default": addressDefault,
//         "name": name,
//         "mobile": mobile,
//         "phone": phone,
//         "pincode": pincode,
//         "landmark": landmark,
//         "city": city,
//         "address": address,
//         "district": district,
//         "state": state,
//         "country": country,
//         "type": type,
//         "status": status,
//       };
// }

// class Shop {
//   Shop({
//     required this.id,
//     required this.name,
//     required this.logo,
//     required this.deliveryCharge,
//     required this.deliveryTime,
//     required this.ownerName,
//     required this.slugName,
//     required this.serviceType,
//     required this.rating,
//     required this.email,
//     required this.mobile,
//     required this.phone,
//     required this.password,
//     required this.desc,
//     required this.notes,
//     required this.gstNo,
//     required this.licence,
//     required this.aadhar,
//     required this.openTime,
//     required this.closeTime,
//     required this.hours,
//     required this.payoutOptions,
//     required this.verifiedStore,
//     required this.promoted,
//     required this.paymentDetails,
//     required this.address,
//     required this.pincode,
//     required this.city,
//     required this.district,
//     required this.state,
//     required this.country,
//     required this.agentId,
//     required this.franchiseId,
//     required this.franchiseCommession,
//     required this.adminCommession,
//     required this.status,
//     required this.banner,
//     required this.photo,
//     required this.sign,
//   });

//   int id;
//   String name;
//   String logo;
//   int deliveryCharge;
//   String deliveryTime;
//   String ownerName;
//   String slugName;
//   int serviceType;
//   int rating;
//   String email;
//   String mobile;
//   String phone;
//   String password;
//   String desc;
//   String notes;
//   String gstNo;
//   String licence;
//   String aadhar;
//   int openTime;
//   int closeTime;
//   String hours;
//   String payoutOptions;
//   String verifiedStore;
//   String promoted;
//   String paymentDetails;
//   String address;
//   String pincode;
//   String city;
//   int district;
//   int state;
//   int country;
//   int agentId;
//   int franchiseId;
//   int franchiseCommession;
//   int adminCommession;
//   String status;
//   String banner;
//   String photo;
//   String sign;

//   factory Shop.fromJson(Map<String, dynamic> json) => Shop(
//       id: json["id"],
//       name: json["name"],
//       logo: json["logo"],
//       deliveryCharge: json["delivery_charge"],
//       deliveryTime: json["delivery_time"],
//       ownerName: json["owner_name"] == null ? null : json["owner_name"],
//       slugName: json["slug_name"] == null ? null : json["slug_name"],
//       serviceType: json["service_type"] == null ? null : json["service_type"],
//       rating: json["rating"] == null ? null : json["rating"],
//       email: json["email"] == null ? null : json["email"],
//       mobile: json["mobile"] == null ? null : json["mobile"],
//       phone: json["phone"] == null ? null : json["phone"],
//       password: json["password"] == null ? null : json["password"],
//       desc: json["desc"] == null ? null : json["desc"],
//       notes: json["notes"] == null ? null : json["notes"],
//       gstNo: json["gst_no"] == null ? null : json["gst_no"],
//       licence: json["licence"] == null ? null : json["licence"],
//       aadhar: json["aadhar"] == null ? null : json["aadhar"],
//       openTime: json["open_time"] == null ? null : json["open_time"],
//       closeTime: json["close_time"] == null ? null : json["close_time"],
//       hours: json["hours"] == null ? null : json["hours"],
//       payoutOptions:
//           json["payout_options"] == null ? null : json["payout_options"],
//       verifiedStore:
//           json["verified_store"] == null ? null : json["verified_store"],
//       promoted: json["promoted"] == null ? null : json["promoted"],
//       paymentDetails:
//           json["payment_details"] == null ? null : json["payment_details"],
//       address: json["address"] == null ? null : json["address"],
//       pincode: json["pincode"] == null ? null : json["pincode"],
//       city: json["city"] == null ? null : json["city"],
//       district: json["district"] == null ? null : json["district"],
//       state: json["state"] == null ? null : json["state"],
//       country: json["country"] == null ? null : json["country"],
//       agentId: json["agent_id"] == null ? null : json["agent_id"],
//       franchiseId: json["franchise_id"] == null ? null : json["franchise_id"],
//       franchiseCommession: json["franchise_commession"] == null
//           ? null
//           : json["franchise_commession"],
//       adminCommession:
//           json["admin_commession"] == null ? null : json["admin_commession"],
//       status: json["status"] == null ? null : json["status"],
//       banner: json["banner"] == null ? null : json["banner"],
//       photo: json["photo"] == null ? null : json["photo"],
//       sign: json["sign"] == null ? null : json["sign"]);

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "logo": logo,
//         "delivery_charge": deliveryCharge,
//         "delivery_time": deliveryTime,
//         "owner_name": ownerName == null ? null : ownerName,
//         "slug_name": slugName == null ? null : slugName,
//         "service_type": serviceType == null ? null : serviceType,
//         "rating": rating == null ? null : rating,
//         "email": email == null ? null : email,
//         "mobile": mobile == null ? null : mobile,
//         "phone": phone == null ? null : phone,
//         "password": password == null ? null : password,
//         "desc": desc == null ? null : desc,
//         "notes": notes == null ? null : notes,
//         "gst_no": gstNo == null ? null : gstNo,
//         "licence": licence == null ? null : licence,
//         "aadhar": aadhar == null ? null : aadhar,
//         "open_time": openTime == null ? null : openTime,
//         "close_time": closeTime == null ? null : closeTime,
//         "hours": hours == null ? null : hours,
//         "payout_options": payoutOptions == null ? null : payoutOptions,
//         "verified_store": verifiedStore == null ? null : verifiedStore,
//         "promoted": promoted == null ? null : promoted,
//         "payment_details": paymentDetails == null ? null : paymentDetails,
//         "address": address == null ? null : address,
//         "pincode": pincode == null ? null : pincode,
//         "city": city == null ? null : city,
//         "district": district == null ? null : district,
//         "state": state == null ? null : state,
//         "country": country == null ? null : country,
//         "agent_id": agentId == null ? null : agentId,
//         "franchise_id": franchiseId == null ? null : franchiseId,
//         "franchise_commession":
//             franchiseCommession == null ? null : franchiseCommession,
//         "admin_commession": adminCommession == null ? null : adminCommession,
//         "status": status == null ? null : status,
//         "banner": banner == null ? null : banner,
//         "photo": photo == null ? null : photo,
//         "sign": sign == null ? null : sign,
//       };
// }
