import 'package:flutter/material.dart';

/// App Color System - Centralized color tokens for consistent UI
/// This file should only contain color-related constants.
/// For typography, use app_typography.dart
/// For dimensions, shadows, and other UI constants, use app_dimensions.dart
class AppTheme {
  AppTheme._();

  // ===========================================================================
  // PRIMARY COLORS
  // ===========================================================================

  /// Primary brand color - Teal/Blue
  // static const Color primary = Color(0xFF0089C5);

  /// Secondary teal color (for empty states)
  static const Color primary = Color(0xFF5DB2B0);
  
  /// Primary light background
  static const Color primaryLight = Color(0xFFE0F5FF);
  
  /// Primary with 10% opacity
  static Color get primaryLight10 => primary.withValues(alpha: 0.1);
  
  /// Primary with 8% opacity
  static Color get primaryLight8 => primary.withValues(alpha: 0.08);
  
  /// Primary with 15% opacity
  static Color get primaryLight15 => primary.withValues(alpha: 0.15);
  
  /// Primary with 18% opacity
  static Color get primaryLight18 => primary.withValues(alpha: 0.18);

  // ===========================================================================
  // SEMANTIC COLORS
  // ===========================================================================

  /// Success/Green color
  static const Color success = Color(0xFF0AC880);
  
  /// Success light background
  static const Color successLight = Color(0xFFE0F2F1);
  
  /// Success with 10% opacity
  static Color get successLight10 => success.withValues(alpha: 0.1);
  
  /// Success with 15% opacity
  static Color get successLight15 => success.withValues(alpha: 0.15);
  
  /// Secondary teal color (for empty states)
  static const Color secondaryTeal = Color(0xFF5DB2B0);

  /// Error/Red color
  static const Color error = Color(0xFFFF5252);
  
  /// Error/Pink color (for discount badges)
  static const Color errorPink = Color(0xFFE91E63);

  /// Warning/Orange color
  static const Color warning = Colors.orange;

  /// Rating star color
  static const Color ratingStar = Color(0xFFFFC107);

  // ===========================================================================
  // BACKGROUND COLORS
  // ===========================================================================

  /// Background colors
  static const Color backgroundWhite = Colors.white;
  static const Color backgroundLight = Color(0xFFF4F7FB);
  static const Color backgroundGrey = Color(0xFFF5F8FD);

  // ===========================================================================
  // TEXT COLORS
  // ===========================================================================

  /// Text colors
  static const Color textPrimary = Colors.black87;
  static Color get textSecondary => Colors.grey.shade600;
  static Color get textTertiary => Colors.grey.shade500;
  static Color get textDisabled => Colors.grey.shade400;
  static const Color textOnPrimary = Colors.white;
  static const Color textOnDark = Colors.white;
  static const Color textHint = Color(0xFF757575);

  // ===========================================================================
  // BORDER COLORS
  // ===========================================================================

  /// Border colors
  static Color get borderLight => Colors.grey.shade200;
  static Color get borderMedium => Colors.grey.shade300;
  static Color get borderDark => Colors.grey.shade400;
  static const Color borderFocused = Color(0xFF0089C5);
  static const Color borderError = Color(0xFFFF5252);

  // ===========================================================================
  // SURFACE COLORS
  // ===========================================================================

  /// Surface colors
  static Color get surfaceGrey => Colors.grey.shade50;
  static Color get surfaceGrey100 => Colors.grey.shade100;
  static Color get surfaceGrey200 => Colors.grey.shade200;
  static Color get surfaceGrey300 => Colors.grey.shade300;
  static const Color surfaceWhite = Colors.white;
  static const Color surfacePrimary = Color(0xFF0089C5);
  static const Color surfaceSuccess = Color(0xFFE0F2F1);
  static const Color surfaceError = Color(0xFFFFEBEE);
  static const Color surfaceWarning = Color(0xFFFFF8E1);
  static const Color surfaceInfo = Color(0xFFE3F2FD);
  
  // ===========================================================================
  // ICON COLORS
  // ===========================================================================
  
  static const Color iconPrimary = Color(0xFF212121);
  static const Color iconSecondary = Color(0xFF757575);
  static const Color iconDisabled = Color(0xFFBDBDBD);
  static const Color iconOnPrimary = Colors.white;
  static const Color iconOnDark = Colors.white;
  
  // ===========================================================================
  // BUTTON COLORS
  // ===========================================================================
  
