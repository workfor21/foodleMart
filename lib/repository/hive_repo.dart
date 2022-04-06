import 'package:foodle_mart/models/hive_cart_model.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/utils/pop_up_message.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiveCartRepo {
  static Future addToCart(shopId, productId, unitId, shopType, quantity,
      productname, unitname, price, offerprice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('Id');
    final cartObj = HiveCart(
      userId: userId,
      shopType: shopType,
      shopId: shopId,
      productId: productId,
      unitId: unitId, //
      quantity: quantity,
      productname: productname,
      unitname: unitname,
      price: price,
      offerprice: offerprice,
    );
    final cartBox = Boxes.getHiveCart();
    var keyid = 0;
    var data = cartBox.add(cartObj);
    print('hive cart data ::: ' + data.toString());
  }

  static Future editHiveCart(quantity, int cartIndex, cartId) async {
    final box = Boxes.getHiveCart();
    print('key :::: ' + cartIndex.toString());
    //api update
    var response =
        await CartApi.updateCart(cartId.toString(), quantity.toString());
    if (response == true) {
      final cart = box.get(cartIndex);
      print('this is cart ::: ' + cart.toString());
      cart?.quantity = quantity.toString();
      cart?.save();
    } else {
      flutterToast('oops we couldnt add the quantity. Please try again.');
    }
  }

  static deleteHivecart(int cartIndex) {
    final box = Boxes.getHiveCart();
    box.delete(cartIndex);
  }
}

class Boxes {
  static Box<HiveCart> getHiveCart() => Hive.box<HiveCart>('cart');
}
