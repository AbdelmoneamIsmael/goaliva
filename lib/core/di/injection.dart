import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feat/welcome/presentation/cubit/welcome_cubit.dart';
import '../theme/theme_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerLazySingleton(() => ThemeCubit(sl<SharedPreferences>()));
  sl.registerFactory(WelcomeCubit.new);
}
