import 'package:flutter/material.dart';

abstract final class NavigatorKeys {
  static final root = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final shell = GlobalKey<NavigatorState>(debugLabel: 'shell');
}
