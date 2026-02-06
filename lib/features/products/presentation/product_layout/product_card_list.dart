import 'package:flutter/material.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_dimensions.dart';
import 'package:medi_care/core/theme/app_typography.dart';
import '../../domain/entities/product.dart';
import 'product_image.dart';
import 'discount_badge.dart';
import 'product_quantity_stepper.dart';
import 'product_rating.dart';
import 'product_price.dart';
import 'product_title.dart';
import 'product_description.dart';

class ProductCardList extends StatelessWidget {
  final Product product;
  final int? discount;
  final double? originalPrice;
  final VoidCallback onTap;

  const ProductCardList({
    super.key,
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
