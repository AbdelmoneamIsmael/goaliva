import 'package:get_it/get_it.dart';
import 'package:goaliva/core/local_db/local_db.dart';
import 'package:goaliva/core/local_db_setup/app_database_schema.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_local_repo.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_local_repo_implement.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_notification_repo.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_notification_repo_implement.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_repo.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_repo_implement.dart';
import 'package:goaliva/feature/alarm/presentation/cubit/alarm_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/theme_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl<SharedPreferences>()));
  forDatabaseDependencies();

  sl.registerLazySingleton<AlarmRepo>(() => AlarmRepoImplement());
  sl.registerLazySingleton<AlarmLocalRepo>(
    () => AlarmLocalRepoImplement(sl<LocalDataSource>()),
  );
  sl.registerLazySingleton<AlarmNotificationRepo>(
    () => AlarmNotificationRepoImplement(
      alarmRepo: sl<AlarmRepo>(),
      alarmLocalRepo: sl<AlarmLocalRepo>(),
    ),
  );
  sl.registerLazySingleton<AlarmCubit>(
    () => AlarmCubit(
      alarmRepo: sl<AlarmRepo>(),
      alarmLocalRepo: sl<AlarmLocalRepo>(),
    ),
  );
}

void forDatabaseDependencies() {
  sl.registerLazySingleton<DatabaseProvider>(() => DatabaseProvider(appDatabaseConfig));
  sl.registerLazySingleton<LocalDataSource>(() => SqfliteLocalDataSource(sl<DatabaseProvider>()));
}
