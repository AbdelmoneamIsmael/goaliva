import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._prefs) : super(_read(_prefs));

  static const _key = 'theme_mode';

  final SharedPreferences _prefs;

  static ThemeMode _read(SharedPreferences prefs) {
    return switch (prefs.getString(_key)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    emit(mode);
    await _prefs.setString(_key, mode.name);
  }

  Future<void> toggle(Brightness platformBrightness) async {
    final isDark = state == ThemeMode.dark ||
        (state == ThemeMode.system && platformBrightness == Brightness.dark);
    await setThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
  }
}
