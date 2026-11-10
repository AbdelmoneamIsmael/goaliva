import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:goaliva/core/models/alarm/alarm.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_repo.dart';

class AlarmRepoImplement extends AlarmRepo {
  @override
  Future<void> initialize() async {
    await Alarm.init();
  }

  @override
  Future<void> setAlarm(AlarmModel alarm) async {
    final alarmSettings = AlarmSettings(
      id: alarm.id,
      dateTime: DateTime(
        alarm.year,
        alarm.month,
        alarm.day,
        alarm.hour,
        alarm.minute,
      ),
      assetAudioPath: 'assets/sounds/gentle_alarm.mp3',
      loopAudio: true,
      vibrate: true,
      warningNotificationOnKill: Platform.isIOS,
      androidFullScreenIntent: true,
      volumeSettings: VolumeSettings.fade(
        volume: 0.8,
        fadeDuration: const Duration(seconds: 5),
        volumeEnforced: false,
      ),
      notificationSettings: NotificationSettings(
        title: alarm.title,
        body: alarm.description,
        stopButton: "Stop the alarm",
        icon: 'notification_icon',
        iconColor: Colors.red,
      ),
    );
    await Alarm.set(alarmSettings: alarmSettings);
    print(
      '--------------------------------Alarm set successfully--------------------------------',
    );
  }

  @override
  Future<void> stopAlarm(int id) async {
    await Alarm.stop(id);
    print(
      '--------------------------------Alarm stopped successfully--------------------------------',
    );
  }
}
