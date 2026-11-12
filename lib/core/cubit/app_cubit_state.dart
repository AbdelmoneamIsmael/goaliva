part of 'app_cubit_cubit.dart';

@freezed
class AppCubitState with _$AppCubitState {
  const factory AppCubitState.initial() = _Initial;
  const factory AppCubitState.alarmTriggered(int alarmId) = _AlarmTriggered;
}
