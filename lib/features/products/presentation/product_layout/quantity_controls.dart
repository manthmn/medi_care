import 'package:flutter/material.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_dimensions.dart';
import 'package:medi_care/core/theme/app_typography.dart';
import '../../domain/entities/product.dart';

class QuantityControls extends StatelessWidget {
  final Product product;
  final int quantity;
  final bool isCompact;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityControls({
    super.key,
    required this.product,
    required this.quantity,
    required this.isCompact,
    required this.onDecrement,
    required this.onIncrement,
  });

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
                _buildIconButton(
                  icon: quantity == 1 ? Icons.delete_outline : Icons.remove,
                  onPressed: onDecrement,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacing6),
                  child: Text(
                    '$quantity',
                    style: AppTypography.textStyle14SemiBold,
                  ),
                ),
                _buildIconButton(
                  icon: Icons.add,
                  onPressed: onIncrement,
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
            _buildIconButton(
              icon: quantity == 1 ? Icons.delete_outline : Icons.remove,
              onPressed: onDecrement,
              horizontalPadding: AppDimensions.spacing12,
            ),
            Text(
              '$quantity',
              style: AppTypography.textStyle14SemiBold,
            ),
            _buildIconButton(
              icon: Icons.add,
              onPressed: onIncrement,
              horizontalPadding: AppDimensions.spacing12,
            ),
          ],
        ),
      );
    }
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    double? horizontalPadding,
  }) {
    return IconButton(
      iconSize: AppDimensions.iconSize18,
      visualDensity: VisualDensity.compact,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusCircular8,
        ),
      ),
      padding: horizontalPadding != null
          ? EdgeInsets.symmetric(horizontal: horizontalPadding)
          : EdgeInsets.zero,
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }
}
