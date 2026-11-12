import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class MotivationAddButton extends StatelessWidget {
  const MotivationAddButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSurfaceElevated
                : AppColors.lightSurfaceRecessed,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: isDark ? 0.45 : 0.3),
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: colorScheme.primary
                      .withValues(alpha: isDark ? 0.22 : 0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.add_rounded,
                  color: colorScheme.primary,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'motivation.add_button'.tr(),
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
