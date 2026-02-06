import 'package:flutter/material.dart';

/// Dimensions, spacing, and shadows for the app
class AppDimensions {
  AppDimensions._();

  // ===========================================================================
  // SPACING
  // ===========================================================================

  /// Spacing values (in logical pixels)
  static const double spacing1 = 1.0;
  static const double spacing2 = 2.0;
  static const double spacing4 = 4.0;
  static const double spacing6 = 6.0;
  static const double spacing8 = 8.0;
  static const double spacing10 = 10.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing28 = 28.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing56 = 56.0;
  static const double spacing64 = 64.0;

  // ===========================================================================
  // PADDING
  // ===========================================================================

  /// Common padding values
  static const EdgeInsets padding2 = EdgeInsets.all(2.0);
  static const EdgeInsets padding4 = EdgeInsets.all(4.0);
  static const EdgeInsets padding6 = EdgeInsets.all(6.0);
  static const EdgeInsets padding8 = EdgeInsets.all(8.0);
  static const EdgeInsets padding12 = EdgeInsets.all(12.0);
  static const EdgeInsets padding16 = EdgeInsets.all(16.0);
  static const EdgeInsets padding20 = EdgeInsets.all(20.0);
  static const EdgeInsets padding24 = EdgeInsets.all(24.0);

  /// Horizontal padding
  static const EdgeInsets paddingH4 = EdgeInsets.symmetric(horizontal: 4.0);
  static const EdgeInsets paddingH8 = EdgeInsets.symmetric(horizontal: 8.0);
  static const EdgeInsets paddingH12 = EdgeInsets.symmetric(horizontal: 12.0);
  static const EdgeInsets paddingH16 = EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsets paddingH24 = EdgeInsets.symmetric(horizontal: 24.0);
  static const EdgeInsets paddingH32 = EdgeInsets.symmetric(horizontal: 32.0);

  /// Vertical padding
  static const EdgeInsets paddingV4 = EdgeInsets.symmetric(vertical: 4.0);
  static const EdgeInsets paddingV8 = EdgeInsets.symmetric(vertical: 8.0);
  static const EdgeInsets paddingV12 = EdgeInsets.symmetric(vertical: 12.0);
  static const EdgeInsets paddingV16 = EdgeInsets.symmetric(vertical: 16.0);
  static const EdgeInsets paddingV24 = EdgeInsets.symmetric(vertical: 24.0);
  static const EdgeInsets paddingV32 = EdgeInsets.symmetric(vertical: 32.0);

  /// Screen padding
  static const EdgeInsets screenPadding = EdgeInsets.fromLTRB(16, 12, 16, 16);
  static const EdgeInsets screenPaddingTop = EdgeInsets.fromLTRB(16, 12, 16, 12);

  // ===========================================================================
  // BORDERS
  // ===========================================================================

  /// Border radius
  static const double borderRadius4 = 4.0;
  static const double borderRadius6 = 6.0;
  static const double borderRadius8 = 8.0;
  static const double borderRadius10 = 10.0;
  static const double borderRadius12 = 12.0;
  static const double borderRadius16 = 16.0;
  static const double borderRadius18 = 18.0;
  static const double borderRadius20 = 20.0;
  static const double borderRadius24 = 24.0;
  static const double borderRadius32 = 32.0;
  static const double borderRadius40 = 40.0;
  static const double borderRadius100 = 100.0;

  /// Border radius getters
  static BorderRadius get borderRadiusCircular4 => BorderRadius.circular(borderRadius4);
  static BorderRadius get borderRadiusCircular6 => BorderRadius.circular(borderRadius6);
  static BorderRadius get borderRadiusCircular8 => BorderRadius.circular(borderRadius8);
  static BorderRadius get borderRadiusCircular10 => BorderRadius.circular(borderRadius10);
  static BorderRadius get borderRadiusCircular12 => BorderRadius.circular(borderRadius12);
  static BorderRadius get borderRadiusCircular16 => BorderRadius.circular(borderRadius16);
  static BorderRadius get borderRadiusCircular18 => BorderRadius.circular(borderRadius18);
  static BorderRadius get borderRadiusCircular20 => BorderRadius.circular(borderRadius20);
  static BorderRadius get borderRadiusCircular22 => BorderRadius.circular(22.0);
  static BorderRadius get borderRadiusCircular24 => BorderRadius.circular(borderRadius24);
  static BorderRadius get borderRadiusCircular28 => BorderRadius.circular(28.0);
  static BorderRadius get borderRadiusCircular32 => BorderRadius.circular(borderRadius32);
  static BorderRadius get borderRadiusCircular40 => BorderRadius.circular(borderRadius40);
  static BorderRadius get borderRadiusCircular100 => BorderRadius.circular(borderRadius100);

