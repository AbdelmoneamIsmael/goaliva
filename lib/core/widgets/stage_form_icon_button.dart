import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StageFormIconButton extends StatelessWidget {
  const StageFormIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.semanticLabel,
  });

  final Widget icon;
  final VoidCallback onTap;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(12.r);

    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: colorScheme.surface,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Ink(
            width: 42.w,
            height: 42.h,
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.4),
              ),
            ),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}
