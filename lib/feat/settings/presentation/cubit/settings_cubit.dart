import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme_cubit.dart';
import 'settings_state.dart';

export 'settings_state.dart';

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
