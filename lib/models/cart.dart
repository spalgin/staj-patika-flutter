import 'package:flutter/foundation.dart';

import 'product.dart';

class Cart extends ChangeNotifier {
  final Map<String, ({Product product, int quantity})> _items = {};

  Iterable<({Product product, int quantity})> get items => _items.values;

  int get count => items.fold(0, (total, item) => total + item.quantity);

  int get totalPrice => items.fold(
    0,
    (total, item) => total + item.product.price * item.quantity,
  );

  int quantityOf(Product product) => _items[product.id]?.quantity ?? 0;

  void add(Product product) {
    _items[product.id] = (product: product, quantity: quantityOf(product) + 1);
    notifyListeners();
  }

  void removeOne(Product product) {
    final quantity = quantityOf(product);
    if (quantity == 0) return;
    if (quantity == 1) {
      _items.remove(product.id);
    } else {
      _items[product.id] = (product: product, quantity: quantity - 1);
    }
    notifyListeners();
  }
}
