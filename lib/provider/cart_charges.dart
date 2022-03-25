import 'package:flutter/cupertino.dart';

class CartExtraCharges extends ChangeNotifier {
  int _multiplier = 1;
  double _deliverycharge = 0;
  double _otherCharges = 0;
  double _productTotal = 0;

  double get deliveryCharges => _deliverycharge;
  double get othercharges => _otherCharges;
  double get productTotal => _productTotal;
  int get multiplier => _multiplier;

  void CartCharges(_productTotal) {
    _productTotal = productTotal;
    notifyListeners();
  }

  void addMultiplier() {
    _multiplier++;
    notifyListeners();
  }

  void minusMultiplier() {
    _multiplier--;
    notifyListeners();
  }
}
