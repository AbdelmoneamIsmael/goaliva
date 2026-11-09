import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_search_text_field.dart';

class AppSearchTextFieldWithFilter extends StatelessWidget {
  const AppSearchTextFieldWithFilter({
    super.key,
    this.onFilterTap,
    this.onChanged,
    this.controller,
    this.isFilterActive = false,
    this.hint,
  });

  final VoidCallback? onFilterTap;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool isFilterActive;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final radius = 999.r;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: AppSearchTextField(
              controller: controller,
              hint: hint ?? 'common.search_hint'.tr(),
              fillColor: colorScheme.surface,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(radius),
                bottomStart: Radius.circular(radius),
              ),
              onChanged: onChanged,
              prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(start: 12.w, end: 5.w),
                child: Icon(
                  Icons.search_rounded,
                  size: 20.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          SizedBox(width: 2.w),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(radius),
                  bottomEnd: Radius.circular(radius),
                ),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
              padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
              child: Center(
                child: Icon(
                  Icons.tune_rounded,
                  size: 22.sp,
                  color: isFilterActive
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
