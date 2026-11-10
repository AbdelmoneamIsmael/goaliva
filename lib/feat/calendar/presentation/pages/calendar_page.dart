import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/calendar_cubit.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final cubit = context.read<CalendarCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text('calendar.title'.tr()),
        automaticallyImplyLeading: false,
      ),
      body: DayView<CalendarItem>(
        controller: cubit.controller,
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
          final accent = cubit.accentFor(type, isDark, colorScheme);
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
                  Icon(cubit.iconFor(type), size: 14.sp, color: accent),
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
                            cubit.typeLabelKey(type).tr(),
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
