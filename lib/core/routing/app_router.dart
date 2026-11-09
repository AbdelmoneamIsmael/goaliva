import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../feat/welcome/presentation/cubit/welcome_cubit.dart';
import '../../feat/welcome/presentation/pages/welcome_page.dart';
import '../../feat/welcome/presentation/pages/widgets_showcase_page.dart';
import '../di/injection.dart';

abstract final class AppRoutes {
  static const String welcome = '/';
  static const String widgetsShowcase = '/widgets-showcase';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  routes: [
    GoRoute(
      path: AppRoutes.welcome,
      name: 'welcome',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => sl<WelcomeCubit>(),
          child: const WelcomePage(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.widgetsShowcase,
      name: 'widgetsShowcase',
      builder: (context, state) => const WidgetsShowcasePage(),
    ),
  ],
);
