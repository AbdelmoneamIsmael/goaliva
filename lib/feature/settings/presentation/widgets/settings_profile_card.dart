import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class SettingsProfileCard extends StatelessWidget {
  const SettingsProfileCard({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Ink(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [
                colorScheme.primary.withValues(alpha: isDark ? 0.28 : 0.14),
                isDark ? AppColors.darkSurface : AppColors.lightSurface,
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: colorScheme.primary
                    .withValues(alpha: isDark ? 0.28 : 0.16),
                child: Text(
                  'settings.profile_initial'.tr(),
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'settings.profile_name'.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'settings.profile_subtitle'.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.edit_outlined,
                color: colorScheme.onSurfaceVariant,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
