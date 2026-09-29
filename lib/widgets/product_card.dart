import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    this.onFavoriteToggle,
    this.onAddToCart,
  });

  final Product product;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  onPressed: onFavoriteToggle,
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: onAddToCart,
                  child: const Text('У кошик'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
