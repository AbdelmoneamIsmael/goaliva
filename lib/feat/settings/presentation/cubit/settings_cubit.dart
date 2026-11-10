import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.remindersEnabled = true,
    this.dailySparkEnabled = true,
    this.goalCheckInsEnabled = false,
    this.soundEnabled = true,
  });

  final bool remindersEnabled;
  final bool dailySparkEnabled;
  final bool goalCheckInsEnabled;
  final bool soundEnabled;

  SettingsState copyWith({
    bool? remindersEnabled,
    bool? dailySparkEnabled,
    bool? goalCheckInsEnabled,
    bool? soundEnabled,
  }) {
    return SettingsState(
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      dailySparkEnabled: dailySparkEnabled ?? this.dailySparkEnabled,
      goalCheckInsEnabled: goalCheckInsEnabled ?? this.goalCheckInsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
    );
  }

  @override
  List<Object?> get props => [
        remindersEnabled,
        dailySparkEnabled,
        goalCheckInsEnabled,
        soundEnabled,
      ];
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void setRemindersEnabled(bool value) {
    emit(state.copyWith(remindersEnabled: value));
  }

  void setDailySparkEnabled(bool value) {
    emit(state.copyWith(dailySparkEnabled: value));
  }

  void setGoalCheckInsEnabled(bool value) {
    emit(state.copyWith(goalCheckInsEnabled: value));
  }

  void setSoundEnabled(bool value) {
    emit(state.copyWith(soundEnabled: value));
  }

  Future<void> setTheme(ThemeCubit themeCubit, ThemeMode mode) {
    return themeCubit.setThemeMode(mode);
  }
}
