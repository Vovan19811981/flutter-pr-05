import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_widgets_app/widgets/custom_button.dart';

void main() {
  testWidgets('renders text and calls onPressed', (tester) async {
    var pressed = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomButton(text: 'Action', onPressed: () => pressed = true),
      ),
    ));
    expect(find.text('Action'), findsOneWidget);
    await tester.tap(find.text('Action'));
    expect(pressed, isTrue);
  });

  testWidgets('shows loading state', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: CustomButton(text: 'Action', isLoading: true)),
    ));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
