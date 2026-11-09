import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size,
    this.backgroundColor,
    this.padding,
  });

  final Widget icon;
  final VoidCallback? onTap;
  final double? size;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final s = size ?? 44.w;

    return Material(
      color: backgroundColor ?? colorScheme.surface,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: s,
          height: s,
          child: Padding(
            padding: padding ?? EdgeInsetsDirectional.all(10.w),
            child: Center(widthFactor: 1, child: icon),
          ),
        ),
      ),
    );
  }
}
