import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';
import 'package:flutter/widgets.dart';
import 'package:goaliva/core/models/alarm/alarm_schedule.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_local_repo.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_notification_repo.dart';
import 'package:goaliva/core/util/printer/print_helper.dart';
import 'package:goaliva/feature/alarm/presentation/cubit/alarm_cubit.dart';

/// Keeps SQLite aligned with rings the alarm screen did not handle.
///
/// The notification Stop button, a dropped alarm, and a ring that finished
/// while the process was dead never go through the screen. This service
/// applies the same dismiss rule once the plugin reports the alarm is gone.
class AlarmSyncService {
  AlarmSyncService({
    required this.notificationRepo,
    required this.alarmLocalRepo,
    required this.alarmCubit,
  });

  final AlarmNotificationRepo notificationRepo;
  final AlarmLocalRepo alarmLocalRepo;
  final AlarmCubit alarmCubit;

  /// A ring that just became due can sit between "scheduled" and "ringing"
  /// for a moment. Leave it alone on a full scan so we do not skip a day.
  static const _freshRingGrace = Duration(seconds: 2);

  // Stored so the listeners stay registered for the process lifetime.
  // ignore: unused_field
  StreamSubscription<AlarmEvent>? _eventsSub;
  // ignore: unused_field
  StreamSubscription<AlarmSet>? _ringingSub;
  // ignore: unused_field
  AppLifecycleListener? _lifecycle;
  var _started = false;
  var _ringingIds = <int>{};

  Future<void> start() async {
    if (_started) return;
    _started = true;

    _ringingIds = Alarm.ringing.value.alarms.map((alarm) => alarm.id).toSet();
    _eventsSub = Alarm.events.listen(_onEvent);
    _ringingSub = Alarm.ringing.listen(_onRinging);
    _lifecycle = AppLifecycleListener(
      onResume: () {
        unawaited(reconcile());
      },
    );
    await reconcile();
  }

  /// Finishes enabled alarms whose time has passed and that the plugin is
  /// no longer scheduling or ringing.
  ///
  /// [onlyId] is set when a ring just stopped, so the fresh-ring grace does
  /// not apply to that id.
  Future<void> reconcile({int? onlyId}) async {
    try {
      await _reconcile(onlyId: onlyId);
    } on Exception catch (e) {
      PrintHelper.print('Alarm reconcile failed: $e');
    }
  }

  Future<void> _reconcile({int? onlyId}) async {
    final alarms = await alarmLocalRepo.getAll();
    final now = DateTime.now();
    final scheduled = Alarm.scheduled.value;
    final ringing = Alarm.ringing.value;

    for (final alarm in alarms) {
      if (onlyId != null && alarm.id != onlyId) continue;
      if (!alarm.enabled || notificationRepo.isHandling(alarm.id)) continue;
      if (scheduled.containsId(alarm.id) || ringing.containsId(alarm.id)) {
        continue;
      }

      final scheduledAt = AlarmSchedule.scheduledAt(alarm);
      if (!scheduledAt.isBefore(now)) continue;
      final knownStopped = onlyId != null;
      if (!knownStopped && now.difference(scheduledAt) < _freshRingGrace) {
        continue;
      }

      try {
        await notificationRepo.completeRing(alarm.id);
      } on Exception catch (e) {
        PrintHelper.print('Alarm sync failed for ${alarm.id}: $e');
      }
    }

    await alarmCubit.loadAlarms();
  }

  Future<void> _onEvent(AlarmEvent event) async {
    try {
      switch (event) {
        case AlarmMoved(:final id, :final nextRingAt):
          await _saveMovedOneTime(id, nextRingAt);
        case AlarmDropped(:final id):
          if (!notificationRepo.isHandling(id)) {
            await notificationRepo.completeRing(id, dropped: true);
          }
      }
    } on Exception catch (e) {
      PrintHelper.print('Alarm event sync failed for ${event.id}: $e');
    }
    await alarmCubit.loadAlarms();
  }

  Future<void> _saveMovedOneTime(int id, DateTime nextRingAt) async {
    final alarm = await alarmLocalRepo.getById(id);
    if (alarm == null || !alarm.enabled || alarm.repeats) return;
    await alarmLocalRepo.save(
      alarm.copyWith(
        year: nextRingAt.year,
        month: nextRingAt.month,
        day: nextRingAt.day,
        hour: nextRingAt.hour,
        minute: nextRingAt.minute,
        enabled: true,
      ),
    );
  }

  void _onRinging(AlarmSet set) {
    final current = set.alarms.map((alarm) => alarm.id).toSet();
    final stopped = _ringingIds.difference(current);
    _ringingIds = current;
    for (final id in stopped) {
      if (notificationRepo.isHandling(id)) continue;
      unawaited(reconcile(onlyId: id));
    }
  }
}
