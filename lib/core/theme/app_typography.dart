import 'package:flutter/material.dart';

/// Typography system for the app
class AppTypography {
  AppTypography._();

  // Font sizes
  static const double fontSize11 = 11.0;
  static const double fontSize12 = 12.0;
  static const double fontSize13 = 13.0;
  static const double fontSize14 = 14.0;
  static const double fontSize15 = 15.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize22 = 22.0;
  static const double fontSize24 = 24.0;
  static const double fontSize28 = 28.0;

  // Font weights
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;

  // Text styles
  static const TextStyle textStyle11Regular = TextStyle(
    fontSize: fontSize11,
    fontWeight: fontWeightRegular,
  );

  static const TextStyle textStyle11SemiBold = TextStyle(
    fontSize: fontSize11,
    fontWeight: fontWeightSemiBold,
  );

  static const TextStyle textStyle12Regular = TextStyle(
    fontSize: fontSize12,
    fontWeight: fontWeightRegular,
  );

  static const TextStyle textStyle12SemiBold = TextStyle(
    fontSize: fontSize12,
    fontWeight: fontWeightSemiBold,
  );

  static const TextStyle textStyle13Regular = TextStyle(
    fontSize: fontSize13,
    fontWeight: fontWeightRegular,
  );

  static const TextStyle textStyle13SemiBold = TextStyle(
    fontSize: fontSize13,
    fontWeight: fontWeightSemiBold,
  );

  static const TextStyle textStyle14Regular = TextStyle(
    fontSize: fontSize14,
    fontWeight: fontWeightRegular,
  );

  static const TextStyle textStyle14SemiBold = TextStyle(
    fontSize: fontSize14,
    fontWeight: fontWeightSemiBold,
  );

  static const TextStyle textStyle15SemiBold = TextStyle(
    fontSize: fontSize15,
    fontWeight: fontWeightSemiBold,
  );

  static const TextStyle textStyle16Regular = TextStyle(
    fontSize: fontSize16,
    fontWeight: fontWeightRegular,
  );

  static const TextStyle textStyle16SemiBold = TextStyle(
    fontSize: fontSize16,
    fontWeight: fontWeightSemiBold,
  );

  static const TextStyle textStyle18SemiBold = TextStyle(
    fontSize: fontSize18,
    fontWeight: fontWeightSemiBold,
  );

  static const TextStyle textStyle20Bold = TextStyle(
    fontSize: fontSize20,
    fontWeight: fontWeightBold,
  );

  static const TextStyle textStyle22Bold = TextStyle(
    fontSize: fontSize22,
    fontWeight: fontWeightBold,
  );

  static const TextStyle textStyle24Bold = TextStyle(
    fontSize: fontSize24,
    fontWeight: fontWeightBold,
  );

  static const TextStyle textStyle28Bold = TextStyle(
    fontSize: fontSize28,
    fontWeight: fontWeightBold,
  );

  // Text themes
  static TextTheme get textTheme {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: fontSize28,
        fontWeight: fontWeightBold,
      ),
      displayMedium: TextStyle(
        fontSize: fontSize24,
        fontWeight: fontWeightBold,
      ),
      displaySmall: TextStyle(
        fontSize: fontSize22,
        fontWeight: fontWeightBold,
      ),
      headlineMedium: TextStyle(
        fontSize: fontSize20,
        fontWeight: fontWeightBold,
      ),
      headlineSmall: TextStyle(
        fontSize: fontSize18,
        fontWeight: fontWeightSemiBold,
      ),
      titleLarge: TextStyle(
        fontSize: fontSize16,
        fontWeight: fontWeightSemiBold,
      ),
      titleMedium: TextStyle(
        fontSize: fontSize14,
        fontWeight: fontWeightSemiBold,
      ),
      titleSmall: TextStyle(
        fontSize: fontSize13,
        fontWeight: fontWeightSemiBold,
      ),
      bodyLarge: TextStyle(
        fontSize: fontSize16,
        fontWeight: fontWeightRegular,
      ),
      bodyMedium: TextStyle(
        fontSize: fontSize14,
        fontWeight: fontWeightRegular,
      ),
      bodySmall: TextStyle(
        fontSize: fontSize12,
        fontWeight: fontWeightRegular,
      ),
      labelLarge: TextStyle(
        fontSize: fontSize14,
        fontWeight: fontWeightMedium,
      ),
      labelMedium: TextStyle(
        fontSize: fontSize12,
        fontWeight: fontWeightMedium,
      ),
      labelSmall: TextStyle(
        fontSize: fontSize11,
        fontWeight: fontWeightMedium,
      ),
    );
  }
}
