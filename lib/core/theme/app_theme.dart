import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

abstract final class AppTheme {
  static ThemeData light(Locale locale) {
    final colorScheme = ColorScheme.light(
      primary: AppColors.lightPrimary,
      onPrimary: Colors.white,
      secondary: AppColors.lightSecondary,
      onSecondary: Colors.white,
      tertiary: AppColors.lightSuccess,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,
      onSurfaceVariant: AppColors.lightTextSecondary,
      outline: AppColors.lightStroke,
      error: const Color(0xFFBA1A1A),
      onError: Colors.white,
    );

    return _base(
      locale: locale,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackground: AppColors.lightBackground,
      cardColor: AppColors.lightSurface,
      dividerColor: AppColors.lightStroke,
    );
  }

  static ThemeData dark(Locale locale) {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkTextPrimary,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkBackground,
      tertiary: AppColors.darkSuccess,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
      onSurfaceVariant: AppColors.darkTextSecondary,
      outline: AppColors.darkStroke,
      error: const Color(0xFFFFB4AB),
      onError: const Color(0xFF690005),
    );

    return _base(
      locale: locale,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackground: AppColors.darkBackground,
      cardColor: AppColors.darkSurface,
      dividerColor: AppColors.darkStroke,
    );
  }

  static ThemeData _base({
    required Locale locale,
    required Brightness brightness,
    required ColorScheme colorScheme,
    required Color scaffoldBackground,
    required Color cardColor,
    required Color dividerColor,
  }) {
    final family = AppFonts.familyFor(locale);
    final isArabic = locale.languageCode == 'ar';
    final base = ThemeData(brightness: brightness).textTheme;

    TextStyle? style(
      TextStyle? source, {
      FontWeight? weight,
      double? letterSpacing,
    }) {
      return source?.copyWith(
        fontFamily: family,
        fontWeight: weight,
        letterSpacing: isArabic ? 0 : letterSpacing,
      );
    }

    final textTheme = base
        .copyWith(
          displayLarge: style(base.displayLarge, weight: FontWeight.w700, letterSpacing: -0.5),
          displayMedium: style(base.displayMedium, weight: FontWeight.w700, letterSpacing: -0.5),
          displaySmall: style(base.displaySmall, weight: FontWeight.w700, letterSpacing: -0.5),
          headlineLarge: style(base.headlineLarge, weight: FontWeight.w700, letterSpacing: -0.3),
          headlineMedium: style(base.headlineMedium, weight: FontWeight.w600, letterSpacing: -0.2),
          headlineSmall: style(base.headlineSmall, weight: FontWeight.w600),
          titleLarge: style(base.titleLarge, weight: FontWeight.w600),
          titleMedium: style(base.titleMedium, weight: FontWeight.w600),
          titleSmall: style(base.titleSmall, weight: FontWeight.w600),
          bodyLarge: style(base.bodyLarge, weight: FontWeight.w400),
          bodyMedium: style(base.bodyMedium, weight: FontWeight.w400),
          bodySmall: style(base.bodySmall, weight: FontWeight.w400),
          labelLarge: style(base.labelLarge, weight: FontWeight.w600),
          labelMedium: style(base.labelMedium, weight: FontWeight.w600),
          labelSmall: style(base.labelSmall, weight: FontWeight.w500),
        )
        .apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
          fontFamily: family,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      cardColor: cardColor,
      dividerColor: dividerColor,
      textTheme: textTheme,
      fontFamily: family,
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackground,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
