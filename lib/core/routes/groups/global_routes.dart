import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:goaliva/core/di/injection.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_notification_repo.dart';
import 'package:goaliva/core/routes/pages_keys.dart';
import 'package:goaliva/core/routes/route_paths.dart';
import 'package:goaliva/feature/alarm/presentation/cubit/alarm_cubit.dart';
import 'package:goaliva/feature/alarm/presentation/pages/alarm_page.dart';
import 'package:goaliva/feature/features/alarm_notification_screen/presentation/cubit/alarm_notification_screen_cubit.dart';
import 'package:goaliva/feature/features/alarm_notification_screen/presentation/pages/alarm_notification_screen.dart';

final List<RouteBase> globalRoutes = [
  GoRoute(
    name: PagesKeys.alarm,
    path: RoutePaths.root(PagesKeys.alarm),
    builder: (context, state) {
      return BlocProvider.value(
        value: sl<AlarmCubit>(),
        child: const AlarmPage(),
      );
    },
  ),
  GoRoute(
    name: PagesKeys.alarmNotification,
    path: RoutePaths.root(PagesKeys.alarmNotification),
    builder: (context, state) {
      final alarmId = state.extra as int;
      return BlocProvider(
        create: (_) => AlarmNotificationScreenCubit(
          alarmId: alarmId,
          notificationRepo: sl<AlarmNotificationRepo>(),
          alarmCubit: sl<AlarmCubit>(),
        ),
        child: const AlarmNotificationScreen(),
      );
    },
  ),
];
