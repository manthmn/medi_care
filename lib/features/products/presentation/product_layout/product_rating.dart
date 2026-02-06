import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';

class ProductRating extends StatelessWidget {
  final double rating;
  final int count;

  const ProductRating({
    super.key,
    required this.rating,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.star_rounded,
          color: AppTheme.ratingStar,
          size: 14,
        ),
        const SizedBox(width: 3),
        Text(
          rating.toStringAsFixed(1),
          style: AppTypography.textStyle12SemiBold.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          '($count)',
          style: AppTypography.textStyle11Regular.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
