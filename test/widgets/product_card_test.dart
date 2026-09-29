import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_widgets_app/models/product.dart';
import 'package:mobile_widgets_app/widgets/product_card.dart';

void main() {
  testWidgets('renders product and cart action', (tester) async {
    const product = Product(
      id: '1',
      name: 'Notebook',
      description: 'Description',
      price: 100,
      category: 'Test',
    );
    var added = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ProductCard(
          product: product,
          isFavorite: false,
          onAddToCart: () => added = true,
        ),
      ),
    ));
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.text('Notebook'), findsOneWidget);
    await tester.tap(find.text('До кошика'));
    expect(added, isTrue);
  });
}
