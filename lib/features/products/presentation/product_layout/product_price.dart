import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';

class ProductPrice extends StatelessWidget {
  final double price;
  final double? originalPrice;

  const ProductPrice({
    super.key,
    required this.price,
    this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '₹${price.toStringAsFixed(0)}',
          style: AppTypography.textStyle16SemiBold.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (originalPrice != null) ...[
          const SizedBox(width: 6),
          Text(
            '₹${originalPrice!.toStringAsFixed(0)}',
            style: AppTypography.textStyle12Regular.copyWith(
              decoration: TextDecoration.lineThrough,
              decorationColor: AppTheme.textSecondary,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
