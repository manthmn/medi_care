import 'package:flutter/material.dart';
import 'package:medi_care/l10n/app_localizations.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_dimensions.dart';
import 'package:medi_care/core/theme/app_typography.dart';
import '../../domain/entities/product.dart';

class AddToCartButton extends StatelessWidget {
  final Product product;
  final bool isCompact;
  final VoidCallback onPressed;

  const AddToCartButton({
    super.key,
    required this.product,
    required this.isCompact,
    required this.onPressed,
  });

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
