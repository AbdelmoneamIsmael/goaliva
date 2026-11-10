import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goaliva/core/models/alarm/alarm.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_repo.dart';
import 'package:alarm/alarm.dart';

class AlarmRepoImplement extends AlarmRepo {
  @override
  Future<void> initialize() async {
    await Alarm.init();
  }

  @override
  Future<void> setAlarm(AlarmModel alarm) async {
    final alarmSettings = AlarmSettings(
      id: 42,
      dateTime: DateTime.now().add(Duration(seconds: 10)),
      // dateTime: DateTime(alarm.year, alarm.month, alarm.day, alarm.hour, alarm.minute),
      assetAudioPath: 'assets/alarm.mp3',
      loopAudio: true,
      vibrate: true,
      warningNotificationOnKill: Platform.isIOS,
      androidFullScreenIntent: true,
      volumeSettings: VolumeSettings.fade(
        volume: 0.8,
        fadeDuration: Duration(seconds: 5),
        volumeEnforced: true,
      ),
      notificationSettings: const NotificationSettings(
        title: 'This is the title',
        body: 'This is the body',
        stopButton: 'Stop the alarm',
        icon: 'notification_icon',
        iconColor: Colors.red,
      ),
    );
    await Alarm.set(alarmSettings: alarmSettings);
  }
}
