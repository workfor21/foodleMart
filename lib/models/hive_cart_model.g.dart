// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCartAdapter extends TypeAdapter<HiveCart> {
  @override
  final int typeId = 0;

  @override
  HiveCart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCart(
      cartId: fields[0] as String?,
      userId: fields[1] as String?,
      shopType: fields[2] as String?,
      shopId: fields[3] as String?,
      productId: fields[4] as String?,
      unitId: fields[5] as String?,
      quantity: fields[6] as String?,
      productname: fields[7] as String?,
      unitname: fields[8] as String?,
      price: fields[9] as String?,
      offerprice: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCart obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.cartId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.shopType)
      ..writeByte(3)
      ..write(obj.shopId)
      ..writeByte(4)
      ..write(obj.productId)
      ..writeByte(5)
      ..write(obj.unitId)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.productname)
      ..writeByte(8)
      ..write(obj.unitname)
      ..writeByte(9)
      ..write(obj.price)
      ..writeByte(10)
      ..write(obj.offerprice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
