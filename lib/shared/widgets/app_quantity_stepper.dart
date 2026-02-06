import 'package:flutter/material.dart';
import 'package:medi_care/core/theme/app_dimensions.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_typography.dart';

class AppQuantityStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool isCompact;
  final bool showDeleteOnOne;

  const AppQuantityStepper({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.isCompact = true,
    this.showDeleteOnOne = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return Container(
        height: AppTheme.buttonHeight36,
        decoration: BoxDecoration(
          color: AppTheme.surfaceGrey200,
          borderRadius: AppDimensions.borderRadiusCircular8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _StepperButton(
              icon: (quantity == 1 && showDeleteOnOne)
                  ? Icons.delete_outline
                  : Icons.remove,
              onPressed: onDecrement,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing6),
              child: Text(
                '$quantity',
                style: AppTypography.textStyle14SemiBold.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
            _StepperButton(
              icon: Icons.add,
              onPressed: onIncrement,
            ),
          ],
        ),
      );
    } else {
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
            _StepperButton(
              icon: (quantity == 1 && showDeleteOnOne)
                  ? Icons.delete_outline
                  : Icons.remove,
              onPressed: onDecrement,
            ),
            Text(
              '$quantity',
              style: AppTypography.textStyle14SemiBold.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
            _StepperButton(
              icon: Icons.add,
              onPressed: onIncrement,
            ),
          ],
        ),
      );
    }
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
    return IconButton(
      iconSize: AppDimensions.iconSize18,
      visualDensity: VisualDensity.compact,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusCircular8,
        ),
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppTheme.primary,
      ),
    );
  }
}
