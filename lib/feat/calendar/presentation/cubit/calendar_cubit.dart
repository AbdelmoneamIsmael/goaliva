import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';

enum CalendarItemType { alarm, event, task, goal }

class CalendarItem extends Equatable {
  const CalendarItem({
    required this.type,
    required this.title,
  });

  final CalendarItemType type;
  final String title;

  @override
  List<Object?> get props => [type, title];
}

class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object?> get props => [];
}

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({DateTime? day}) : super(const CalendarState()) {
    controller = EventController<CalendarItem>();
    controller.addAll(buildSampleEvents(day ?? DateTime.now()));
  }

  late final EventController<CalendarItem> controller;

  static List<CalendarEventData<CalendarItem>> buildSampleEvents(DateTime day) {
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

  Color accentFor(CalendarItemType type, bool isDark, ColorScheme scheme) {
    return switch (type) {
      CalendarItemType.alarm =>
        isDark ? AppColors.darkSecondary : AppColors.lightSecondary,
      CalendarItemType.event => scheme.primary,
      CalendarItemType.task =>
        isDark ? AppColors.darkSuccess : AppColors.lightSuccess,
      CalendarItemType.goal => scheme.primary,
    };
  }

  IconData iconFor(CalendarItemType type) {
    return switch (type) {
      CalendarItemType.alarm => Icons.alarm_rounded,
      CalendarItemType.event => Icons.event_rounded,
      CalendarItemType.task => Icons.checklist_rounded,
      CalendarItemType.goal => Icons.flag_rounded,
    };
  }

  String typeLabelKey(CalendarItemType type) {
    return switch (type) {
      CalendarItemType.alarm => 'calendar.type_alarm',
      CalendarItemType.event => 'calendar.type_event',
      CalendarItemType.task => 'calendar.type_task',
      CalendarItemType.goal => 'calendar.type_goal',
    };
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
