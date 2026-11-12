import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_repo.dart';
import 'package:goaliva/core/services/alarm_launch_service.dart';
import 'package:goaliva/core/services/alarm_sync_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app.dart';
import 'core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    EasyLocalization.ensureInitialized(),
    ScreenUtil.ensureScreenSize(),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    configureDependencies(),
  ]);

  // The alarm plugin must be ready before the first frame so a cold start
  // from a full-screen intent can open the alarm screen immediately.
  await sl<AlarmRepo>().initialize();
  await sl<AlarmSyncService>().start();

  // The Android activity is attached by the first frame. Requesting earlier
  // makes permission_handler fail with "Unable to detect current Android Activity."
  WidgetsBinding.instance.addPostFrameCallback((_) {
    unawaited(initializeApp());
  });

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const GoalivaApp(),
    ),
  );
}

Future<void> initializeApp() async {
  if (defaultTargetPlatform != TargetPlatform.android) return;
  // A permission dialog would cover the alarm screen on a cold start.
  if (Alarm.ringing.value.alarms.isNotEmpty) return;
  await checkAndroidScheduleExactAlarmPermission();
  await checkAndroidNotificationPermission();
  await checkAndroidFullScreenIntentPermission();
}

Future<void> checkAndroidScheduleExactAlarmPermission() async {
  final status = await Permission.scheduleExactAlarm.status;
  print('Schedule exact alarm permission: $status.');
  if (status.isDenied) {
    print('Requesting schedule exact alarm permission...');
    final res = await Permission.scheduleExactAlarm.request();
    print(
      'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.',
    );
  }
}

Future<void> checkAndroidNotificationPermission() async {
  final status = await Permission.notification.status;
  if (status.isDenied) {
    await Permission.notification.request();
  }
}

Future<void> checkAndroidFullScreenIntentPermission() async {
  final launch = sl<AlarmLaunchService>();
  final allowed = await launch.canUseFullScreenIntent();
  if (!allowed) {
    await launch.openFullScreenIntentSettings();
  }
}
