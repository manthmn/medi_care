import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_care/l10n/app_localizations.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../domain/entities/product.dart';

class ProductQuantityStepper extends StatelessWidget {
  const ProductQuantityStepper({
    super.key,
    required this.product,
    this.isCompact = true,
  });

  final Product product;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (prev, next) => _quantityFor(prev) != _quantityFor(next),
      builder: (context, state) {
        final quantity = _quantityFor(state);
        if (quantity == 0) {
          return _AddToCartButton(
            product: product,
            isCompact: isCompact,
            onPressed: () => _updateQuantity(context, 1),
          );
        }
        return _QuantityControls(
          product: product,
          quantity: quantity,
          isCompact: isCompact,
          onDecrement: () => _updateQuantity(context, quantity - 1),
          onIncrement: () => _updateQuantity(context, quantity + 1),
        );
      },
    );
  }

  int _quantityFor(CartState state) {
    final match = state.items.where((e) => e.product.id == product.id).toList();
    if (match.isEmpty) return 0;
    return match.first.quantity;
  }

  void _updateQuantity(BuildContext context, int quantity) {
    context.read<CartBloc>().add(
          CartItemQuantityChanged(product: product, quantity: quantity),
        );
  }
}

class _AddToCartButton extends StatelessWidget {
  const _AddToCartButton({
    required this.product,
    required this.isCompact,
    required this.onPressed,
  });

  final Product product;
  final bool isCompact;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (isCompact) {
      // Compact button for list view
      return SizedBox(
        height: AppTheme.buttonHeight36,
        child: TextButton.icon(
          style: TextButton.styleFrom(
            backgroundColor: AppTheme.primary,
            foregroundColor: AppTheme.backgroundWhite,
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing16, vertical: 0),
            shape: RoundedRectangleBorder(
              borderRadius: AppDimensions.borderRadiusCircular8,
            ),
          ),
          onPressed: onPressed,
          icon: const Icon(
            Icons.add,
            size: AppDimensions.iconSize18,
          ),
          label: Text(
            l10n.add,
            style: AppTypography.textStyle13SemiBold,
          ),
        ),
      );
    } else {
      // Full width button for grid view
      return SizedBox(
        width: double.infinity,
        height: AppTheme.buttonHeight36,
        child: TextButton.icon(
          style: TextButton.styleFrom(
            backgroundColor: AppTheme.primary,
            foregroundColor: AppTheme.backgroundWhite,
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing12, vertical: 0),
            shape: RoundedRectangleBorder(
              borderRadius: AppDimensions.borderRadiusCircular8,
            ),
          ),
          onPressed: onPressed,
          icon: const Icon(
            Icons.shopping_cart_outlined,
            size: AppDimensions.iconSize16,
          ),
          label: Text(
            l10n.addToCart,
            style: AppTypography.textStyle13SemiBold,
          ),
        ),
      );
    }
  }
}

class _QuantityControls extends StatelessWidget {
  const _QuantityControls({
    required this.product,
    required this.quantity,
    required this.isCompact,
    required this.onDecrement,
    required this.onIncrement,
  });

  final Product product;
  final int quantity;
  final bool isCompact;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      // Compact controls for list view
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: AppTheme.buttonHeight36,
            decoration: BoxDecoration(
              color: AppTheme.surfaceGrey200,
              borderRadius: AppDimensions.borderRadiusCircular8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  iconSize: AppDimensions.iconSize18,
                  visualDensity: VisualDensity.compact,
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: AppDimensions.borderRadiusCircular8,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: onDecrement,
                  icon: Icon(
                    quantity == 1 ? Icons.delete_outline : Icons.remove,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacing6),
                  child: Text(
                    '$quantity',
                    style: AppTypography.textStyle14SemiBold,
                  ),
                ),
                IconButton(
                  iconSize: AppDimensions.iconSize18,
                  visualDensity: VisualDensity.compact,
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: AppDimensions.borderRadiusCircular8,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: onIncrement,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      // Full width controls for grid view
      return Container(
        width: double.infinity,
        height: AppTheme.buttonHeight36,
        decoration: BoxDecoration(
          color: AppTheme.surfaceGrey200,
          borderRadius: AppDimensions.borderRadiusCircular8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: AppDimensions.iconSize18,
              visualDensity: VisualDensity.compact,
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: AppDimensions.borderRadiusCircular8,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing12),
              onPressed: onDecrement,
              icon: Icon(
                quantity == 1 ? Icons.delete_outline : Icons.remove,
              ),
            ),
            Text(
              '$quantity',
              style: AppTypography.textStyle14SemiBold,
            ),
            IconButton(
              iconSize: AppDimensions.iconSize18,
              visualDensity: VisualDensity.compact,
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: AppDimensions.borderRadiusCircular8,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing12),
              onPressed: onIncrement,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      );
    }
  }
}
