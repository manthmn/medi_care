import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import 'product_layout.dart';
import 'product_card_grid.dart';
import 'product_card_list.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ProductLayout layout;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.layout,
    required this.onTap,
  });

  bool get _isOutOfStock => product.id.hashCode % 7 == 0;

  int? _discount() {
    final random = product.id.hashCode % 4;
    if (random == 0) return 25;
    if (random == 1) return 20;
    if (random == 2) return 23;
    return null;
  }

  double? _originalPrice(int? discount) {
    if (discount == null) return null;
    return product.price / (1 - discount / 100);
  }

  @override
  Widget build(BuildContext context) {
    final discount = _discount();
    final original = _originalPrice(discount);
    final isOutOfStock = _isOutOfStock;

    if (layout == ProductLayout.grid) {
      return ProductCardGrid(
        product: product,
        discount: discount,
        originalPrice: original,
        isOutOfStock: isOutOfStock,
        onTap: onTap,
      );
    }

    return ProductCardList(
      product: product,
      discount: discount,
      originalPrice: original,
      isOutOfStock: isOutOfStock,
      onTap: onTap,
    );
  }
}