  /// Border width
  static const double borderWidth1 = 1.0;
  static const double borderWidth2 = 2.0;
  static const double borderWidth4 = 4.0;

  // ===========================================================================
  // SHADOWS
  // ===========================================================================

  /// Box shadows
  static const List<BoxShadow> shadowSmall = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> shadowMedium = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> shadowLarge = [
    BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> shadowXLarge = [
    BoxShadow(
      color: Color(0x29000000),
      blurRadius: 24,
      offset: Offset(0, 12),
    ),
  ];

  // ===========================================================================
  // ICON SIZES
  // ===========================================================================

  /// Icon sizes (in logical pixels)
  static const double iconSize12 = 12.0;
  static const double iconSize14 = 14.0;
  static const double iconSize16 = 16.0;
  static const double iconSize18 = 18.0;
  static const double iconSize20 = 20.0;
  static const double iconSize22 = 22.0;
  static const double iconSize24 = 24.0;
  static const double iconSize28 = 28.0;
  static const double iconSize32 = 32.0;
  static const double iconSize40 = 40.0;
  static const double iconSize48 = 48.0;
  static const double iconSize56 = 56.0;
  static const double iconSize64 = 64.0;
  static const double iconSize72 = 72.0;

  // ===========================================================================
  // DIMENSIONS
  // ===========================================================================

  /// App bar
  static const double appBarHeight = 56.0;
  static const double appBarElevation = 0.0;
  
  /// Bottom navigation bar
  static const double bottomNavBarHeight = 64.0;
  static const double bottomNavBarElevation = 8.0;
  
  /// Buttons
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightLarge = 56.0;
  static const double buttonMinWidth = 88.0;
  
  /// Text fields
  static const double textFieldHeight = 48.0;
  static const double textFieldBorderWidth = 1.0;
  static const double textFieldBorderRadius = 8.0;
  
  /// Cards
  static const double cardElevation = 2.0;
  static const double cardBorderRadius = 12.0;
  
  /// Dialogs
  static const double dialogElevation = 24.0;
  static const double dialogBorderRadius = 20.0;
  
  /// Icons
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  
  /// Dividers
  static const double dividerThickness = 1.0;
  static const double dividerIndent = 16.0;
  static const double dividerEndIndent = 16.0;
  
  /// Progress indicators
  static const double linearProgressIndicatorHeight = 4.0;
  static const double circularProgressIndicatorSize = 24.0;
  
  /// Avatars
  static const double avatarSizeSmall = 32.0;
  static const double avatarSizeMedium = 48.0;
  static const double avatarSizeLarge = 64.0;
  
  /// Badges
  static const double badgeSizeSmall = 16.0;
  static const double badgeSizeMedium = 20.0;
  static const double badgeSizeLarge = 24.0;
  
  /// Chips
  static const double chipHeight = 32.0;
  static const double chipBorderRadius = 16.0;
  
  /// Tabs
  static const double tabBarHeight = 48.0;
  static const double tabBarIndicatorWeight = 2.0;
  
  /// Tooltips
  static const double tooltipHeight = 32.0;
  static const double tooltipBorderRadius = 4.0;
  
  /// Bottom sheet
  static const double bottomSheetBorderRadius = 16.0;
  static const double bottomSheetElevation = 16.0;
  
  /// Snackbar
  static const double snackBarElevation = 6.0;
  static const double snackBarBorderRadius = 4.0;
  
  /// Grid
  static const double gridSpacing = 16.0;
  static const double gridSpacingSmall = 8.0;
  static const double gridSpacingLarge = 24.0;
}
