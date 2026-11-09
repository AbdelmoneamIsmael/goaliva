import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.iconSize,
    this.iconColor,
    this.accentColor,
    this.titleStyle,
    this.descriptionStyle,
    this.padding,
    this.iconTitleSpacing,
    this.titleDescriptionSpacing,
    this.action,
  });

  /// Prefer [IconData] or a [Widget]. String SVG paths are not supported.
  final dynamic icon;
  final String title;
  final String? description;
  final double? iconSize;
  final Color? iconColor;
  final Color? accentColor;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final EdgeInsetsGeometry? padding;
  final double? iconTitleSpacing;
  final double? titleDescriptionSpacing;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(24.w),
      child: Center(
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 420),
          curve: Curves.easeOutCubic,
          tween: Tween(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value.clamp(0.0, 1.0),
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 16),
                child: child,
              ),
            );
          },
          child: _buildCard(context),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.08),
            blurRadius: 32,
            offset: const Offset(0, 12),
            spreadRadius: -8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(context),
          SizedBox(height: iconTitleSpacing ?? 24.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle ??
                theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          if (description != null && description!.isNotEmpty) ...[
            SizedBox(height: titleDescriptionSpacing ?? 12.h),
            Text(
              description!,
              textAlign: TextAlign.center,
              style: descriptionStyle ??
                  theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.55,
                  ),
            ),
          ],
          if (action != null) ...[
            SizedBox(height: 24.h),
            action!,
          ],
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconSizeValue = iconSize ?? 72.0;
    final badgeSize = (iconSizeValue * 1.65).clamp(96.0, 132.0);
    final ringSize = badgeSize + 18;
    final accent = accentColor ?? colorScheme.primary;
    final color = iconColor ?? accent;

    late final Widget iconWidget;
    if (icon is Widget) {
      iconWidget = SizedBox(
        width: iconSizeValue,
        height: iconSizeValue,
        child: icon as Widget,
      );
    } else if (icon is IconData) {
      iconWidget = Icon(icon as IconData, size: iconSizeValue, color: color);
    } else {
      iconWidget = SizedBox(width: iconSizeValue, height: iconSizeValue);
    }

    return SizedBox(
      width: ringSize,
      height: ringSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: ringSize,
            height: ringSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withValues(alpha: 0.06),
            ),
          ),
          Container(
            width: badgeSize,
            height: badgeSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  accent.withValues(alpha: 0.28),
                  accent.withValues(alpha: 0.10),
                ],
              ),
              border: Border.all(color: accent.withValues(alpha: 0.18)),
            ),
            child: Center(child: iconWidget),
          ),
        ],
      ),
    );
  }
}
