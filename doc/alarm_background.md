# Alarm screen when the app is not running

Full study guide, with the Activity lifecycle log, the decision log, and the scenarios: [alarm_background_en.md](alarm_background_en.md). Arabic: [alarm_background_ar.md](alarm_background_ar.md).

Android can open the alarm screen over the lock screen after the process has been killed, and every way a ring ends updates the SQLite `alarms` row. This document covers that path. Creating and editing alarms is in [alarm.md](alarm.md).

iOS is unchanged. A killed iOS app cannot open this screen; the system notification is the only surface until the user opens the app.

## What rings when the process is dead

The `alarm` plugin (5.15.0) schedules with `AlarmManager` and rings inside its own foreground service. Dart does not have to be running for the sound to start. What Dart has to do is show `AlarmNotificationScreen` and write the database.

```text
AlarmService rings
        │
        ▼
full-screen intent  com.gdelataillade.alarm.action.RING
        │
        ▼
MainActivity  (showWhenLocked, turnScreenOn)
  stores alarmId
        │
        ▼
main()
  Alarm.init()
  AlarmSyncService.start()
        │
        ▼
AppCubit consumes the alarm id
        │
        ▼
AlarmNotificationScreen
  dismiss / snooze  →  AlarmNotificationRepo  →  plugin + SQLite
```

Tapping the alarm notification uses the same `RING` intent, so it opens the same screen.

## Android setup

`MainActivity` in `android/app/src/main/AndroidManifest.xml`:

- `android:showWhenLocked="true"` and `android:turnScreenOn="true"` so the Flutter screen is visible on the lock screen.
- A second intent filter for `com.gdelataillade.alarm.action.RING` / `DEFAULT`. The plugin opens this activity instead of a bare launcher intent. The activity stays exported because it is the launcher activity.

`MainActivity.kt` reads `AlarmService.EXTRA_ALARM_ID` in `onCreate` (cold start) and `onNewIntent` (app already running).

Channel: `com.abdelmoneam.goaliva/alarm_launch`


| Direction     | Method                         | Meaning                                                                                   |
| ------------- | ------------------------------ | ----------------------------------------------------------------------------------------- |
| Dart → native | `consumeAlarmLaunch`           | Returns the pending alarm id and clears it.                                               |
| Dart → native | `canUseFullScreenIntent`       | `true` below Android 14, otherwise `NotificationManager.canUseFullScreenIntent()`.        |
| Dart → native | `openFullScreenIntentSettings` | Opens the full-screen intent setting for this app.                                        |
| Native → Dart | `alarmLaunched`                | A new `RING` intent arrived while Dart was already running. The argument is the alarm id. |


`AlarmLaunchService` is the Dart side of that channel. On any platform other than Android every method returns immediately and does nothing.

`AlarmRepoImplement` keeps `androidFullScreenIntent: true` and sets `androidStopAlarmOnTermination: false`, so removing the app from recents does not silence a ring that already started.

## Cold start and warm start

`Alarm.init()` and `AlarmSyncService.start()` run in `main()` before `runApp()`. The alarm screen is decided before the home page can replace it.


| Launch                                         | How the id is found                          | After dismiss or snooze                                                    |
| ---------------------------------------------- | -------------------------------------------- | -------------------------------------------------------------------------- |
| Process started by the full-screen intent      | `consumeAlarmLaunch()`                       | `SystemNavigator.pop()` closes the activity and returns to the lock screen |
| App already running (`onNewIntent`)            | `alarmLaunched` on the channel               | The route is popped. The app stays open                                    |
| User opened the app while something is ringing | `Alarm.ringing` when no launch id was stored | The route is popped. The app stays open                                    |


`AppCubit` ignores the ringing value that the stream replays at subscribe time, then reads it once itself. That is what keeps a full-screen launch from also pushing a second copy of the screen. A later ring, while the app is open, still pushes the screen.

Permission dialogs (exact alarm, notifications, full-screen intent) wait until the first frame, and they are skipped entirely while an alarm is already ringing so they cannot cover the screen.

Android 14 and above does not grant full-screen intents by default. Until the user allows it, the plugin can still ring and show a notification, but the screen will not appear over the lock screen. The next normal launch opens that system setting when it is still denied.

## When the database is updated

`AlarmNotificationRepo.completeRing` is the one rule:

- A repeating alarm is moved to the next future minute (`AlarmSchedule.nextRingAt`) and scheduled again.
- A one-time alarm is saved with `enabled: false`.
- If the stored time is still in the future, it does nothing, unless the plugin dropped the alarm.

Writes are serialized. A second finish for the same row sees the new time and stops, so a repeating alarm cannot skip a day.

`dismiss` and `snooze` set `isHandling` for the whole call. Stopping the plugin removes the id from `Alarm.ringing` before snooze has scheduled the next ring. Sync ignores that drop while `isHandling` is true.


| What happened                             | Who writes the row                                                                                              | When                                                                                           |
| ----------------------------------------- | --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Dismiss on the alarm screen               | `dismiss` → `completeRing`                                                                                      | Immediately                                                                                    |
| Snooze on the alarm screen                | `snooze`                                                                                                        | Immediately. One-time rows move to the snooze time. Repeating rows keep their regular schedule |
| Stop on the notification, app is open     | `AlarmSyncService` sees the id leave `Alarm.ringing`                                                            | Immediately                                                                                    |
| Stop on the notification, process is dead | `reconcile()` on the next start or resume                                                                       | Next start or resume                                                                           |
| Plugin moved the ring (`AlarmMoved`)      | One-time rows save `nextRingAt`. Repeating rows stay on their schedule                                          | When `Alarm.events` delivers it, usually the next `Alarm.init()`                               |
| Plugin dropped the ring (`AlarmDropped`)  | `completeRing(dropped: true)`. One-time rows are disabled. Repeating rows are scheduled at the next future time | Same event delivery                                                                            |


`reconcile()` loads enabled rows whose stored time is already past. A row that is still in `Alarm.scheduled` or `Alarm.ringing` is left alone. A full scan also skips a time that became due in the last two seconds, so the handoff between "scheduled" and "ringing" cannot roll a repeating alarm forward early. A ring that just stopped passes `onlyId` and does not use that grace.

After a pass, `AlarmCubit.loadAlarms()` reloads the list.

## Permissions

Declared in `AndroidManifest.xml`:

- `USE_EXACT_ALARM` and `SCHEDULE_EXACT_ALARM` — the alarm fires at the minute that was saved
- `POST_NOTIFICATIONS` — requested at runtime on the first frame
- `USE_FULL_SCREEN_INTENT` — on Android 14+ the user must allow it in system settings
- `WAKE_LOCK`, `VIBRATE`, `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_MEDIA_PLAYBACK`, `RECEIVE_BOOT_COMPLETED` — required by the plugin service



## Manual check

1. Allow exact alarms, notifications, and (on Android 14+) full-screen intents.
2. Create a one-time alarm one minute ahead, then swipe the app away.
3. Lock the device. When it rings, the alarm screen should be on top of the lock screen and the sound should be playing.
4. Dismiss. The activity should close. Open the app: that row should be disabled.
5. Repeat with a repeating alarm. After dismiss, the row should show the next day and that next ring should be scheduled.
6. Repeat, but press Stop on the notification with the app still open. The screen should close and the row should update without using the on-screen button.
7. Repeat Stop after swiping the app away, then open the app. The row should already be updated.
8. Snooze from the screen. A one-time row should show the new time about five minutes ahead. A repeating row should keep its original time, and the device should ring again in about five minutes.

