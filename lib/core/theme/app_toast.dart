import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import 'app_colors.dart';

abstract final class AppToast {
  static const Color _lightWarning = Color(0xFFD97706);
  static const Color _darkWarning = Color(0xFFFBBF24);

  static ToastificationItem show(
    BuildContext context,
    String message, {
    ToastificationType type = ToastificationType.info,
    String? description,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      title: Text(
        message,
        style: theme.textTheme.titleSmall?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      description: description == null
          ? null
          : Text(
              description,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
      autoCloseDuration: const Duration(seconds: 3),
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      primaryColor: _accentFor(type, isDark: isDark, colorScheme: colorScheme),
      borderSide: BorderSide(color: colorScheme.outline),
      borderRadius: BorderRadius.circular(16),
      direction: Directionality.of(context),
      dragToClose: true,
      showProgressBar: false,
      closeOnClick: false,
      pauseOnHover: true,
    );
  }

  static Color _accentFor(
    ToastificationType type, {
    required bool isDark,
    required ColorScheme colorScheme,
  }) {
    return switch (type) {
      ToastificationType.success =>
        isDark ? AppColors.darkSuccess : AppColors.lightSuccess,
      ToastificationType.error => colorScheme.error,
      ToastificationType.warning => isDark ? _darkWarning : _lightWarning,
      ToastificationType.info =>
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
      _ => isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
    };
  }
}
