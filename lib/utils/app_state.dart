import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../models/user.dart';

class AppState extends ChangeNotifier {
  final List<Product> _favoriteProducts = <Product>[];
  User? _currentUser;
  int _cartItemsCount = 0;

  List<Product> get favoriteProducts => _favoriteProducts;
  User? get currentUser => _currentUser;
  int get cartItemsCount => _cartItemsCount;

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    if (_favoriteProducts.contains(product)) {
      _favoriteProducts.remove(product);
    } else {
      _favoriteProducts.add(product);
    }
    notifyListeners();
  }

  void addToCart(Product product) {
    _cartItemsCount++;
    notifyListeners();
  }
}