  static const Color buttonPrimary = Color(0xFF0089C5);
  static const Color buttonPrimaryDisabled = Color(0xFFB3E5FC);
  static const Color buttonSecondary = Color(0xFFE0F5FF);
  static const Color buttonSecondaryDisabled = Color(0xFFF5F5F5);
  static const Color buttonTextPrimary = Colors.white;
  static const Color buttonTextSecondary = Color(0xFF0089C5);
  static const Color buttonTextDisabled = Color(0xFFBDBDBD);
  
  // ===========================================================================
  // SHADOW COLORS
  // ===========================================================================
  
  static const Color shadowColor = Color(0x29000000);
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowMedium = Color(0x1F000000);
  
  // ===========================================================================
  // OVERLAY COLORS
  // ===========================================================================
  
  static const Color overlayDark = Color(0x80000000);
  static const Color overlayLight = Color(0x33FFFFFF);
  
  // ===========================================================================
  // DIVIDER COLORS
  // ===========================================================================
  
  static const Color divider = Color(0x1F000000);
  static const Color dividerLight = Color(0x0F000000);
  
  // ===========================================================================
  // SNACKBAR COLORS
  // ===========================================================================
  
  static const Color snackbarBackground = Color(0xFF323232);
  static const Color snackbarSuccess = Color(0xFF4CAF50);
  static const Color snackbarError = Color(0xFFF44336);
  static const Color snackbarWarning = Color(0xFFFFA000);
  static const Color snackbarInfo = Color(0xFF2196F3);
  
  // ===========================================================================
  // CHIP COLORS
  // ===========================================================================
  
  static const Color chipBackground = Color(0xFFE0E0E0);
  static const Color chipSelectedBackground = Color(0xFFB3E5FC);
  static const Color chipText = Color(0xFF212121);
  static const Color chipSelectedText = Color(0xFF0089C5);
  
  // ===========================================================================
  // CARD COLORS
  // ===========================================================================
  
  static const Color cardBackground = Colors.white;
  static const Color cardSelectedBorder = Color(0xFF0089C5);
  
  // ===========================================================================
  // DIALOG COLORS
  // ===========================================================================
  
  static const Color dialogBackground = Colors.white;
  static const Color dialogScrim = Color(0x80000000);
  
  // ===========================================================================
  // BOTTOM NAVIGATION COLORS
  // ===========================================================================
  
  static const Color bottomNavBackground = Colors.white;
  static const Color bottomNavSelectedItem = Color(0xFF0089C5);
  static const Color bottomNavUnselectedItem = Color(0xFF757575);
  
  // ===========================================================================
  // TAB BAR COLORS
  // ===========================================================================
  
  static const Color tabBarBackground = Colors.white;
  static const Color tabBarSelected = Color(0xFF0089C5);
  static const Color tabBarUnselected = Color(0xFF757575);
  static const Color tabBarIndicator = Color(0xFF0089C5);
  
  // ===========================================================================
  // TEXT FIELD COLORS
  // ===========================================================================
  
  static const Color textFieldBackground = Colors.white;
  static const Color textFieldBorder = Color(0xFFE0E0E0);
  static const Color textFieldFocusedBorder = Color(0xFF0089C5);
  static const Color textFieldErrorBorder = Color(0xFFFF5252);
  // ============================================================================

  /// Button heights
  static const double buttonHeight36 = 36.0;
  static const double buttonHeight40 = 40.0;

  /// Image heights
  static const double imageHeight140 = 140.0;
  static const double imageHeight300 = 300.0;
  static const double imageSize72 = 72.0;

  /// Empty state icon size
  static const double emptyStateIconSize = 120.0;
  static const double emptyStateIconInnerSize = 64.0;

  /// App bar height
  static const double appBarHeight = 56.0;

  /// Bottom bar padding
  static const EdgeInsets bottomBarPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  // ============================================================================
  // OPACITY VALUES
  // ============================================================================

  static const double opacity03 = 0.03;
  static const double opacity04 = 0.04;
  static const double opacity05 = 0.05;
  static const double opacity08 = 0.08;
  static const double opacity10 = 0.1;
  static const double opacity15 = 0.15;
  static const double opacity18 = 0.18;

  // ============================================================================
  // LINE HEIGHTS
  // ============================================================================

  static const double lineHeight1_2 = 1.2;
  static const double lineHeight1_3 = 1.3;
  static const double lineHeight1_4 = 1.4;
  static const double lineHeight1_5 = 1.5;

  // ============================================================================
  // BORDER WIDTHS
  // ============================================================================

  static const double borderWidth1 = 1.0;
  static const double borderWidth2 = 2.0;

  // ============================================================================
  // ELEVATION
  // ============================================================================

  static const double elevation0 = 0.0;
  static const double elevation1 = 1.0;
}
