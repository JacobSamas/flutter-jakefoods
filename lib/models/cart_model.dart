import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class CartModel extends ChangeNotifier {
  final Map<MenuItem, int> _items = {};

  Map<MenuItem, int> get items => _items;

  void add(MenuItem item) {
    if (_items.containsKey(item)) {
      _items[item] = _items[item]! + 1;
    } else {
      _items[item] = 1;
    }
    notifyListeners();
  }

  void remove(MenuItem item) {
    if (_items.containsKey(item) && _items[item]! > 1) {
      _items[item] = _items[item]! - 1;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  int get totalItems => _items.values.fold(0, (a, b) => a + b);

  double get totalPrice => _items.entries.fold(0, (sum, e) => sum + e.key.price * e.value);
}
