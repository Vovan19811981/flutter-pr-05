import 'package:flutter/material.dart';

import '../utils/app_state.dart';
import '../utils/constants.dart';
import '../widgets/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final user = state.currentUser ?? demoUser;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ProfileWidget(
          user: user,
          onEditPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Редагування профілю')), 
            );
          },
        ),
        const SizedBox(height: 20),
        Text('Обраних товарів: ${state.favoriteProducts.length}'),
        Text('Товарів у кошику: ${state.cartItemsCount}'),
      ],
    );
  }
}
