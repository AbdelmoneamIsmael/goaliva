import 'dart:developer';

import 'package:flutter/foundation.dart';

class PrintHelper {
  PrintHelper({this.message}) {
    if (kDebugMode) {
      log(message ?? '');
    }
  }
  String? message;
  static void print(String message) {
    if (kDebugMode) {
      log(message);
    }
  }
}
