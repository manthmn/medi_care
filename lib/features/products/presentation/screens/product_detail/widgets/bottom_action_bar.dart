import 'package:flutter/material.dart';
import 'package:medi_care/core/theme/app_dimensions.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_typography.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    required this.quantity,
    required this.price,
    required this.cartTotal,
    required this.cartItemCount,
    required this.onQuantityChanged,
    required this.onAddToCart,
    required this.onGoToCart,
  });

  final int quantity;
  final double price;
  final double cartTotal;
  final int cartItemCount;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onAddToCart;
  final VoidCallback onGoToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: AppTheme.opacity05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: AppTheme.bottomBarPadding,
      child: SafeArea(
        top: false,
        child: quantity == 0
            ? _buildAddToCartButton()
            : _buildQuantityWithCartBar(),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onAddToCart,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: AppTheme.backgroundWhite,
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusCircular12,
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined,
                size: AppDimensions.iconSize20),
            const SizedBox(width: AppDimensions.spacing8),
            Text(
              'Add to Cart  •  ₹${price.toStringAsFixed(0)}',
              style: AppTypography.textStyle16SemiBold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityWithCartBar() {
    return Row(
      children: [
        // Quantity Selector
        Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryLight,
            borderRadius: AppDimensions.borderRadiusCircular12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  quantity == 1 ? Icons.delete_outline : Icons.remove,
                  color: AppTheme.primary,
                ),
                onPressed: () => onQuantityChanged(quantity - 1),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: AppTheme.buttonHeight40,
                  minHeight: AppTheme.buttonHeight40,
                ),
              ),
              SizedBox(
                width: 30,
                child: Text(
                  '$quantity',
                  textAlign: TextAlign.center,
                  style: AppTypography.textStyle16SemiBold.copyWith(
                    fontWeight: AppTypography.fontWeightBold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: AppTheme.primary),
                onPressed: () => onQuantityChanged(quantity + 1),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: AppTheme.buttonHeight40,
                  minHeight: AppTheme.buttonHeight40,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppDimensions.spacing12),
        // Go to Cart Button (Zepto style)
        Expanded(
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: onGoToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.backgroundWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: AppDimensions.borderRadiusCircular12,
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$cartItemCount ${cartItemCount == 1 ? 'item' : 'items'}',
                        style: AppTypography.textStyle12Regular.copyWith(
                          color: AppTheme.textOnPrimary.withValues(alpha: 0.8),
                        ),
                      ),
                      Text(
                        '₹${cartTotal.toStringAsFixed(0)}',
                        style: AppTypography.textStyle16SemiBold.copyWith(
                          color: AppTheme.textOnPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'View Cart',
                        style: AppTypography.textStyle14SemiBold.copyWith(
                          color: AppTheme.textOnPrimary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
