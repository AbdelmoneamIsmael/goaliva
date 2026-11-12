import 'package:go_router/go_router.dart';
import 'package:goaliva/core/routes/groups/global_routes.dart';
import 'package:goaliva/core/routes/groups/main_shell_route.dart';
import 'package:goaliva/core/routes/navigator_keys.dart';
import 'package:goaliva/core/routes/pages_keys.dart';
import 'package:goaliva/core/routes/route_paths.dart';
import 'package:goaliva/core/routes/widgets/error_page.dart';

class PageRoutes {
  static final GoRouter router = GoRouter(
    navigatorKey: NavigatorKeys.root,
    initialLocation: RoutePaths.main(PagesKeys.home),
    errorBuilder: (context, state) => const ErrorPage(),
    routes: [mainShellRoute, ...globalRoutes],
  );

  static void clearAndNavigate(String path, {Object? extra}) {
    while (router.canPop()) {
      router.pop();
    }
    if (path.startsWith('/')) {
      router.go(path, extra: extra);
    } else {
      router.goNamed(path, extra: extra);
    }
  }

  static void pushNamed(String name, {Object? arguments}) {
    router.pushNamed(name, extra: arguments);
  }

  static void goNamed(String name, {Object? extra}) {
    router.goNamed(name, extra: extra);
  }
}
