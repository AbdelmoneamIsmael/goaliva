import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class SettingsSectionCard extends StatelessWidget {
  const SettingsSectionCard({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
        ),
      ),
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0)
              Divider(
                height: 1,
                indent: 56.w,
                color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
              ),
            children[i],
          ],
        ],
      ),
    );
  }
}
