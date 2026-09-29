import 'package:flutter/material.dart';

import '../utils/app_state.dart';
import '../utils/constants.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900
            ? 3
            : constraints.maxWidth >= 580
                ? 2
                : 1;
        if (columns == 1) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: demoProducts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) => ProductCard(
              product: demoProducts[index],
              isFavorite: state.isFavorite(demoProducts[index]),
              onFavoriteToggle: () => state.toggleFavorite(demoProducts[index]),
              onAddToCart: () => state.addToCart(demoProducts[index]),
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.86,
          ),
          itemCount: demoProducts.length,
          itemBuilder: (context, index) => ProductCard(
            product: demoProducts[index],
            isFavorite: state.isFavorite(demoProducts[index]),
            onFavoriteToggle: () => state.toggleFavorite(demoProducts[index]),
            onAddToCart: () => state.addToCart(demoProducts[index]),
          ),
        );
      },
    );
  }
}
