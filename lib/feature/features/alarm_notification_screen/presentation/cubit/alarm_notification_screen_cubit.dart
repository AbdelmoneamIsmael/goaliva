import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goaliva/core/models/alarm/alarm.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_notification_repo.dart';
import 'package:goaliva/core/services/alarm_sync_service.dart';
import 'package:goaliva/feature/alarm/presentation/cubit/alarm_cubit.dart';

part 'alarm_notification_screen_state.dart';

class AlarmNotificationScreenCubit extends Cubit<AlarmNotificationScreenState> {
  AlarmNotificationScreenCubit({
    required this.alarmId,
    required this.notificationRepo,
    required this.alarmCubit,
    required this.syncService,
  }) : super(const AlarmNotificationScreenLoading()) {
    _sawRinging = Alarm.ringing.value.containsId(alarmId);
    _ringingSub = Alarm.ringing.listen(_onRinging);
    load();
  }

  final int alarmId;
  final AlarmNotificationRepo notificationRepo;
  final AlarmCubit alarmCubit;
  final AlarmSyncService syncService;

  late final StreamSubscription<AlarmSet> _ringingSub;
  var _sawRinging = false;
  var _closingFromOutside = false;

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

  void _onRinging(AlarmSet set) {
    final ringing = set.containsId(alarmId);
    if (_sawRinging && !ringing && !notificationRepo.isHandling(alarmId)) {
      unawaited(_closeFromOutside());
    }
    if (ringing) _sawRinging = true;
  }

  /// The notification Stop button (or another native stop) ended the ring.
  Future<void> _closeFromOutside() async {
    if (_closingFromOutside || isClosed) return;
    if (state is AlarmNotificationScreenCompleted) return;
    _closingFromOutside = true;
    try {
      await syncService.reconcile(onlyId: alarmId);
      if (!isClosed) emit(const AlarmNotificationScreenCompleted());
    } on Exception catch (e) {
      if (!isClosed) {
        emit(AlarmNotificationScreenFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    _ringingSub.cancel();
    return super.close();
  }
}
