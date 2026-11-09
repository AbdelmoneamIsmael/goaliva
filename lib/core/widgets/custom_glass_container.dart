import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    this.child,
    this.borderRadius,
    this.borderColor,
    this.boxShadow,
    this.padding,
    this.margin,
    this.borderWidth,
    this.backgroundColor,
  });

  final Widget? child;
  final double? borderRadius;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderWidth;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultFill = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.white.withValues(alpha: 0.72);
    final defaultBorder = isDark
        ? Colors.white.withValues(alpha: 0.12)
        : Colors.black.withValues(alpha: 0.06);

    return Container(
      margin: margin ?? EdgeInsetsDirectional.all(8.w),
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultFill,
        borderRadius: BorderRadius.circular(borderRadius ?? 24.r),
        border: Border.all(
          color: borderColor ?? defaultBorder,
          width: borderWidth ?? 1,
        ),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
      ),
      child: child,
    );
  }
}
