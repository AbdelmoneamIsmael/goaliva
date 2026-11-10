import 'package:get_it/get_it.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_repo.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_repo_implement.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/theme_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerLazySingleton(() => ThemeCubit(sl<SharedPreferences>()));
  sl.registerLazySingleton<AlarmRepo>(() => AlarmRepoImplement());
}
