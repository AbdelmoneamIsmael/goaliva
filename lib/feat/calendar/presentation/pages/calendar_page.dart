import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

enum CalendarItemType { alarm, event, task, goal }

class CalendarItem {
  const CalendarItem({
    required this.type,
    required this.title,
  });

  final CalendarItemType type;
  final String title;
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final EventController<CalendarItem> _controller;

  @override
  void initState() {
    super.initState();
    _controller = EventController<CalendarItem>();
    _controller.addAll(_mockEvents(DateTime.now()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<CalendarEventData<CalendarItem>> _mockEvents(DateTime day) {
    final date = DateTime(day.year, day.month, day.day);

    DateTime at(int hour, [int minute = 0]) =>
        DateTime(date.year, date.month, date.day, hour, minute);

    return [
      CalendarEventData<CalendarItem>(
        date: date,
        startTime: at(7, 30),
        endTime: at(8),
        title: 'calendar.sample_alarm'.tr(),
        color: AppColors.lightSecondary,
        event: CalendarItem(
          type: CalendarItemType.alarm,
          title: 'calendar.sample_alarm'.tr(),
        ),
      ),
      CalendarEventData<CalendarItem>(
        date: date,
        startTime: at(10),
        endTime: at(11),
        title: 'calendar.sample_event'.tr(),
        color: AppColors.lightPrimary,
        event: CalendarItem(
          type: CalendarItemType.event,
          title: 'calendar.sample_event'.tr(),
        ),
      ),
      CalendarEventData<CalendarItem>(
        date: date,
        startTime: at(13),
        endTime: at(13, 45),
        title: 'calendar.sample_task'.tr(),
        color: AppColors.lightSuccess,
        event: CalendarItem(
          type: CalendarItemType.task,
          title: 'calendar.sample_task'.tr(),
        ),
      ),
      CalendarEventData<CalendarItem>(
        date: date,
        startTime: at(16),
        endTime: at(17, 30),
        title: 'calendar.sample_goal'.tr(),
        color: AppColors.darkPrimary,
        event: CalendarItem(
          type: CalendarItemType.goal,
          title: 'calendar.sample_goal'.tr(),
        ),
      ),
    ];
  }

  Color _accentFor(CalendarItemType type, bool isDark, ColorScheme scheme) {
    return switch (type) {
      CalendarItemType.alarm =>
        isDark ? AppColors.darkSecondary : AppColors.lightSecondary,
      CalendarItemType.event => scheme.primary,
      CalendarItemType.task =>
        isDark ? AppColors.darkSuccess : AppColors.lightSuccess,
      CalendarItemType.goal => scheme.primary,
    };
  }

  IconData _iconFor(CalendarItemType type) {
    return switch (type) {
      CalendarItemType.alarm => Icons.alarm_rounded,
      CalendarItemType.event => Icons.event_rounded,
      CalendarItemType.task => Icons.checklist_rounded,
      CalendarItemType.goal => Icons.flag_rounded,
    };
  }

  String _typeLabel(CalendarItemType type) {
    return switch (type) {
      CalendarItemType.alarm => 'calendar.type_alarm'.tr(),
      CalendarItemType.event => 'calendar.type_event'.tr(),
      CalendarItemType.task => 'calendar.type_task'.tr(),
      CalendarItemType.goal => 'calendar.type_goal'.tr(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('calendar.title'.tr()),
        automaticallyImplyLeading: false,
      ),
      body: DayView<CalendarItem>(
        controller: _controller,
        backgroundColor: theme.scaffoldBackgroundColor,
        heightPerMinute: 1.1,
        showVerticalLine: true,
        showLiveTimeLineInAllDays: true,
        liveTimeIndicatorSettings: LiveTimeIndicatorSettings(
          color: colorScheme.primary,
          height: 2,
        ),
        hourIndicatorSettings: HourIndicatorSettings(
          color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
          height: 1,
        ),
        timeLineBuilder: (date) {
          return Center(
            child: Text(
              DateFormat.Hm().format(date),
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          );
        },
        eventTileBuilder: (date, events, boundary, start, end) {
          final event = events.first;
          final item = event.event;
          final type = item?.type ?? CalendarItemType.event;
          final accent = _accentFor(type, isDark, colorScheme);
          final showType = boundary.height >= 40;

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: isDark ? 0.22 : 0.14),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: accent.withValues(alpha: 0.55)),
            ),
            child: ClipRect(
              child: Row(
                children: [
                  Icon(_iconFor(type), size: 14.sp, color: accent),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          event.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                          ),
                        ),
                        if (showType)
                          Text(
                            _typeLabel(type),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: accent,
                              fontWeight: FontWeight.w600,
                              height: 1.1,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
