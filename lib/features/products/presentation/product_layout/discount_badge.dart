import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_dimensions.dart';

class DiscountBadge extends StatelessWidget {
  final int discount;
  final bool isSmall;

  const DiscountBadge({
    super.key,
    required this.discount,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: isSmall ? 6 : 8,
      left: isSmall ? 6 : 8,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSmall ? 6 : 8,
          vertical: isSmall ? 3 : 4,
        ),
        decoration: BoxDecoration(
          color: AppTheme.errorPink,
          borderRadius: AppDimensions.borderRadiusCircular6,
          boxShadow: [
            BoxShadow(
              color: AppTheme.errorPink.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          '$discount% OFF',
          style: TextStyle(
            color: AppTheme.textOnPrimary,
            fontWeight: FontWeight.w700,
            fontSize: isSmall ? 9 : 11,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
