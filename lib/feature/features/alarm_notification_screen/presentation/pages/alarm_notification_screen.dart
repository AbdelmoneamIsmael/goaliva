import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

class AlarmNotificationScreen extends StatelessWidget {
  final int alarmId;

  const AlarmNotificationScreen({super.key, required this.alarmId});

  Future<void> dismissAlarm() async {
    await Alarm.stop(alarmId);
  }

  Future<void> snoozeAlarm() async {
    await Alarm.stop(alarmId);

    final settings = AlarmSettings(
      volumeSettings: VolumeSettings.fade(
        volume: 0.8,
        fadeDuration: const Duration(seconds: 5),
        volumeEnforced: false,
      ),
      id: alarmId,
      dateTime: DateTime.now().add(const Duration(minutes: 5)),
      assetAudioPath: 'assets/sounds/gentle_alarm.mp3',
      loopAudio: true,
      vibrate: true,
      notificationSettings: const NotificationSettings(
        title: 'Alarm',
        body: 'Time to wake up!',
        stopButton: 'Dismiss',
      ),
    );

    await Alarm.set(alarmSettings: settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Wake Up!', style: TextStyle(fontSize: 36)),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                await snoozeAlarm();
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Snooze 5 min'),
            ),
            ElevatedButton(
              onPressed: () async {
                await dismissAlarm();
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Dismiss'),
            ),
          ],
        ),
      ),
    );
  }
}
