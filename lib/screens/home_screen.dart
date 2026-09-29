import 'package:flutter/material.dart';

import '../utils/app_state.dart';
import '../utils/constants.dart';
import '../widgets/animated_counter.dart';
import '../widgets/custom_button.dart';
import '../widgets/product_card.dart';
import '../widgets/profile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _compactProfile = true;
  bool _buttonLoading = false;

  Future<void> _simulateLoading() async {
    setState(() => _buttonLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (mounted) {
      setState(() => _buttonLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final demoProduct = demoProducts.first;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ProfileWidget(user: demoUser, isCompact: true)
        Text('ProfileWidget', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        ProfileWidget(
          user: demoUser,
          isCompact: _compactProfile,
          onEditPressed: () {},
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Compact mode'),
          value: _compactProfile,
          onChanged: (value) => setState(() => _compactProfile = value),
        ),
        const SizedBox(height: 18),
        // CustomButton(text: 'Primary', onPressed: () {})
        Text('CustomButton', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            CustomButton(text: 'Primary', onPressed: () {}),
            CustomButton(
              text: 'Secondary',
              style: CustomButtonStyle.secondary,
              onPressed: () {},
            ),
            CustomButton(
              text: 'Danger',
              style: CustomButtonStyle.danger,
              icon: const Icon(Icons.delete_outline),
              onPressed: () {},
            ),
            CustomButton(
              text: 'Loading',
              style: CustomButtonStyle.outline,
              isLoading: _buttonLoading,
              onPressed: _simulateLoading,
            ),
          ],
        ),
        const SizedBox(height: 24),
        // AnimatedCounter(initialValue: 6, maxValue: 10)
        Text('AnimatedCounter', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        const AnimatedCounter(initialValue: 6, maxValue: 10),
        const SizedBox(height: 24),
        // ProductCard(product: demoProduct, isFavorite: false)
        Text('ProductCard', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        ProductCard(
          product: demoProduct,
          isFavorite: state.isFavorite(demoProduct),
          onFavoriteToggle: () => state.toggleFavorite(demoProduct),
          onAddToCart: () => state.addToCart(demoProduct),
        ),
      ],
    );
  }
}
