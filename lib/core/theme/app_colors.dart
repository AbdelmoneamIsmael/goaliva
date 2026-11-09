import 'package:flutter/material.dart';

/// Brand palette from Goaliva design docs (light and dark).
abstract final class AppColors {
  // Dark mode
  static const Color darkBackground = Color(0xFF0C0E1B);
  static const Color darkSurface = Color(0xFF171A2B);
  static const Color darkSurfaceElevated = Color(0xFF21253B);
  static const Color darkPrimary = Color(0xFF8B5CF6);
  static const Color darkSecondary = Color(0xFF38BDF8);
  static const Color darkSuccess = Color(0xFF34D399);
  static const Color darkTextPrimary = Color(0xFFF2F5FA);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkStroke = Color(0x1F9CA3AF);

  // Light mode
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceRecessed = Color(0xFFF1F5F9);
  static const Color lightPrimary = Color(0xFF7C3AED);
  static const Color lightSecondary = Color(0xFF0284C7);
  static const Color lightSuccess = Color(0xFF059669);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightStroke = Color(0xFFE2E8F0);
}
