import 'package:flutter/material.dart';

/// Bundled typeface families for Goaliva.
abstract final class AppFonts {
  static const String dmSans = 'DMSans';
  static const String tajawal = 'Tajawal';

  /// English uses DM Sans; Arabic uses Tajawal.
  static String familyFor(Locale locale) {
    return locale.languageCode == 'ar' ? tajawal : dmSans;
  }
}
