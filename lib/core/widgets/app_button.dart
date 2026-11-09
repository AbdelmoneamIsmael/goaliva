import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

enum AppButtonVariant { primary, secondary, tertiary }

/// Shared pill button used across Goaliva screens.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isExpanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final height = 52.h;
    final radius = BorderRadius.circular(999.r);
    final labelStyle = theme.textTheme.labelLarge?.copyWith(
      fontWeight: FontWeight.w600,
    );

    final Widget child = Text(label, style: labelStyle);

    final Color secondaryFill = isDark
        ? AppColors.darkSurfaceElevated
        : AppColors.lightSurfaceRecessed;

    final Widget button = switch (variant) {
      AppButtonVariant.primary => FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            minimumSize: Size(0, height),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(borderRadius: radius),
            elevation: 0,
          ),
          child: child,
        ),
      AppButtonVariant.secondary => FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            minimumSize: Size(0, height),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            backgroundColor: secondaryFill,
            foregroundColor: colorScheme.onSurface,
            shape: RoundedRectangleBorder(
              borderRadius: radius,
              side: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            elevation: 0,
          ),
          child: child,
        ),
      AppButtonVariant.tertiary => TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            minimumSize: Size(0, height),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            foregroundColor: colorScheme.onSurfaceVariant,
            shape: RoundedRectangleBorder(borderRadius: radius),
          ),
          child: child,
        ),
    };

    if (!isExpanded) return button;

    return SizedBox(width: double.infinity, child: button);
  }
}
