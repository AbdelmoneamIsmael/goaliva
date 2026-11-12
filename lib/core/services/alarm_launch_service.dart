import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Android bridge for an alarm full-screen launch.
///
/// The native activity stores the alarm id from `ACTION_RING`. Dart pulls it
/// once on startup, and receives later launches while the app is running.
/// Other platforms have no channel and every call is a no-op.
class AlarmLaunchService {
  AlarmLaunchService() {
    if (defaultTargetPlatform != TargetPlatform.android) return;
    _channel.setMethodCallHandler((call) async {
      if (call.method != 'alarmLaunched') return;
      final id = call.arguments;
      if (id is int) _launched.add(id);
    });
  }

  static const _channel = MethodChannel('com.abdelmoneam.goaliva/alarm_launch');

  final _launched = StreamController<int>.broadcast();

  Stream<int> get onAlarmLaunched => _launched.stream;

  /// The alarm id that opened this process, then clears it on the native side.
  Future<int?> consumeAlarmLaunch() async {
    if (defaultTargetPlatform != TargetPlatform.android) return null;
    return _channel.invokeMethod<int>('consumeAlarmLaunch');
  }

  /// Android 14+ can block full-screen intents until the user allows them.
  Future<bool> canUseFullScreenIntent() async {
    if (defaultTargetPlatform != TargetPlatform.android) return true;
    final allowed = await _channel.invokeMethod<bool>('canUseFullScreenIntent');
    return allowed ?? true;
  }

  Future<void> openFullScreenIntentSettings() async {
    if (defaultTargetPlatform != TargetPlatform.android) return;
    await _channel.invokeMethod<void>('openFullScreenIntentSettings');
  }
}
