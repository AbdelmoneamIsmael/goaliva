import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goaliva/core/models/alarm/alarm_schedule.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_local_repo.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_repo.dart';
import 'package:goaliva/core/theme/app_toast.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/models/alarm/alarm.dart';
import 'alarm_state.dart';

export 'alarm_state.dart';

class AlarmCubit extends Cubit<AlarmState> {
  AlarmCubit({
    required this.alarmRepo,
    required this.alarmLocalRepo,
  }) : super(const AlarmState(alarms: [])) {
    loadAlarms();
  }

  final AlarmRepo alarmRepo;
  final AlarmLocalRepo alarmLocalRepo;

  Future<void> loadAlarms() async {
    try {
      final alarms = await alarmLocalRepo.getAll();
      emit(state.copyWith(alarms: alarms));
    } on Exception catch (_) {
      emit(state.copyWith(alarms: const []));
    }
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
      await alarmLocalRepo.save(updated);
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

  Future<void> deleteAlarm(BuildContext context, int id) async {
    try {
      await alarmRepo.stopAlarm(id);
      await alarmLocalRepo.delete(id);
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

    final alarms = state.alarms.where((alarm) => alarm.id != id).toList();
    emit(state.copyWith(alarms: alarms));
  }

  Future<void> addAlarm(BuildContext context, AlarmModel alarm) async {
    try {
      await alarmRepo.setAlarm(alarm);
      await alarmLocalRepo.save(alarm);
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

  Future<void> updateAlarm(BuildContext context, AlarmModel alarm) async {
    try {
      if (alarm.enabled) {
        await alarmRepo.setAlarm(alarm);
      }
      await alarmLocalRepo.save(alarm);
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

    final alarms = state.alarms.map((item) {
      if (item.id != alarm.id) return item;
      return alarm;
    }).toList();
    emit(state.copyWith(alarms: alarms));

    if (!context.mounted) return;
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
