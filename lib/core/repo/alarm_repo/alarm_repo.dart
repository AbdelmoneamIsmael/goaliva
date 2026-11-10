import 'package:goaliva/core/models/alarm/alarm.dart';

abstract class AlarmRepo {
  // initialize alarm service
  Future<void> initialize();
  // set alarm
  Future<void> setAlarm(AlarmModel alarm);

  // stop alarm
  Future<void> stopAlarm(int id);


}
