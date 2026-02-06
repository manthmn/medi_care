import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:medi_care/l10n/app_localizations.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/cart_item.dart';
import '../bloc/cart_bloc.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
    this.onRemove,
  });

  final CartItem item;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: AppDimensions.borderRadiusCircular16,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
            // Product Image
            ClipRRect(
              borderRadius: AppDimensions.borderRadiusCircular12,
              child: CachedNetworkImage(
                imageUrl: item.product.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  width: 80,
                  height: 80,
                  color: AppTheme.surfaceGrey200,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  width: 80,
                  height: 80,
                  color: AppTheme.surfaceGrey200,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Remove Button Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.textStyle14SemiBold.copyWith(
                            color: AppTheme.textPrimary,
                            height: 1.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: onRemove,
                        borderRadius: AppDimensions.borderRadiusCircular8,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.delete_outline,
                            size: AppDimensions.iconSize20,
                            color: AppTheme.error.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Description
                  Text(
                    item.product.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.textStyle12Regular.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Price and Quantity Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${l10n.currencySymbol}${item.totalPrice.toStringAsFixed(0)}',
                            style: AppTypography.textStyle16SemiBold.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (item.quantity > 1)
                            Text(
                              '${l10n.currencySymbol}${item.product.price.toStringAsFixed(0)} ${l10n.priceEach}',
                              style: AppTypography.textStyle11Regular.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                        ],
                      ),

                      // Quantity Stepper
                      _QuantityStepper(item: item),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceGrey200,
        borderRadius: AppDimensions.borderRadiusCircular8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(
            icon: item.quantity == 1 ? Icons.delete_outline : Icons.remove,
            onPressed: () {
              context.read<CartBloc>().add(
                    CartItemQuantityChanged(
                      product: item.product,
                      quantity: item.quantity - 1,
                    ),
                  );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${item.quantity}',
              style: AppTypography.textStyle14SemiBold.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          _StepperButton(
            icon: Icons.add,
            onPressed: () {
              context.read<CartBloc>().add(
                    CartItemQuantityChanged(
                      product: item.product,
                      quantity: item.quantity + 1,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppDimensions.borderRadiusCircular8,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: AppDimensions.iconSize18,
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }
}
