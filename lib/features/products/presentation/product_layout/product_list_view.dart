import 'package:flutter/material.dart';
import 'package:medi_care/core/utils/responsive_grid.dart';
import '../../domain/entities/product.dart';

import '../screens/product_detail_screen.dart';
import 'product_card.dart';
import 'product_layout.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products;
  final ProductLayout layout;

  /// optional — makes widget future-proof
  final ScrollController? controller;
  final EdgeInsets padding;

  const ProductListView({
    super.key,
    required this.products,
    required this.layout,
    this.controller,
    this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 16),
  });

  @override
  Widget build(BuildContext context) {
    /// VERY IMPORTANT:
    /// Never let empty lists hit Grid/List.
    if (products.isEmpty) {
      return const SizedBox();
    }

    switch (layout) {
      case ProductLayout.grid:
        return _GridView(
          products: products,
          controller: controller,
          padding: padding,
        );

      case ProductLayout.list:
        return _ListView(
          products: products,
          controller: controller,
          padding: padding,
        );
    }
  }
}

////////////////////////////////////////////////////////////
/// GRID
////////////////////////////////////////////////////////////

class _GridView extends StatelessWidget {
  final List<Product> products;
  final ScrollController? controller;
  final EdgeInsets padding;

  const _GridView({
    required this.products,
    required this.controller,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,

      /// CRITICAL for performance
      physics: const BouncingScrollPhysics(),

      padding: padding,
      itemCount: products.length,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // based on device size
        crossAxisCount: ResponsiveGrid.crossAxisCount(context),

        /// controls card height - lower ratio = taller cards
        childAspectRatio: 0.56,

        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),

      itemBuilder: (_, index) {
        final product = products[index];

        return ProductCard(
          product: product,
          layout: ProductLayout.grid,
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetailScreen.routeName,
              arguments: product,
            );
          },
        );
      },
    );
  }
}

////////////////////////////////////////////////////////////
/// LIST
////////////////////////////////////////////////////////////

class _ListView extends StatelessWidget {
  final List<Product> products;
  final ScrollController? controller;
  final EdgeInsets padding;

  const _ListView({
    required this.products,
    required this.controller,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,

      /// smoother scrolling
      physics: const BouncingScrollPhysics(),

      padding: padding,
      itemCount: products.length,

      separatorBuilder: (_, __) => const SizedBox(height: 12),

      itemBuilder: (_, index) {
        final product = products[index];

        return ProductCard(
          product: product,
          layout: ProductLayout.list,
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetailScreen.routeName,
              arguments: product,
            );
          },
        );
      },
    );
  }
}
