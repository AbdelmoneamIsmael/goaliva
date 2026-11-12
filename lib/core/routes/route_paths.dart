import 'package:goaliva/core/routes/pages_keys.dart';

abstract final class RoutePaths {
  static String root(String key) => '/$key';
  static String main(String key) => '/${PagesKeys.main}/$key';
}
