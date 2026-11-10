import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../theme/app_colors.dart';

class AppWeekCalendar extends StatelessWidget {
  const AppWeekCalendar({
    super.key,
    required this.title,
    required this.statusText,
    required this.focusedDay,
    required this.selectedDay,
    required this.completedDays,
    required this.onDaySelected,
    this.onPageChanged,
  });

  final String title;
  final String statusText;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final Set<DateTime> completedDays;
  final void Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final ValueChanged<DateTime>? onPageChanged;

  bool _isCompleted(DateTime day) {
    return completedDays.any((d) => isSameDay(d, day));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final success = isDark ? AppColors.darkSuccess : AppColors.lightSuccess;
    final locale = Localizations.localeOf(context).languageCode;
    final weekProgress = (completedDays.length / 7).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
        ),
        boxShadow: [
          BoxShadow(
            color: success.withValues(alpha: isDark ? 0.12 : 0.08),
            blurRadius: 22,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 34.w,
                height: 34.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: weekProgress,
                      strokeWidth: 3.5,
                      backgroundColor:
                          isDark ? AppColors.darkStroke : AppColors.lightStroke,
                      valueColor: AlwaysStoppedAnimation<Color>(success),
                    ),
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 14.sp,
                      color: success,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Text(
                statusText,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          TableCalendar<void>(
            locale: locale,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2035, 12, 31),
            focusedDay: focusedDay,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            calendarFormat: CalendarFormat.week,
            availableCalendarFormats: const {
              CalendarFormat.week: 'Week',
            },
            headerVisible: false,
            startingDayOfWeek: StartingDayOfWeek.monday,
            daysOfWeekHeight: 20.h,
            rowHeight: 48.h,
            onDaySelected: onDaySelected,
            onPageChanged: onPageChanged,
            eventLoader: (day) => _isCompleted(day) ? const [null] : const [],
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              isTodayHighlighted: true,
              markersMaxCount: 1,
              markerDecoration: BoxDecoration(
                color: success,
                shape: BoxShape.circle,
              ),
              markerSize: 6.w,
              todayDecoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: isDark ? 0.22 : 0.14),
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.primary, width: 2),
              ),
              todayTextStyle: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ) ??
                  TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
              selectedDecoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ) ??
                  TextStyle(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
              defaultTextStyle: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ) ??
                  TextStyle(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
              weekendTextStyle: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ) ??
                  TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ) ??
                  TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
              weekendStyle: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ) ??
                  TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
