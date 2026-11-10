import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/alarm.dart';

part 'alarm_state.freezed.dart';

@freezed
abstract class AlarmState with _$AlarmState {
  const AlarmState._();

  const factory AlarmState({
    required List<Alarm> alarms,
  }) = _AlarmState;

  int get activeCount => alarms.where((alarm) => alarm.enabled).length;
}
