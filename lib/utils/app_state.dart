import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../models/product.dart';
import '../models/user.dart';

class AppState extends ChangeNotifier {
  List<Product> _favoriteProducts = const <Product>[];
  User? _currentUser;
  int _cartItemsCount = 0;

  List<Product> get favoriteProducts => List.unmodifiable(_favoriteProducts);
  User? get currentUser => _currentUser;
  int get cartItemsCount => _cartItemsCount;

  bool isFavorite(Product product) => _favoriteProducts.contains(product);

  void setCurrentUser(User user) {
    if (_currentUser == user) {
      return;
    }
    _currentUser = user;
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    if (_favoriteProducts.contains(product)) {
      _favoriteProducts = _favoriteProducts
          .where((item) => item != product)
          .toList(growable: false);
    } else {
      _favoriteProducts = List<Product>.unmodifiable(
        <Product>[..._favoriteProducts, product],
      );
    }
    notifyListeners();
  }

  void addToCart(Product product) {
    _cartItemsCount++;
    notifyListeners();
  }

  void clearCart() {
    if (_cartItemsCount == 0) {
      return;
    }
    _cartItemsCount = 0;
    notifyListeners();
  }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required AppState state,
    required super.child,
  }) : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found');
    return scope!.notifier!;
  }
}
