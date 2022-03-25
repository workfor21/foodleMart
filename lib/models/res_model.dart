class ResModel {
  String? sts;
  String? msg;
  int? cartcount;
  List<Nrestaurants>? restaurants;
  List<Nrestaurants>? nrestaurants;

  ResModel(
      {this.sts,
      this.msg,
      this.cartcount,
      this.restaurants,
      this.nrestaurants});

  ResModel.fromJson(Map<String, dynamic> json) {
    if (json["sts"] is String) sts = json["sts"];
    if (json["msg"] is String) msg = json["msg"];
    if (json["cartcount"] is int) cartcount = json["cartcount"];
    if (json["restaurants"] is List) restaurants = json["restaurants"] ?? [];
    if (json["nrestaurants"] is List)
      nrestaurants = json["nrestaurants"] == null
          ? null
          : (json["nrestaurants"] as List)
              .map((e) => Nrestaurants.fromJson(e))
              .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["sts"] = sts;
    data["msg"] = msg;
    data["cartcount"] = cartcount;
    if (restaurants != null) data["restaurants"] = restaurants;
    if (nrestaurants != null)
      data["nrestaurants"] = nrestaurants?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Nrestaurants {
  int? id;
  String? name;
  String? logo;
  String? deliveryTime;
  String? promoted;
  double? rating;
  bool? status;

  Nrestaurants(
      {this.id,
      this.name,
      this.logo,
      this.deliveryTime,
      this.promoted,
      this.rating,
      this.status});

  Nrestaurants.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) id = json["id"];
    if (json["name"] is String) name = json["name"];
    if (json["logo"] is String) logo = json["logo"];
    if (json["delivery_time"] is String) deliveryTime = json["delivery_time"];
    if (json["promoted"] is String) promoted = json["promoted"];
    if (json["rating"] is double) rating = json["rating"];
    if (json["status"] is bool) status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["logo"] = logo;
    data["delivery_time"] = deliveryTime;
    data["promoted"] = promoted;
    data["rating"] = rating;
    data["status"] = false;
    return data;
  }
}
