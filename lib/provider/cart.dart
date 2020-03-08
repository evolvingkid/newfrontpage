import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  int cartCount = 0;

  addCount() {
    cartCount++;
    notifyListeners();
  }

  subCount() {
    cartCount--;
    notifyListeners();
  }
}
