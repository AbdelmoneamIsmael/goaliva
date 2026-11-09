import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'rounded_icon_button.dart';

class StageFormHeader extends StatelessWidget {
  const StageFormHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 16.w,
            top: 11.h,
            bottom: 11.h,
          ),
          child: Row(
            children: [
              RoundedIconButton(
                size: 28.w,
                backgroundColor: colorScheme.primary,
                padding: EdgeInsets.zero,
                onTap: () => context.pop(),
                icon: Icon(
                  size: 16.w,
                  Icons.arrow_back,
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ),
              SizedBox(width: 44.w),
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: colorScheme.outline.withValues(alpha: 0.3),
        ),
      ],
    );
  }
}
