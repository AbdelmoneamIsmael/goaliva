import 'package:goaliva/core/models/alarm/alarm.dart';

/// Handles dismiss and snooze for a ringing alarm: plugin + local database.
abstract class AlarmNotificationRepo {
  Future<AlarmModel?> getAlarm(int id);

  Future<void> dismiss(int id);

  Future<void> snooze(int id, {Duration duration = const Duration(minutes: 5)});

  /// True while [dismiss] or [snooze] is running for [id].
  ///
  /// The ringing stream drops the id as soon as the plugin stops it, before
  /// snooze has scheduled the next ring. Callers that react to that drop must
  /// ignore ids this returns true for.
  bool isHandling(int id);

  /// Writes the database result of a finished ring.
  ///
  /// Repeating alarms move to the next time and are scheduled again.
  /// One-time alarms are saved with `enabled: false`.
  ///
  /// Does nothing when the stored time is still ahead, unless [dropped] is
  /// true. A dropped one-time alarm is disabled even if its time is ahead,
  /// because the plugin has already given up on it. A dropped repeating alarm
  /// is scheduled again at its next future time.
  Future<void> completeRing(int id, {bool dropped = false});
}
