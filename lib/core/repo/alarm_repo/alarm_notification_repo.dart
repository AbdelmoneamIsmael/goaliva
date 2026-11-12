import 'package:goaliva/core/models/alarm/alarm.dart';

/// Handles dismiss and snooze for a ringing alarm: plugin + local database.
abstract class AlarmNotificationRepo {
  Future<AlarmModel?> getAlarm(int id);

  Future<void> dismiss(int id);

  Future<void> snooze(int id, {Duration duration = const Duration(minutes: 5)});
}
