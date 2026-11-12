import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_repo.dart';
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

  // The Android activity is attached by the first frame. Requesting earlier
  // makes permission_handler fail with "Unable to detect current Android Activity."
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await initializeApp();
    await sl<AlarmRepo>().initialize();

    

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
  await checkAndroidScheduleExactAlarmPermission();
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
