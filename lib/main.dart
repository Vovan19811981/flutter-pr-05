import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/products_screen.dart';
import 'screens/profile_screen.dart';
import 'utils/app_state.dart';
import 'utils/constants.dart';
import 'utils/themes.dart';

void main() {
  runApp(const WidgetsApp());
}

class WidgetsApp extends StatefulWidget {
  const WidgetsApp({super.key});

  @override
  State<WidgetsApp> createState() => _WidgetsAppState();
}

class _WidgetsAppState extends State<WidgetsApp> {
  late final AppState _state;

  @override
  void initState() {
    super.initState();
    _state = AppState()..setCurrentUser(demoUser);
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      state: _state,
      child: MaterialApp(
        title: 'Mobile Widgets',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light(),
        home: const _MainShell(),
      ),
    );
  }
}

class _MainShell extends StatefulWidget {
  const _MainShell();

  @override
  State<_MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<_MainShell> {
  int _index = 0;

  static const _screens = <Widget>[
    HomeScreen(),
    ProductsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final titles = <String>['Компоненти', 'Товари', 'Профіль'];
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_index]),
        actions: [
          if (_index == 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(child: Text('Кошик: ${state.cartItemsCount}')),
            ),
        ],
      ),
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.widgets_outlined), label: 'Компоненти'),
          NavigationDestination(icon: Icon(Icons.storefront_outlined), label: 'Товари'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Профіль'),
        ],
      ),
    );
  }
}
