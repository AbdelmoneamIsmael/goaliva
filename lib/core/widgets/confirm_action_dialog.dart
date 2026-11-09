import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_button.dart';

/// Confirm/cancel dialog. Pass translation keys for all text fields.
class ConfirmActionDialog extends StatelessWidget {
  const ConfirmActionDialog({
    super.key,
    required this.titleKey,
    required this.messageKey,
    required this.cancelLabelKey,
    required this.confirmLabelKey,
    this.messageArgs,
    this.confirmIcon = Icons.delete_outline,
    this.confirmColor,
  });

  final String titleKey;
  final String messageKey;
  final String cancelLabelKey;
  final String confirmLabelKey;
  final Map<String, String>? messageArgs;
  final IconData? confirmIcon;
  final Color? confirmColor;

  static Future<bool> show(
    BuildContext context, {
    required String titleKey,
    required String messageKey,
    required String cancelLabelKey,
    required String confirmLabelKey,
    Map<String, String>? messageArgs,
    IconData? confirmIcon = Icons.delete_outline,
    Color? confirmColor,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (_) => ConfirmActionDialog(
        titleKey: titleKey,
        messageKey: messageKey,
        cancelLabelKey: cancelLabelKey,
        confirmLabelKey: confirmLabelKey,
        messageArgs: messageArgs,
        confirmIcon: confirmIcon,
        confirmColor: confirmColor,
      ),
    );
    return confirmed == true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = confirmColor ?? colorScheme.error;

    return Dialog(
      backgroundColor: colorScheme.surface,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          end: 16.w,
          top: 20.h,
          bottom: 20.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              titleKey.tr(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              messageKey.tr(namedArgs: messageArgs),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: cancelLabelKey.tr(),
                    variant: AppButtonVariant.secondary,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: FilledButton.styleFrom(
                      minimumSize: Size(0, 52.h),
                      backgroundColor: color,
                      foregroundColor: colorScheme.onError,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      elevation: 0,
                    ),
                    icon: confirmIcon == null
                        ? const SizedBox.shrink()
                        : Icon(confirmIcon, size: 18.sp),
                    label: Text(
                      confirmLabelKey.tr(),
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
