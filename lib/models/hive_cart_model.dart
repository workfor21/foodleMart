import 'package:hive/hive.dart';

part 'hive_cart_model.g.dart';

@HiveType(typeId: 0)
class HiveCart extends HiveObject {
  @HiveField(0)
  String? cartId;
  @HiveField(1)
  String? userId;
  @HiveField(2)
  String? shopType;
  @HiveField(3)
  String? shopId;
  @HiveField(4)
  String? productId;
  @HiveField(5)
  String? unitId;
  @HiveField(6)
  String? quantity;
  @HiveField(7)
  String? productname;
  @HiveField(8)
  String? unitname;
  @HiveField(9)
  String? price;
  @HiveField(10)
  String? offerprice;

  HiveCart({
    this.cartId,
    this.userId,
    this.shopType,
    this.shopId,
    this.productId,
    this.unitId,
    this.quantity,
    this.productname,
    this.unitname,
    this.price,
    this.offerprice,
  });
}
