import 'dart:async';

import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatefulWidget {
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
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;
  Timer? _loadingTimer;
  bool _loading = true;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _loadingTimer = Timer(const Duration(milliseconds: 650), () {
      if (!mounted) {
        return;
      }
      _shimmerController.stop();
      setState(() => _loading = false);
    });
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    _shimmerController.dispose();
    super.dispose();
  }

  Future<bool> _handleSwipe(DismissDirection direction) async {
    widget.onFavoriteToggle?.call();
    return false;
  }

  void _showZoom() {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 360,
          height: 360,
          child: InteractiveViewer(
            minScale: 0.8,
            maxScale: 3,
            child: _ProductVisual(
              product: widget.product,
              animation: _shimmerController,
              loading: false,
              expanded: true,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: ValueKey('product-${widget.product.id}'),
      confirmDismiss: _handleSwipe,
      background: ColoredBox(
        color: theme.colorScheme.primaryContainer,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Icon(Icons.favorite_outline),
          ),
        ),
      ),
      secondaryBackground: ColoredBox(
        color: theme.colorScheme.primaryContainer,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Icon(Icons.favorite_outline),
          ),
        ),
      ),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.985 : 1,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: _showZoom,
            onTapDown: (_) => setState(() => _pressed = true),
            onTapUp: (_) => setState(() => _pressed = false),
            onTapCancel: () => setState(() => _pressed = false),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 140,
                  child: _ProductVisual(
                    product: widget.product,
                    animation: _shimmerController,
                    loading: _loading,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(widget.product.name, style: theme.textTheme.titleMedium),
                          ),
                          IconButton(
                            tooltip: 'Обране',
                            onPressed: widget.onFavoriteToggle,
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 180),
                              child: Icon(
                                widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                                key: ValueKey(widget.isFavorite),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(widget.product.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.product.price.toStringAsFixed(0)} грн',
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                          FilledButton.icon(
                            onPressed: widget.onAddToCart,
                            icon: const Icon(Icons.add_shopping_cart),
                            label: const Text('До кошика'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductVisual extends StatelessWidget {
  const _ProductVisual({
    required this.product,
    required this.animation,
    required this.loading,
    this.expanded = false,
  });

  final Product product;
  final Animation<double> animation;
  final bool loading;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    Widget content() => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: expanded ? 110 : 56,
                color: scheme.primary,
              ),
              if (expanded) ...[
                const SizedBox(height: 16),
                Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
              ],
            ],
          ),
        );

    if (!loading) {
      return ColoredBox(
        color: scheme.primaryContainer.withAlpha(89),
        child: content(),
      );
    }

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1 + animation.value * 0.4, -1),
            end: Alignment(1 + animation.value * 0.4, 1),
            colors: [
              scheme.surface,
              scheme.primaryContainer.withAlpha(166),
              scheme.surface,
            ],
          ),
        ),
        child: content(),
      ),
    );
  }
}
