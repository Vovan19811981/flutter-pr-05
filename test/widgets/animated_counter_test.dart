import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_widgets_app/widgets/animated_counter.dart';

void main() {
  testWidgets('increments value', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: AnimatedCounter(initialValue: 2, maxValue: 5)),
    ));
    expect(find.text('2'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);
    await tester.pumpAndSettle();
  });
}
