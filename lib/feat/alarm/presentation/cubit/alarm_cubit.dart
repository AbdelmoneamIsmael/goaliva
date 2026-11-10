import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_repo.dart';

import '../../../../core/models/alarm/alarm.dart';
import 'alarm_state.dart';

export 'alarm_state.dart';

class AlarmCubit extends Cubit<AlarmState> {
  AlarmCubit({required this.alarmRepo})
    : super(AlarmState(alarms: buildSampleAlarms()));
  final AlarmRepo alarmRepo;

  static List<AlarmModel> buildSampleAlarms() {
    return const [
      AlarmModel(
        year: 2026,
        month: 11,
        day: 10,
        id: 'alarm_1',
        title: 'Morning focus',
        description: 'Start the day with one quiet focus block.',
        hour: 7,
        minute: 0,
        repeats: true,
        enabled: true,
      ),
      AlarmModel(
        year: 2026,
        month: 11,
        day: 10,
        id: 'alarm_2',
        title: 'Midday reset',
        description: 'Pause, breathe, and check your next task.',
        hour: 12,
        minute: 30,
        repeats: true,
        enabled: true,
      ),
      AlarmModel(
        year: 2026,
        month: 11,
        day: 10,
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

  void addAlarm(AlarmModel alarm) {
    emit(state.copyWith(alarms: [...state.alarms, alarm]));
  }

  void updateAlarm(AlarmModel alarm) {
    final alarms = state.alarms.map((item) {
      if (item.id != alarm.id) return item;
      return alarm;
    }).toList();
    emit(state.copyWith(alarms: alarms));
  }
}
