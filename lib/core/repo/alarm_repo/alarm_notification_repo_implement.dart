import 'dart:async';

import 'package:goaliva/core/models/alarm/alarm.dart';
import 'package:goaliva/core/models/alarm/alarm_schedule.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_local_repo.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_notification_repo.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_repo.dart';

class AlarmNotificationRepoImplement implements AlarmNotificationRepo {
  AlarmNotificationRepoImplement({
    required this.alarmRepo,
    required this.alarmLocalRepo,
  });

  final AlarmRepo alarmRepo;
  final AlarmLocalRepo alarmLocalRepo;

  final Set<int> _handling = <int>{};
  Future<void> _writes = Future<void>.value();

  @override
  bool isHandling(int id) => _handling.contains(id);

  @override
  Future<AlarmModel?> getAlarm(int id) {
    return alarmLocalRepo.getById(id);
  }

  @override
  Future<void> dismiss(int id) {
    return _guard(id, () async {
      await alarmRepo.stopAlarm(id);
      await _completeRingBody(id);
    });
  }

  @override
  Future<void> snooze(
    int id, {
    Duration duration = const Duration(minutes: 5),
  }) {
    return _guard(id, () async {
      await alarmRepo.stopAlarm(id);

      final when = DateTime.now().add(duration);
      final alarm = await alarmLocalRepo.getById(id);

      if (alarm == null) {
        final fallback = AlarmModel(
          id: id,
          title: 'Alarm',
          description: 'Time to wake up!',
          hour: when.hour,
          minute: when.minute,
          repeats: false,
          enabled: true,
          year: when.year,
          month: when.month,
          day: when.day,
        );
        await alarmRepo.snoozeAlarm(fallback, when);
        return;
      }

      await alarmRepo.snoozeAlarm(alarm, when);

      // One-time alarms move to the snooze time in the database.
      // Repeating alarms keep their stored schedule for the next regular ring.
      if (!alarm.repeats) {
        await alarmLocalRepo.save(
          alarm.copyWith(
            year: when.year,
            month: when.month,
            day: when.day,
            hour: when.hour,
            minute: when.minute,
            enabled: true,
          ),
        );
      }
    });
  }

  @override
  Future<void> completeRing(int id, {bool dropped = false}) {
    return _serialized(() => _completeRingBody(id, dropped: dropped));
  }

  Future<void> _completeRingBody(int id, {bool dropped = false}) async {
    final alarm = await alarmLocalRepo.getById(id);
    if (alarm == null || !alarm.enabled) return;

    final due = AlarmSchedule.scheduledAt(alarm).isBefore(DateTime.now());
    if (!due && !dropped) return;

    if (alarm.repeats) {
      final next = AlarmSchedule.nextRingAt(
        alarm,
        now: DateTime.now().add(const Duration(seconds: 1)),
      );
      if (next == null) {
        await alarmLocalRepo.save(alarm.copyWith(enabled: false));
        return;
      }

      final updated = alarm.copyWith(
        year: next.year,
        month: next.month,
        day: next.day,
        hour: next.hour,
        minute: next.minute,
        enabled: true,
      );
      await alarmRepo.setAlarm(updated);
      await alarmLocalRepo.save(updated);
      return;
    }

    await alarmLocalRepo.save(alarm.copyWith(enabled: false));
  }

  /// Keeps [isHandling] true for the whole stop-then-reschedule window.
  Future<void> _guard(int id, Future<void> Function() action) {
    _handling.add(id);
    return _serialized(action).whenComplete(() => _handling.remove(id));
  }

  /// One database decision at a time, so a second finish cannot skip a day.
  Future<void> _serialized(Future<void> Function() action) {
    final done = Completer<void>();
    _writes.whenComplete(() async {
      try {
        await action();
        if (!done.isCompleted) done.complete();
      } on Object catch (e, stack) {
        if (!done.isCompleted) done.completeError(e, stack);
      }
    });
    _writes = done.future;
    return done.future;
  }
}
