import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';

class ProductTitle extends StatelessWidget {
  final String title;
  final int maxLines;

  const ProductTitle({
    super.key,
    required this.title,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: AppTypography.textStyle14SemiBold.copyWith(
        color: AppTheme.textPrimary,
        height: 1.3,
      ),
    );
  }
}
