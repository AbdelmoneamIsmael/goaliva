import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/alarm/alarm_schedule.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/models/alarm/alarm.dart';

class AlarmCard extends StatefulWidget {
  const AlarmCard({
    super.key,
    required this.alarm,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  final AlarmModel alarm;
  final ValueChanged<bool> onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _startTickerIfNeeded();
  }

  @override
  void didUpdateWidget(covariant AlarmCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.alarm.enabled != widget.alarm.enabled ||
        oldWidget.alarm.year != widget.alarm.year ||
        oldWidget.alarm.month != widget.alarm.month ||
        oldWidget.alarm.day != widget.alarm.day ||
        oldWidget.alarm.hour != widget.alarm.hour ||
        oldWidget.alarm.minute != widget.alarm.minute ||
        oldWidget.alarm.repeats != widget.alarm.repeats) {
      _startTickerIfNeeded();
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _startTickerIfNeeded() {
    _ticker?.cancel();
    if (!widget.alarm.enabled) return;
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  String _formatTime(BuildContext context) {
    final time = TimeOfDay(hour: widget.alarm.hour, minute: widget.alarm.minute);
    return time.format(context);
  }

  String _remainingChipLabel() {
    final remaining = AlarmSchedule.remainingLabel(widget.alarm);
    if (remaining == null) return 'alarm.remaining_passed'.tr();
    return 'alarm.remaining'.tr(namedArgs: {'time': remaining});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final stroke = isDark ? AppColors.darkStroke : AppColors.lightStroke;
    final secondary = isDark
        ? AppColors.darkSecondary
        : AppColors.lightSecondary;
    final mutedOpacity = widget.alarm.enabled ? 1.0 : 0.55;

    return Opacity(
      opacity: mutedOpacity,
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(16.w, 14.h, 12.w, 14.h),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: stroke),
          boxShadow: [
            BoxShadow(
              color: secondary.withValues(alpha: isDark ? 0.14 : 0.08),
              blurRadius: 16,
              offset: Offset(0, 8.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    color: secondary.withValues(alpha: isDark ? 0.22 : 0.12),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Icons.alarm_rounded,
                    color: secondary,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.alarm.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.alarm.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: widget.alarm.enabled,
                  onChanged: widget.onToggle,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      _MetaChip(
                        icon: Icons.schedule_rounded,
                        label: _formatTime(context),
                        accent: colorScheme.primary,
                      ),
                      _MetaChip(
                        icon: widget.alarm.repeats
                            ? Icons.repeat_rounded
                            : Icons.looks_one_rounded,
                        label: widget.alarm.repeats
                            ? 'alarm.repeats'.tr()
                            : 'alarm.once'.tr(),
                        accent: secondary,
                      ),
                      if (widget.alarm.enabled)
                        _MetaChip(
                          icon: Icons.hourglass_top_rounded,
                          label: _remainingChipLabel(),
                          accent: colorScheme.tertiary,
                        ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'alarm.edit'.tr(),
                  onPressed: widget.onEdit,
                  icon: Icon(
                    Icons.edit_rounded,
                    size: 20.sp,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                IconButton(
                  tooltip: 'alarm.delete'.tr(),
                  onPressed: widget.onDelete,
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    size: 20.sp,
                    color: colorScheme.error,
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

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: accent),
          SizedBox(width: 5.w),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
