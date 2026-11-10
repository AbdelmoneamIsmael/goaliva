import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goaliva/core/models/alarm/alarm_schedule.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_repo.dart';
import 'package:goaliva/core/theme/app_toast.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/models/alarm/alarm.dart';
import 'alarm_state.dart';

export 'alarm_state.dart';

class AlarmCubit extends Cubit<AlarmState> {
  AlarmCubit({required this.alarmRepo})
    : super(AlarmState(alarms: buildSampleAlarms()));
  final AlarmRepo alarmRepo;

  static List<AlarmModel> buildSampleAlarms() {
    return const [
      AlarmModel(
        year: 2026,
        month: 11,
        day: 10,
        id: 1,
        title: 'Morning focus',
        description: 'Start the day with one quiet focus block.',
        hour: 7,
        minute: 0,
        repeats: true,
        enabled: true,
      ),
      AlarmModel(
        year: 2026,
        month: 11,
        day: 10,
        id: 2,
        title: 'Midday reset',
        description: 'Pause, breathe, and check your next task.',
        hour: 12,
        minute: 30,
        repeats: true,
        enabled: true,
      ),
      AlarmModel(
        year: 2026,
        month: 11,
        day: 10,
        id: 3,
        title: 'Evening review',
        description: 'Look back on progress and plan tomorrow.',
        hour: 21,
        minute: 0,
        repeats: false,
        enabled: true,
      ),
    ];
  }

  int nextAlarmId() {
    if (state.alarms.isEmpty) return 1;
    return state.alarms
            .map((alarm) => alarm.id)
            .reduce((a, b) => a > b ? a : b) +
        1;
  }

  Future<void> toggleEnabled(BuildContext context, AlarmModel alarm) async {
    final turningOn = !alarm.enabled;
    final updated = alarm.copyWith(enabled: turningOn);

    try {
      if (turningOn) {
        await alarmRepo.setAlarm(updated);
      } else {
        await alarmRepo.stopAlarm(alarm.id);
      }
    } on Exception catch (e) {
      if (!context.mounted) return;
      AppToast.show(
        context,
        'alarm.toast_error'.tr(),
        type: ToastificationType.error,
        description: e.toString(),
      );
      return;
    }

    final alarms = [
      for (final item in state.alarms)
        if (item.id == alarm.id) updated else item,
    ];
    emit(state.copyWith(alarms: alarms));

    if (!context.mounted) return;
    AppToast.show(
      context,
      turningOn ? 'alarm.toast_on'.tr() : 'alarm.toast_off'.tr(),
      type: turningOn ? ToastificationType.success : ToastificationType.info,
      description: turningOn ? _remainingDescription(updated) : null,
    );
  }

  void deleteAlarm(int id) {
    final alarms = state.alarms.where((alarm) => alarm.id != id).toList();
    emit(state.copyWith(alarms: alarms));
  }

  Future<void> addAlarm(BuildContext context, AlarmModel alarm) async {
    try {
      await alarmRepo.setAlarm(alarm);
    } on Exception catch (e) {
      if (!context.mounted) return;
      AppToast.show(
        context,
        'alarm.toast_error'.tr(),
        type: ToastificationType.error,
        description: e.toString(),
      );
      return;
    }

    emit(state.copyWith(alarms: [...state.alarms, alarm]));

    if (!context.mounted) return;
    AppToast.show(
      context,
      'alarm.toast_added'.tr(),
      type: ToastificationType.success,
      description: _remainingDescription(alarm),
    );
  }

  void updateAlarm(BuildContext context, AlarmModel alarm) {
    final alarms = state.alarms.map((item) {
      if (item.id != alarm.id) return item;
      return alarm;
    }).toList();
    emit(state.copyWith(alarms: alarms));

    AppToast.show(
      context,
      'alarm.toast_updated'.tr(),
      type: ToastificationType.success,
      description: alarm.enabled ? _remainingDescription(alarm) : null,
    );
  }

  String _remainingDescription(AlarmModel alarm) {
    final remaining = AlarmSchedule.remainingLabel(alarm);
    if (remaining == null) return 'alarm.remaining_passed'.tr();
    return 'alarm.remaining'.tr(namedArgs: {'time': remaining});
  }
}
