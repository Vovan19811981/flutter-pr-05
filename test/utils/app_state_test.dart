import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_widgets_app/models/product.dart';
import 'package:mobile_widgets_app/utils/app_state.dart';

void main() {
  test('updates favorites and cart', () {
    const product = Product(
      id: '1',
      name: 'Test',
      description: '',
      price: 1,
      category: 'Test',
    );
    final state = AppState();
    state.toggleFavorite(product);
    state.addToCart(product);
    expect(state.isFavorite(product), isTrue);
    expect(state.cartItemsCount, 1);
    state.dispose();
  });
}
