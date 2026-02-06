import 'package:flutter/material.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_dimensions.dart';

import '../screens/product_list_screen.dart';

class ViewToggle extends StatelessWidget {
  final ViewMode viewMode;
  final ValueChanged<ViewMode> onChanged;

  const ViewToggle({
    super.key,
    required this.viewMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceGrey100,
        borderRadius:
            AppDimensions.borderRadiusCircular8,
      ),
      child: Row(
        children: [
          _button(Icons.grid_view_rounded,
              ViewMode.grid),
          _button(Icons.view_list_rounded,
              ViewMode.list),
        ],
      ),
    );
  }

  Widget _button(IconData icon, ViewMode mode) {
    final isSelected = viewMode == mode;

    return InkWell(
      onTap: () => onChanged(mode),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.white : Colors.transparent,
          borderRadius:
              AppDimensions.borderRadiusCircular6,
        ),
        child: Icon(
          icon,
          color: isSelected
              ? AppTheme.primary
              : AppTheme.textSecondary,
        ),
      ),
    );
  }
}
