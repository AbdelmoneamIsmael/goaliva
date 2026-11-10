import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/alarm.dart';
import 'alarm_state.dart';

export 'alarm_state.dart';

class AlarmCubit extends Cubit<AlarmState> {
  AlarmCubit() : super(AlarmState(alarms: buildSampleAlarms()));

  static List<Alarm> buildSampleAlarms() {
    return const [
      Alarm(
        id: 'alarm_1',
        title: 'Morning focus',
        description: 'Start the day with one quiet focus block.',
        hour: 7,
        minute: 0,
        repeats: true,
        enabled: true,
      ),
      Alarm(
        id: 'alarm_2',
        title: 'Midday reset',
        description: 'Pause, breathe, and check your next task.',
        hour: 12,
        minute: 30,
        repeats: true,
        enabled: true,
      ),
      Alarm(
        id: 'alarm_3',
        title: 'Evening review',
        description: 'Look back on progress and plan tomorrow.',
        hour: 21,
        minute: 0,
        repeats: false,
        enabled: true,
      ),
    ];
  }

  void toggleEnabled(String id) {
    final alarms = state.alarms.map((alarm) {
      if (alarm.id != id) return alarm;
      return alarm.copyWith(enabled: !alarm.enabled);
    }).toList();
    emit(state.copyWith(alarms: alarms));
  }

  void deleteAlarm(String id) {
    final alarms = state.alarms.where((alarm) => alarm.id != id).toList();
    emit(state.copyWith(alarms: alarms));
  }

  void addAlarm(Alarm alarm) {
    emit(state.copyWith(alarms: [...state.alarms, alarm]));
  }

  void updateAlarm(Alarm alarm) {
    final alarms = state.alarms.map((item) {
      if (item.id != alarm.id) return item;
      return alarm;
    }).toList();
    emit(state.copyWith(alarms: alarms));
  }
}
