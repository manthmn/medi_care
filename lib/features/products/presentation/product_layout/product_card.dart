import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/product.dart';
import 'product_layout.dart';
import 'product_image.dart';
import 'discount_badge.dart';
import 'product_quantity_stepper.dart';
import 'product_rating.dart';
import 'product_price.dart';
import 'product_title.dart';
import 'product_description.dart';

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

    if (layout == ProductLayout.grid) {
      return _GridCard(
        product: product,
        discount: discount,
        originalPrice: original,
        onTap: onTap,
      );
    }

    return _ListCard(
      product: product,
      discount: discount,
      originalPrice: original,
      onTap: onTap,
    );
  }
}

class _GridCard extends StatelessWidget {
  final Product product;
  final int? discount;
  final double? originalPrice;
  final VoidCallback onTap;

  const _GridCard({
    required this.product,
    required this.discount,
    required this.originalPrice,
    required this.onTap,
  });

  bool get _isOutOfStock => product.id.hashCode % 7 == 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isOutOfStock ? null : onTap,
      borderRadius: AppDimensions.borderRadiusCircular16,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: AppDimensions.borderRadiusCircular16,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section with discount badge
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  // Product Image
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: ProductImage(
                        url: product.image,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  // Discount badge
                  if (discount != null) DiscountBadge(discount: discount!),
                  // Out of stock overlay
                  if (_isOutOfStock)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Container(
                          color: Colors.white.withValues(alpha: 0.8),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.error.withValues(alpha: 0.1),
                                borderRadius:
                                    AppDimensions.borderRadiusCircular8,
                                border: Border.all(
                                  color: AppTheme.error.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                'Out of Stock',
                                style:
                                    AppTypography.textStyle12SemiBold.copyWith(
                                  color: AppTheme.error,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Content section
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductTitle(title: product.title),
                    const SizedBox(height: 4),
                    ProductRating(
                      rating: product.rating,
                      count: (product.rating * 200).toInt(),
                    ),
                    const Spacer(),
                    ProductPrice(
                      price: product.price,
                      originalPrice: originalPrice,
                    ),
                    const SizedBox(height: 8),
                    if (!_isOutOfStock)
                      ProductQuantityStepper(product: product, isCompact: false)
                    else
                      SizedBox(
                        width: double.infinity,
                        height: AppTheme.buttonHeight36,
                        child: TextButton(
                          onPressed: null,
                          style: TextButton.styleFrom(
                            backgroundColor: AppTheme.surfaceGrey200,
                            disabledForegroundColor: AppTheme.textSecondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppDimensions.borderRadiusCircular8,
                            ),
                          ),
                          child: Text(
                            'Notify Me',
                            style: AppTypography.textStyle13SemiBold.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListCard extends StatelessWidget {
  final Product product;
  final int? discount;
  final double? originalPrice;
  final VoidCallback onTap;

  const _ListCard({
    required this.product,
    required this.discount,
    required this.originalPrice,
    required this.onTap,
  });

  bool get _isOutOfStock => product.id.hashCode % 7 == 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isOutOfStock ? null : onTap,
      borderRadius: AppDimensions.borderRadiusCircular16,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: AppDimensions.borderRadiusCircular16,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: AppDimensions.borderRadiusCircular12,
                    child: SizedBox(
                      width: 90,
                      height: 90,
                      child: Stack(
                        children: [
                          ProductImage(
                            url: product.image,
                            height: 90,
                            width: 90,
                            borderRadius: AppDimensions.borderRadiusCircular12,
                          ),
                          // Out of stock overlay for list
                          if (_isOutOfStock)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  borderRadius:
                                      AppDimensions.borderRadiusCircular12,
                                ),
                                child: Center(
                                  child: Text(
                                    'Out of\nStock',
                                    textAlign: TextAlign.center,
                                    style: AppTypography.textStyle11SemiBold
                                        .copyWith(
                                      color: AppTheme.error,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (discount != null && !_isOutOfStock)
                    DiscountBadge(discount: discount!, isSmall: true),
                ],
              ),

              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ProductTitle(title: product.title),
                    const SizedBox(height: 2),
                    ProductDescription(description: product.description),
                    const SizedBox(height: 6),
                    ProductRating(
                      rating: product.rating,
                      count: (product.rating * 200).toInt(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ProductPrice(
                            price: product.price,
                            originalPrice: originalPrice,
                          ),
                        ),
                        if (!_isOutOfStock)
                          ProductQuantityStepper(
                              product: product, isCompact: true)
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceGrey200,
                              borderRadius: AppDimensions.borderRadiusCircular8,
                            ),
                            child: Text(
                              'Notify Me',
                              style: AppTypography.textStyle12SemiBold.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
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
    );
  }
}
