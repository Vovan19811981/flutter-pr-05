import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_widgets_app/models/user.dart';
import 'package:mobile_widgets_app/widgets/profile_widget.dart';

void main() {
  testWidgets('renders profile data', (tester) async {
    const user = User(id: '1', name: 'Test User', email: 'test@example.com');
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: ProfileWidget(user: user)),
    ));
    expect(find.text('Test User'), findsOneWidget);
    expect(find.text('test@example.com'), findsOneWidget);
  });
}
