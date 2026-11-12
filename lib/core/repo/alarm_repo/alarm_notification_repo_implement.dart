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

  @override
  Future<AlarmModel?> getAlarm(int id) {
    return alarmLocalRepo.getById(id);
  }

  @override
  Future<void> dismiss(int id) async {
    await alarmRepo.stopAlarm(id);

    final alarm = await alarmLocalRepo.getById(id);
    if (alarm == null) return;

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

  @override
  Future<void> snooze(
    int id, {
    Duration duration = const Duration(minutes: 5),
  }) async {
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
  }
}
