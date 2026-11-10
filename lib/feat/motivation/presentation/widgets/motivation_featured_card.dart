import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class MotivationFeaturedCard extends StatelessWidget {
  const MotivationFeaturedCard({
    super.key,
    required this.quote,
    required this.topicLabel,
  });

  final String quote;
  final String topicLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'motivation.featured_label'.tr(),
          style: theme.textTheme.titleSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: colorScheme.primary,
                size: 28.sp,
              ),
              SizedBox(height: 12.h),
              Text(
                quote,
                style: theme.textTheme.titleMedium?.copyWith(
                  height: 1.45,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 14.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: colorScheme.primary
                      .withValues(alpha: isDark ? 0.18 : 0.1),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  topicLabel,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
