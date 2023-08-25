import 'package:flutter/material.dart';

class GoldPurchaseNotifier extends ChangeNotifier {
  double _grams = 0;

  double get grams => _grams;

  void updateGrams(double newGrams) {
    _grams = newGrams;
    notifyListeners();
  }
}
