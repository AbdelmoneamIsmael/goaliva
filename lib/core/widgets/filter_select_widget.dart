import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterSelectWidget extends StatelessWidget {
  const FilterSelectWidget({
    super.key,
    required this.title,
    required this.isActive,
    this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 15.w,
          vertical: 10.h,
        ),
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: isActive ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: isActive
                ? colorScheme.primary
                : colorScheme.outline.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isActive) ...[
              Icon(Icons.check, color: colorScheme.onPrimary, size: 16.sp),
              SizedBox(width: 5.w),
            ],
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isActive
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
