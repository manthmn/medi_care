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

class ProductCardGrid extends StatelessWidget {
  final Product product;
  final int? discount;
  final double? originalPrice;
  final VoidCallback onTap;

  const ProductCardGrid({
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section with discount badge
            Expanded(
              flex: 5,
              child: Stack(
                children: [
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
                  if (discount != null) DiscountBadge(discount: discount!),
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
