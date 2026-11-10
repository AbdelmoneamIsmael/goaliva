import 'package:go_router/go_router.dart';

import '../../feat/shell/presentation/pages/shell_page.dart';

abstract final class AppRoutes {
  static const String home = '/';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const ShellPage(),
    ),
  ],
);
