import 'package:flutter/material.dart';
import 'package:medi_care/l10n/app_localizations.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_dimensions.dart';
import 'package:medi_care/core/theme/app_typography.dart';
import '../../../../shared/widgets/cart_icon_badge.dart';
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
    final l10n = AppLocalizations.of(context)!;
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
                    l10n.deliverTo,
                    style: AppTypography.textStyle11Regular.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  Text(
                    l10n.defaultAddress,
                    style: const TextStyle(
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
            const CartIconBadge(),
          ],
        ),
      ),
    );
  }
}
