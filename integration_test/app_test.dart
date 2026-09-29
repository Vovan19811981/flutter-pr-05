import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mobile_widgets_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('opens products and adds an item to cart', (tester) async {
    await tester.pumpWidget(const WidgetsApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Товари'));
    await tester.pumpAndSettle();
    expect(find.text('Notebook'), findsOneWidget);

    await tester.tap(find.text('До кошика').first);
    await tester.pumpAndSettle();
    expect(find.text('Кошик: 1'), findsOneWidget);
  });
}
