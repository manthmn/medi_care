import 'package:flutter/material.dart';
import 'package:medi_care/core/theme/app_dimensions.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_typography.dart';

class DeliveryInfoItem extends StatelessWidget {
  const DeliveryInfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: AppDimensions.padding8,
          decoration: BoxDecoration(
            color: AppTheme.primaryLight10,
            borderRadius: AppDimensions.borderRadiusCircular8,
          ),
          child: Icon(
            icon,
            color: AppTheme.primary,
            size: AppDimensions.iconSize24,
          ),
        ),
        const SizedBox(width: AppDimensions.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.textStyle15SemiBold.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.spacing4),
              Text(
                subtitle,
                style: AppTypography.textStyle13Regular.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
