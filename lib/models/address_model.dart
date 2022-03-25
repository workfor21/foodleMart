import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    this.sts,
    this.msg,
    this.address,
  });

  String? sts;
  String? msg;
  List<AddressListModel>? address;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        sts: json["sts"],
        msg: json["msg"],
        address: List<AddressListModel>.from(
            json["address"].map((x) => AddressListModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sts": sts,
        "msg": msg,
        "address": List<dynamic>.from(address!.map((x) => x.toJson())),
      };
}

class AddressListModel {
  AddressListModel({
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

  factory AddressListModel.fromJson(Map<String, dynamic> json) =>
      AddressListModel(
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

  Map<String, dynamic> toJson() => {
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
