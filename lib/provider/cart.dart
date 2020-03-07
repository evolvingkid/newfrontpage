import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
int _cartCount = 0;

  int collect(){
   return _cartCount;
  }

  addCount(){
    _cartCount++;
    notifyListeners();
  }
  subCount(){
    _cartCount++;
    notifyListeners();
  }
}