import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    super.key,
    required this.title,
    this.titleStyle,
    this.actionText,
    this.onActionTap,
  });

  final String title;
  final TextStyle? titleStyle;
  final String? actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: titleStyle ??
                    theme.textTheme.titleLarge?.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      height: 32 / 24,
                    ),
              ),
              SizedBox(height: 5.h),
              Container(
                width: 45.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.35),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ],
          ),
        ),
        if (actionText != null) ...[
          InkWell(
            onTap: onActionTap,
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 6.w,
                vertical: 4.h,
              ),
              child: Text(
                actionText!.tr(),
                style: theme.textTheme.labelLarge?.copyWith(
                  fontSize: 14.sp,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Icon(
            Icons.arrow_forward_ios,
            size: 12.sp,
            color: colorScheme.onSurfaceVariant,
          ),
        ],
      ],
    );
  }
}
