import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goaliva/core/routing/page_keys.dart';
import 'package:goaliva/feature/features/alarm_notification_screen/presentation/pages/alarm_notification_screen.dart';

import '../../feature/shell/presentation/pages/shell_page.dart';

abstract final class AppRoutes {
  static const String home = '/';
}

class PageAppRoute {
  static final navigationKey = GlobalKey<NavigatorState>();
 static final GoRouter appRouter = GoRouter(
    navigatorKey: navigationKey,
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const ShellPage(),
      ),
      GoRoute(
        path: PageKeys.alarmNotificationScreen,
        name: PageKeys.alarmNotificationScreen,
        builder: (context, state) {
          final alarmId = state.extra as int;
          return AlarmNotificationScreen(alarmId: alarmId);
        },
      ),
    ],
  );
  
}
