import 'package:flutter/material.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_dimensions.dart';
import 'package:medi_care/core/theme/app_typography.dart';
import '../screens/product_list_screen.dart';
import 'view_toggle.dart';

class DeliveryHeader extends StatelessWidget {
  final ViewMode viewMode;
  final ValueChanged<ViewMode> onViewModeChanged;

  const DeliveryHeader({
    super.key,
    required this.viewMode,
    required this.onViewModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: AppDimensions.screenPaddingTop,
        child: Row(
          children: [
            Container(
              padding: AppDimensions.padding6,
              decoration: BoxDecoration(
                color: AppTheme.primaryLight10,
                borderRadius: AppDimensions.borderRadiusCircular8,
              ),
              child: const Icon(
                Icons.location_on,
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deliver to',
                    style: AppTypography.textStyle11Regular.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const Text(
                    'Mumbai, 400001',
                    style: TextStyle(
                      fontWeight: AppTypography.fontWeightSemiBold,
                    ),
                  ),
                ],
              ),
            ),
            ViewToggle(
              viewMode: viewMode,
              onChanged: onViewModeChanged,
            ),
          ],
        ),
      ),
    );
  }
}
