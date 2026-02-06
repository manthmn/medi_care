import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';

class ProductDescription extends StatelessWidget {
  final String description;
  final int maxLines;

  const ProductDescription({
    super.key,
    required this.description,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: AppTypography.textStyle12Regular.copyWith(
        color: AppTheme.textSecondary,
        height: 1.3,
      ),
    );
  }
}
