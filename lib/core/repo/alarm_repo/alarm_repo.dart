import 'package:goaliva/core/models/alarm/alarm.dart';

abstract class AlarmRepo {
  // initialize alarm service
  Future<void> initialize();
  // set alarm
  Future<void> setAlarm(AlarmModel alarm);

  /// Schedule a one-off ring at [when] using the alarm's title and description.
  Future<void> snoozeAlarm(AlarmModel alarm, DateTime when);

  // stop alarm
  Future<void> stopAlarm(int id);
}
