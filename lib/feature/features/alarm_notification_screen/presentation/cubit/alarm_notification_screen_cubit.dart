import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goaliva/core/models/alarm/alarm.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_notification_repo.dart';
import 'package:goaliva/feature/alarm/presentation/cubit/alarm_cubit.dart';

part 'alarm_notification_screen_state.dart';

class AlarmNotificationScreenCubit extends Cubit<AlarmNotificationScreenState> {
  AlarmNotificationScreenCubit({
    required this.alarmId,
    required this.notificationRepo,
    required this.alarmCubit,
  }) : super(const AlarmNotificationScreenLoading()) {
    load();
  }

  final int alarmId;
  final AlarmNotificationRepo notificationRepo;
  final AlarmCubit alarmCubit;

  Future<void> load() async {
    emit(const AlarmNotificationScreenLoading());
    try {
      final alarm = await notificationRepo.getAlarm(alarmId);
      emit(AlarmNotificationScreenReady(alarm: alarm));
    } on Exception catch (e) {
      emit(AlarmNotificationScreenFailure(message: e.toString()));
    }
  }

  Future<void> dismiss() async {
    await _runAction(() => notificationRepo.dismiss(alarmId));
  }

  Future<void> snooze() async {
    await _runAction(() => notificationRepo.snooze(alarmId));
  }

  Future<void> _runAction(Future<void> Function() action) async {
    final current = state;
    final alarm = switch (current) {
      AlarmNotificationScreenReady(:final alarm) => alarm,
      AlarmNotificationScreenBusy(:final alarm) => alarm,
      _ => null,
    };

    emit(AlarmNotificationScreenBusy(alarm: alarm));
    try {
      await action();
      await alarmCubit.loadAlarms();
      emit(const AlarmNotificationScreenCompleted());
    } on Exception catch (e) {
      emit(AlarmNotificationScreenFailure(message: e.toString()));
    }
  }
}
