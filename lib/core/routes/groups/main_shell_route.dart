import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:goaliva/core/di/injection.dart';
import 'package:goaliva/core/routes/navigator_keys.dart';
import 'package:goaliva/core/routes/pages_keys.dart';
import 'package:goaliva/core/routes/route_paths.dart';
import 'package:goaliva/feature/alarm/presentation/cubit/alarm_cubit.dart';
import 'package:goaliva/feature/calendar/presentation/cubit/calendar_cubit.dart';
import 'package:goaliva/feature/calendar/presentation/pages/calendar_page.dart';
import 'package:goaliva/feature/home/presentation/cubit/home_cubit.dart';
import 'package:goaliva/feature/home/presentation/pages/home_page.dart';
import 'package:goaliva/feature/motivation/presentation/cubit/motivation_cubit.dart';
import 'package:goaliva/feature/motivation/presentation/pages/motivation_page.dart';
import 'package:goaliva/feature/settings/presentation/cubit/settings_cubit.dart';
import 'package:goaliva/feature/settings/presentation/pages/settings_page.dart';
import 'package:goaliva/feature/shell/presentation/cubit/shell_cubit.dart';
import 'package:goaliva/feature/shell/presentation/pages/shell_page.dart';
import 'package:goaliva/feature/shell/presentation/widgets/shell_path_sync.dart';

final mainShellRoute = ShellRoute(
  navigatorKey: NavigatorKeys.shell,
  builder: (context, state, child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ShellCubit(currentPath: state.uri.path),
        ),
        BlocProvider.value(value: sl<AlarmCubit>()),
      ],
      child: ShellPathSync(
        path: state.uri.path,
        child: ShellPage(child: child),
      ),
    );
  },
  routes: [
    GoRoute(
      name: PagesKeys.home,
      path: RoutePaths.main(PagesKeys.home),
      builder: (context, state) {
        return BlocProvider(
          create: (_) => HomeCubit(),
          child: const HomePage(),
        );
      },
    ),
    GoRoute(
      name: PagesKeys.calendar,
      path: RoutePaths.main(PagesKeys.calendar),
      builder: (context, state) {
        return BlocProvider(
          create: (_) => CalendarCubit(),
          child: const CalendarPage(),
        );
      },
    ),
    GoRoute(
      name: PagesKeys.motivation,
      path: RoutePaths.main(PagesKeys.motivation),
      builder: (context, state) {
        return BlocProvider(
          create: (_) => MotivationCubit(),
          child: const MotivationPage(),
        );
      },
    ),
    GoRoute(
      name: PagesKeys.settings,
      path: RoutePaths.main(PagesKeys.settings),
      builder: (context, state) {
        return BlocProvider(
          create: (_) => SettingsCubit(),
          child: const SettingsPage(),
        );
      },
    ),
  ],
);
