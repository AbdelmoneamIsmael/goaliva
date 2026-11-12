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
    final alarmSettings = _settings(
      alarm: alarm,
      dateTime: DateTime(
        alarm.year,
        alarm.month,
        alarm.day,
        alarm.hour,
        alarm.minute,
      ),
    );
    await Alarm.set(alarmSettings: alarmSettings);
    print(
      '--------------------------------Alarm set successfully--------------------------------',
    );
  }

  @override
  Future<void> snoozeAlarm(AlarmModel alarm, DateTime when) async {
    final alarmSettings = _settings(alarm: alarm, dateTime: when);
    await Alarm.set(alarmSettings: alarmSettings);
    print(
      '--------------------------------Alarm snoozed successfully--------------------------------',
    );
  }

  @override
  Future<void> stopAlarm(int id) async {
    await Alarm.stop(id);
    print(
      '--------------------------------Alarm stopped successfully--------------------------------',
    );
  }

  AlarmSettings _settings({
    required AlarmModel alarm,
    required DateTime dateTime,
  }) {
    return AlarmSettings(
      id: alarm.id,
      dateTime: dateTime,
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
        stopButton: 'Stop the alarm',
        icon: 'notification_icon',
        iconColor: Colors.red,
      ),
    );
  }
}
