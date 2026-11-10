import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(true) bool remindersEnabled,
    @Default(true) bool dailySparkEnabled,
    @Default(false) bool goalCheckInsEnabled,
    @Default(true) bool soundEnabled,
  }) = _SettingsState;
}
