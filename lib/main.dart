import 'package:flutter/material.dart';

void main() => runApp(const WidgetsDemoApp());

class WidgetsDemoApp extends StatelessWidget {
  const WidgetsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(
        body: Center(child: Text('Widgets demo')),
      ),
    );
  }
}
