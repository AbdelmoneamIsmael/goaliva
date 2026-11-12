# Study: the alarm screen when the app is closed

This is a study document, not a short summary. It is the English twin of [alarm_background_ar.md](alarm_background_ar.md). The short operational note is [alarm_background.md](alarm_background.md).

Read it in this order:

1. The problem, so you know what was broken.
2. The native Android ideas. That is the lesson.
3. The two native files, line by line: `AndroidManifest.xml`, then `MainActivity.kt`.
4. The Activity lifecycle log. That answers which function runs, when, and why.
5. The bridge into Flutter, then the database.
6. The decision log: why this path was chosen.
7. The scenarios. Read them again after the code, not before.

---

## 1. The problem before the change

The `alarm` package, version `5.15.0`, rings even if the app has been killed. The sound is not Flutter. The sound comes from a native Android service named `AlarmService` that lives inside the package.

Two things were missing:

- The screen. On ring, the system opened the plain launcher `MainActivity` with nothing that said "this is alarm 7". Flutter waited for `Alarm.ringing`, but `Alarm.init()` ran late, after the first frame and after the exact-alarm permission request. On a cold start the alarm screen could be missed, and the activity could stay behind the lock screen.
- The database. The Stop button on the notification stops the sound inside the package, without going through Dart. The SQLite row stays `enabled = 1` with a time in the past. A repeating alarm is not scheduled for the next day.

The goal was the same Flutter screen, even when the process is dead, and a database update for every way a ring can end. iOS was not touched.

---

## 2. File map

| File | Language | Job |
| --- | --- | --- |
| `android/app/src/main/AndroidManifest.xml` | XML | Tells the system which activities and permissions exist, and that this activity accepts the ring intent |
| `android/app/src/main/kotlin/.../MainActivity.kt` | Kotlin | Reads the ring intent and hands the id to Dart |
| `lib/core/services/alarm_launch_service.dart` | Dart | The other side of the bridge |
| `lib/main.dart` | Dart | Starts the package before the first frame, and asks for permissions after it |
| `lib/core/cubit/app_cubit_cubit.dart` | Dart | Opens the alarm screen once |
| `lib/core/repo/alarm_repo/alarm_notification_repo_implement.dart` | Dart | Dismiss, snooze, and the row write |
| `lib/core/services/alarm_sync_service.dart` | Dart | Writes the row when a ring ends outside the screen |

The native code we wrote is two files: the manifest and the activity. Scheduling, audio, the notification, and the foreground service live in the package at:

`~/.pub-cache/hosted/pub.dev/alarm-5.15.0/android/...`

When this document says "the package", it means that code. We do not rewrite it. We teach our activity how to receive it.

---

## 3. The Android ideas this work stands on

### Process and activity

A process is your program while it is in memory. If the user swipes the app away from recents, Android kills the process. Every Kotlin and Dart variable dies with it.

An activity is one screen with a lifecycle. Our `MainActivity` is the only Flutter activity. The whole app is one Android screen. Moving between pages happens inside Flutter with `go_router`, not with extra Android activities.

Killing the app kills the process. Popping a Flutter route does not.

### Intent

An `Intent` is a message. It carries:

- An action: what we want. `android.intent.action.MAIN` when the icon is tapped, or `com.gdelataillade.alarm.action.RING` when an alarm rings.
- Extras: small pieces of data. The package puts `alarmId` here.
- Flags: how the screen should open. `FLAG_ACTIVITY_NEW_TASK` means "open this in a task, even if no activity is currently visible".

The system does not call a function you named. It delivers an intent to an activity. The activity reads it in `onCreate` or `onNewIntent`.

### Intent filter

A filter in the manifest says "I accept this kind of intent". Without a `RING` filter, the package looks, finds nobody, and opens the normal launcher activity. That intent looks exactly like an icon tap: its action is `MAIN` and it carries no `alarmId`. From inside the activity you cannot tell "the user opened the app" from "the alarm opened the app".

That is why the `RING` filter was added. After it:

- An icon tap arrives with action `MAIN`.
- A ring, and a tap on the alarm notification, arrive with action `RING` and an `alarmId`.

### launchMode = singleTop

The activity is `singleTop`. That means:

- If the activity does not exist, the system creates it and calls `onCreate`.
- If the activity exists and is at the top of its task, the system does not create a second copy. It calls `onNewIntent` on the living instance.

Without `setIntent(intent)` inside `onNewIntent`, `getIntent()` keeps returning the intent that originally created the activity. That line is easy to forget. It is there on purpose.

### PendingIntent

A pending intent is a signed permission for the package to do something later, even after our process has died. The package builds a `PendingIntent` that points at our activity and gives it to the notification. When the time comes, the system itself fires that intent. Our app does not have to be awake to fire it.

Two kinds are used inside the package, not in our code:

- `PendingIntent.getActivity` opens an activity. This is what opens our screen.
- `PendingIntent.getBroadcast` sends a broadcast to `AlarmReceiver`. The notification Stop button uses this, so it stops the sound without starting Flutter.

### Full-screen intent

From about Android 10, a normal app cannot jump over other apps whenever it wants. The exception still allowed for alarms is `setFullScreenIntent` on a notification whose category is `CATEGORY_ALARM`.

If the screen is locked and the device allows it, the system treats the intent as a full-screen open: it turns the screen on and opens the activity over the lock screen. If the device is unlocked, you usually get a high-priority notification only, and the activity opens when the user taps it. It is the same intent either way. The action `RING` means "opened through the notification path". It does not necessarily mean Android displayed an activity over the lock screen.

From Android 14 (API 34, codename `UPSIDE_DOWN_CAKE`) this ability is no longer granted to every app. The user allows it in system settings. We check `NotificationManager.canUseFullScreenIntent()` and open that settings screen when it is denied.

### Foreground service

The system may freely kill an ordinary service. A foreground service must show an ongoing notification, and in return it is allowed to keep running. Here that running work is the alarm sound. The package's type is `mediaPlayback`, which is why the manifest has:

`FOREGROUND_SERVICE` and `FOREGROUND_SERVICE_MEDIA_PLAYBACK`.

This is why the alarm rings while the app is dead. The service is not Flutter. Flutter dies. `AlarmManager` starts the service when the time comes.

### AlarmManager

The system alarm clock. The app tells it "wake me at this moment, even if my process is dead". `SCHEDULE_EXACT_ALARM` and `USE_EXACT_ALARM` ask for minute-level accuracy. Without them the system may delay the ring by minutes to save battery.

We never call `AlarmManager` ourselves. `Alarm.set` inside the package does that.

### showWhenLocked and turnScreenOn

Two attributes on the activity in the manifest, from API 27:

- `showWhenLocked`: draw this activity over the lock screen.
- `turnScreenOn`: turn the screen on when it opens.

Without them, a `RING` intent can still create the activity behind the lock screen, where the user never sees it. The sound plays and the screen does not appear. That was half of the bug.

Putting them on `MainActivity` means the whole app activity can show over the lock screen, not only the alarm page. That is the cost of using the single Flutter activity instead of a separate native one. The decision log covers that.

### MethodChannel

`FlutterActivity` holds a Dart engine. Kotlin and Dart cannot see each other's variables. The bridge is a channel with an agreed name:

`com.abdelmoneam.goaliva/alarm_launch`

The two directions are different:

- Dart calls Kotlin: `channel.invokeMethod("consumeAlarmLaunch")`. In Kotlin that arrives at `setMethodCallHandler`.
- Kotlin calls Dart: `channel.invokeMethod("alarmLaunched", alarmId)`. In Dart that arrives at `setMethodCallHandler`.

Each side registers a listener for the direction coming toward it. Mixing the two directions up is the most common mistake in a first channel.

### Why a cold start pulls the id instead of pushing it

The real order inside `onCreate`:

1. `super.onCreate` starts the Flutter engine.
2. Inside that, `configureFlutterEngine` runs. This is where we register the handler for calls from Dart.
3. The Flutter engine starts `main()` on another thread. `main` waits on translations, the database, and `Alarm.init`. That takes time.
4. After `super.onCreate` returns, our line runs: `handleAlarmIntent(..., notifyDart = false)`.

At step 4, Dart has usually not installed the `alarmLaunched` listener yet. A message sent now is lost. On a cold start we store the id in `pendingAlarmId` and stay quiet. Later, after the UI exists, Dart pulls the id with `consumeAlarmLaunch` and clears the slot.

In `onNewIntent` the app is already running and Dart is listening. There we push `alarmLaunched`. If the send succeeds we clear the slot. If the send fails we leave the slot, so a later `consumeAlarmLaunch` can still pick it up.

This is the rule in the package's `DETECT-ALARM-LAUNCH-ANDROID.md`: do not assume Dart is ready during `onCreate`.

---

## 4. The manifest, line by line

File: `android/app/src/main/AndroidManifest.xml`.

The permissions that matter for this path:

| Permission | Why it is here |
| --- | --- |
| `RECEIVE_BOOT_COMPLETED` | The package reschedules alarms after a reboot |
| `WAKE_LOCK` | The device does not sleep in the middle of the ring |
| `VIBRATE` | Vibration |
| `USE_FULL_SCREEN_INTENT` | Permission to declare a full-screen intent. On API 34+ the user confirms it in settings |
| `POST_NOTIFICATIONS` | Showing the notification. From API 33 it is requested at runtime |
| `SCHEDULE_EXACT_ALARM` and `USE_EXACT_ALARM` | Ring at the saved minute, not "sometime nearby" |
| `FOREGROUND_SERVICE` and `FOREGROUND_SERVICE_MEDIA_PLAYBACK` | The foreground audio service |
| `ACCESS_NOTIFICATION_POLICY` | Already present. It is about Do Not Disturb. No new behavior was added for it |

What was added on the activity itself:

```xml
android:showWhenLocked="true"
android:turnScreenOn="true"
```

And a second filter beside the launcher filter:

```xml
<intent-filter>
    <action android:name="com.gdelataillade.alarm.action.RING"/>
    <category android:name="android.intent.category.DEFAULT"/>
</intent-filter>
```

`DEFAULT` is required so an implicit intent (one that names an action and not a class) matches this activity. The package builds an intent with action `RING`, limits the search to our package, and takes the first match. If two activities declare the same action, the package logs a warning and uses the first. The action is declared on `MainActivity` only.

`exported="true"` stayed because a launcher activity must be callable by the system. Another app can, in theory, send `RING` to our activity. We treat it as a navigation signal, not as proof of identity. A dedicated alarm activity can be `exported="false"` because a `PendingIntent` is fired with our own app's identity. That path was not chosen. The reason is in the decision log.

---

## 5. MainActivity.kt, line by line

File: `android/app/src/main/kotlin/com/abdelmoneam/goaliva/MainActivity.kt`.

The class extends `FlutterActivity`. That gives us the Flutter engine and the activity lifecycle together. We do not draw UI in Kotlin. The UI stays Flutter.

### Fields

```kotlin
private var pendingAlarmId: Int? = null
private var channel: MethodChannel? = null
```

`pendingAlarmId` is a waiting slot. `Int?` means the slot may be empty. It is filled only when the action is `RING` and an id is present.

`channel` is filled in `configureFlutterEngine`. Before that it is `null`. Every use goes through `?.` so we do not crash if it is touched before the engine is ready.

The channel name is a constant shared with Dart:

```kotlin
private const val CHANNEL = "com.abdelmoneam.goaliva/alarm_launch"
```

If one character differs between Kotlin and Dart, the call returns `MissingPluginException` or `notImplemented`. Nothing wires the names up for you.

### onCreate

```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    handleAlarmIntent(intent, notifyDart = false)
}
```

`savedInstanceState` is a bundle the system sends if the activity is recreated after rotation, or after being killed in the background. We do not store `pendingAlarmId` in it. If the activity dies before Dart pulls the id, the id dies with the process, and the alarm screen then depends on `Alarm.ringing` after `Alarm.init()`. That second path is in `AppCubit`.

`notifyDart = false` is the important decision in this function. Read "Why a cold start pulls the id" above before changing that line.

### onNewIntent

```kotlin
override fun onNewIntent(intent: Intent) {
    super.onNewIntent(intent)
    setIntent(intent)
    handleAlarmIntent(intent, notifyDart = true)
}
```

This runs when the activity is alive and a new `RING` arrives, because of `singleTop`. `setIntent` updates the activity's official intent. `notifyDart = true` because Dart is running this time.

### configureFlutterEngine

This is called from inside `super.onCreate`, which is before the `handleAlarmIntent` at the end of our `onCreate`. On a cold start the order is:

1. `configureFlutterEngine` registers the handler.
2. Then `handleAlarmIntent` puts the id in the slot.
3. After the first frame, Dart pulls the slot.

The handler understands three calls coming from Dart:

| Call | Reply |
| --- | --- |
| `consumeAlarmLaunch` | Returns `pendingAlarmId`, then sets the slot to `null` |
| `canUseFullScreenIntent` | `true` below API 34, otherwise the system result |
| `openFullScreenIntentSettings` | Opens the full-screen setting, then returns `null` |

`result.success` is required. If you forget the reply, Dart stays suspended on `await` until the channel times out.

`else -> result.notImplemented()` makes a wrong name show up in the log instead of silence.

### handleAlarmIntent

```kotlin
if (intent?.action != AlarmService.ACTION_RING) return
val alarmId = intent.getIntExtra(AlarmService.EXTRA_ALARM_ID, -1)
if (alarmId == -1) return
```

`AlarmService.ACTION_RING` is the string `com.gdelataillade.alarm.action.RING`. We use the package constant so we do not copy the string and mistype it.

`getIntExtra` needs a default because the extra may be missing. `-1` was chosen because our alarm ids start at `1`. If it returns `-1`, the intent is ignored.

On a warm start:

```kotlin
channel?.invokeMethod("alarmLaunched", alarmId, object : MethodChannel.Result {
    override fun success(result: Any?) {
        pendingAlarmId = null
    }
    override fun error(...) {}
    override fun notImplemented() {}
})
```

The slot is cleared only after `success`. If Dart is not ready, the error is swallowed on purpose and the slot stays. A failed internal bridge does not show a dialog to the user.

### The full-screen check

```kotlin
if (Build.VERSION.SDK_INT < Build.VERSION_CODES.UPSIDE_DOWN_CAKE) return true
```

`UPSIDE_DOWN_CAKE` is API 34. Before that, `canUseFullScreenIntent` does not exist, and declaring the permission is enough. Calling the method on an older device throws.

`getSystemService(Context.NOTIFICATION_SERVICE)` is the older form that compiles on every API level. The newer `getSystemService(NotificationManager::class.java)` needs at least API 23. The string form is the one to study first.

Opening settings:

```kotlin
Intent(Settings.ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT).apply {
    data = Uri.parse("package:$packageName")
}
```

`data` tells the system which app's permission to manage. Without the package name you may get a generic page, or no page. `startActivity` needs a living activity, so this call runs only after the first frame, when the activity is attached.

---

## 6. Activity lifecycle log

Read this as if you were watching Logcat.

### Log A — cold start, the app was dead

The user swiped the app away. The alarm time arrived. The service started the process again.

| Step | Who | What happens |
| --- | --- | --- |
| 1 | System | Fires the `PendingIntent` with action `RING` and `alarmId` |
| 2 | System | Creates a new process and a new `MainActivity` |
| 3 | `onCreate` | `super.onCreate` |
| 4 | `configureFlutterEngine` | Registers the `alarm_launch` channel |
| 5 | Flutter engine | Starts `main()` in parallel |
| 6 | `onCreate` continues | `handleAlarmIntent(notifyDart = false)` stores the id and sends nothing |
| 7 | `onStart` then `onResume` | The activity is visible. Because of `turnScreenOn` and `showWhenLocked` this can be over the lock screen |
| 8 | `main()` | `Alarm.init()`, then `AlarmSyncService.start()`, then `runApp` |
| 9 | First frame | `AppCubit` is created |
| 10 | Dart | `consumeAlarmLaunch` pulls the id and Kotlin clears the slot |
| 11 | Next frame | `pushNamed` to the alarm screen with `exitAppOnComplete = true` |

Step 6 is always before step 10 on this path, because step 10 waits for the first frame, and the first frame does not happen before `onCreate` finishes.

### Log B — warm start, the app is open or in the background and its process is alive

| Step | Who | What happens |
| --- | --- | --- |
| 1 | System | The same `RING` intent |
| 2 | System | The activity exists and is `singleTop`, so no second activity is created |
| 3 | `onNewIntent` | `setIntent`, then `handleAlarmIntent(notifyDart = true)` |
| 4 | Kotlin | `invokeMethod("alarmLaunched", id)` |
| 5 | Dart | The listener opens the screen with `exitAppOnComplete = false` |
| 6 | Kotlin | The `success` reply clears `pendingAlarmId` |

`onCreate` is not called here. Code that looks for the id only inside `onCreate` misses every ring that happens while the app is open.

### Log C — the user tapped the app icon

| Step | What happens |
| --- | --- |
| 1 | The intent action is `MAIN` and the category is `LAUNCHER` |
| 2 | `handleAlarmIntent` sees the action is not `RING` and returns immediately |
| 3 | `pendingAlarmId` stays `null` |
| 4 | `consumeAlarmLaunch` returns `null` |
| 5 | If an alarm really is ringing, `Alarm.ringing` opens the screen, but `exitAppOnComplete` stays `false` |

The difference between A and C is the id that came from the intent, not merely "something is ringing".

---

## 7. What Dart does after the id arrives

### AlarmLaunchService

File: `lib/core/services/alarm_launch_service.dart`.

On anything other than Android every method returns immediately. There is no channel on iOS, and calling it would throw `MissingPluginException`. That guard is the only non-Android code. No iOS implementation was written.

`consumeAlarmLaunch` is the pull. `onAlarmLaunched` is the push. Both end in `_open` on `AppCubit`.

### Why Alarm.init runs before runApp

In `lib/main.dart`:

```dart
await sl<AlarmRepo>().initialize();
await sl<AlarmSyncService>().start();
```

This happens before `runApp`. `initialize` calls `Alarm.init()`. The package then reads its stored alarms and fills `Alarm.ringing`. If we waited for the first frame, startup could paint home and then jump to the alarm, or miss the event.

Permission requests stay after the first frame. `permission_handler` needs an attached activity. Asking earlier fails with `Unable to detect current Android Activity`.

If something is already ringing, every permission request is skipped for this launch:

```dart
if (Alarm.ringing.value.alarms.isNotEmpty) return;
```

A permission dialog or the full-screen settings page would cover the alarm screen. The user is asked on the next ordinary launch.

### AppCubit: open the screen once

`Alarm.ringing` replays its latest value to every new subscriber. Opening the screen from that event and from `consumeAlarmLaunch` would show two screens.

So:

- The subscription starts with `_listening = false`. The replayed value is ignored.
- `_openLaunchAlarm` reads the id itself: the ring intent first, then `Alarm.ringing` if there was no intent.
- `exitAppOnComplete` is `true` only when the id came from `consumeAlarmLaunch`.
- Then `_listening = true`. A later ring, while the app is open, opens the screen and leaves the app open after dismiss.
- `_openAlarmId` blocks pushing the same id twice. It is cleared when the page closes.

Navigation happens inside `addPostFrameCallback`. `AppCubit` is created while the UI is being built, and the router may not be ready for `pushNamed` in that same moment. The next frame is safe.

### When the whole activity is finished

On the alarm screen, if `exitAppOnComplete`:

```dart
SystemNavigator.pop();
```

That calls `finish()` on the activity. The task goes away and the user returns to the lock screen, or to whatever app was underneath. This is required when the alarm is what created the process. Popping only the Flutter route would leave home sitting over the lock screen after the alarm stopped.

If the user opened the app, we only `context.pop()` and stay inside the app.

---

## 8. The database: one rule for every path

### completeRing

In `AlarmNotificationRepoImplement`:

- A repeating alarm: compute the next future minute, call `Alarm.set`, and save the new date with `enabled = true`.
- A one-time alarm: save `enabled = false`.
- If the stored time is still in the future, do nothing. Unless the package dropped the alarm (`dropped = true`): a one-time alarm is disabled even if its time is still ahead, because the package will not ring it. A repeating alarm is scheduled again at the next future time.

Writes go through the `_serialized` queue. A second write waits for the first. After the first, the time is in the future, so the second write returns without doing anything. That stops a daily alarm from skipping an extra day when two events arrive together.

### Why isHandling exists

Snooze works like this: stop the current ring, then schedule it five minutes later.

Stopping the ring updates `Alarm.ringing` immediately, before the snooze is scheduled. `AlarmSyncService` watches that disappearance. If it treated it as a real stop, it would run `completeRing` in that window: disable a one-time alarm, or roll a repeating alarm forward to tomorrow, and it could wipe the five-minute schedule.

`_guard` puts the id in `_handling` before the stop and removes it after snooze or dismiss finishes. The watcher sees `isHandling` and ignores that disappearance.

The notification Stop button does not go through `_guard`. The watcher handles it. That is intentional.

### AlarmSyncService

It starts once, after `Alarm.init`. Three sources:

| Source | When | What it writes |
| --- | --- | --- |
| `reconcile()` at startup and when the app resumes | An enabled row whose time has passed, and which is in neither `scheduled` nor `ringing` | `completeRing` |
| An id leaving `Alarm.ringing` | Notification Stop while the app is open, or any stop from outside the screen | `reconcile(onlyId:)` immediately |
| `Alarm.events` | The package moved or dropped the alarm without Flutter. Usually delivered on the next `Alarm.init` if the app was dead | Moved, one-time: save the new time. Dropped: `completeRing(dropped: true)` |

A two-second grace on a full scan: there is a short gap between leaving `scheduled` and entering `ringing`. If we saw "the time has passed, and it is neither scheduled nor ringing" in that gap, we could roll a repeating alarm forward while it is about to ring. The grace leaves that moment alone. When we know a ring actually stopped (`onlyId`), the grace is not used.

The alarm screen itself listens to `Alarm.ringing`. If its id stops from outside while the screen is open, it calls `reconcile` and then closes. During dismiss or snooze from the buttons, `isHandling` blocks that second path. The button writes the row and closes the screen itself.

Stop pressed while the app is dead does not update SQLite in that second. There is no Dart to do it. The update happens on the next launch or the next resume. That is a limit of the system, not a hole that was forgotten.

### The package setting that changed

In `AlarmRepoImplement`:

```dart
androidFullScreenIntent: true,
androidStopAlarmOnTermination: false,
```

The second value defaults to `true`: swiping the app out of recents stops an alarm that is ringing now. It was turned off so the sound and the service stay if the ring has already started. `warningNotificationOnKill` was left as it was, and it is enabled for iOS only, because iOS stops the ring when the app is killed anyway.

No snooze button was added to the notification. Snooze stays on the screen so it goes through the database immediately, under the rule we control.

---

## 9. Decision log

Each row is a decision, the alternative that was rejected, and why.

| Decision | Rejected alternative | Why |
| --- | --- | --- |
| Keep the Flutter screen | A Kotlin activity that draws Stop and Snooze and broadcasts to `AlarmReceiver` | The screen already exists, and the buttons need SQLite. A native activity can stop the sound with no Flutter, but the database update would wait until the next open, and the UI would be built twice. The package docs allow a `RING` filter on `MainActivity` while keeping Flutter |
| `RING` filter on the existing activity | A second activity with its own `taskAffinity` and `exported=false` | The second activity either redraws the UI natively or starts another Flutter engine. This app is one activity. The cost: after dismiss we call `SystemNavigator.pop()` to return to the lock screen, and the isolation from the app task is weaker than a separate activity |
| Pull the id in `onCreate` | Send `alarmLaunched` immediately from `onCreate` | Dart has not registered its listener. The message is lost and home opens |
| Clear the slot only after `success` on a warm start | Clear the slot before sending | If the send fails, the id is gone forever |
| `Alarm.init` before `runApp` | Leave it on the first frame, as before | The first frame painted home, and the ring event could be missed or late |
| Ask for permissions after the first frame, and skip them while something is ringing | Ask in `main` before `runApp` | There is no activity to show a dialog before the first frame, and the dialog would cover the alarm screen |
| `exitAppOnComplete` only when the intent was `RING` | Finish the activity whenever `Alarm.ringing` is not empty | The user may open the app themselves while it is ringing. Finishing the activity would then throw the whole app away |
| Ignore the first value from `Alarm.ringing` | Open the screen from the subscription immediately | The subscription replays the current value, so a second screen would open on top of the cold-start screen, with the wrong exit flag |
| One `completeRing` rule | SQL in the screen and different SQL in the sync service | Two paths drift. A repeating alarm could skip an extra day if both ran |
| One write queue | Two writes in parallel | Same reason |
| `isHandling` around dismiss and snooze | Let sync treat every disappearance from `ringing` as a stop | Snooze stops the ring for a moment and then reschedules it. Sync would treat that as a final stop |
| Two-second grace on a full scan | Treat every past time as finished immediately | The moment between "scheduled" and "ringing" looks like "finished" |
| `androidStopAlarmOnTermination: false` | Keep the default `true` | Swiping the card out of recents would cut off a ring that had just started |
| No snooze button on the notification | Add `androidSnoozeButton` | The package's own snooze happens with no Dart. Snooze stays on the screen so the row is written immediately |
| No iOS code | Try to open a screen from a dead iOS process | The system does not allow it. The notification is the surface there. The request was to leave iOS alone |

---

## 10. Study scenarios

For each one: what Android does, what Kotlin does, and what is written to SQLite.

### 1) One-time alarm, app swiped away, phone locked, user taps Dismiss on the screen

1. `AlarmManager` wakes `AlarmService`.
2. The service starts audio and a notification that calls `setFullScreenIntent`.
3. The system turns the screen on and opens `MainActivity` with a `RING` intent.
4. Cold-start log in section 6. The screen opens with `exitAppOnComplete = true`.
5. The user taps Dismiss. `dismiss` sets `isHandling`, calls `Alarm.stop`, then `completeRing`.
6. The row is saved with `enabled = false`.
7. `SystemNavigator.pop()` finishes the activity. The user is back at the lock screen.
8. Sync sees the ring disappear, but `isHandling` was still true during the stop, so it ignores it. There is no second write.

### 2) The same situation, but the user taps Stop on the notification while the app is dead

1. Steps 1 to 3 happen, or the screen never opens if full-screen intent is not allowed. The notification is there.
2. The Stop button is a `PendingIntent.getBroadcast` to `AlarmReceiver`. It does not start Dart.
3. The service stops. Nobody writes SQLite at that moment.
4. The user opens the app later. `Alarm.init`, then `reconcile`.
5. The row is enabled, its time has passed, and it is in neither `scheduled` nor `ringing`. `completeRing` disables it.

If the app is opened within two seconds of the due time, the full scan may leave the row for this pass because of the grace. The next resume scans again and writes the row.

### 3) Repeating alarm, dismiss from the screen

1. Same as scenario 1 up to `completeRing`.
2. `nextRingAt` walks forward one day at a time until the time is in the future.
3. `Alarm.set` gives `AlarmManager` the new moment.
4. The row is saved with the new date and stays enabled.
5. The activity is finished if this launch came from a ring intent.

### 4) Snooze from the screen, and the app was already open

1. `onNewIntent` or `Alarm.ringing` opens the screen with `exitAppOnComplete = false`.
2. Snooze: `isHandling`, then `Alarm.stop`, then `Alarm.set` five minutes later.
3. One-time: the row moves to the snooze time.
4. Repeating: the row keeps its original time. The device rings again in about five minutes for this occurrence, then returns to the regular schedule.
5. `context.pop()` only. The app stays.
6. Sync does not run `completeRing`, because `isHandling` was true when the ring disappeared. After snooze the alarm is in `Alarm.scheduled`, so a later scan leaves it alone too.

### 5) The app is open on home, and the alarm time arrives

1. The process is alive. `onNewIntent` runs because of `singleTop`.
2. Kotlin sends `alarmLaunched`.
3. `AppCubit` has already set `_listening = true`, so it pushes the screen.
4. After dismiss, the page closes. The activity does not.

If `alarmLaunched` arrives before `AppCubit` has finished starting (a very short window at launch), the id is kept in `_queuedLaunchId` and opened after the frame.

### 6) The user opened the icon themselves while an alarm is ringing

1. The intent is `MAIN`. There is no `pendingAlarmId`.
2. `Alarm.ringing` has the id. The screen opens with `exitAppOnComplete = false`.
3. After dismiss, the user returns to the page underneath inside the app. The activity is not finished.

### 7) Android 14, and full-screen intent is denied

1. The service rings and the notification appears.
2. The system does not open the activity over the lock screen.
3. Tapping the notification still sends `RING`, so the screen opens because the filter exists.
4. On a later ordinary launch nothing is ringing, `canUseFullScreenIntent` returns `false`, and we open `ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT`.
5. After the user allows it, the next ring can open the screen over the lock screen.

### 8) The package dropped the alarm

This happens, for example, when the alarm time passed while the device was off, and the package discards it at boot instead of ringing hours late. Or when the system refuses to start the service.

Dart is not present at the moment of the decision. The package stores a marker. The next `Alarm.init` emits `AlarmDropped` on `Alarm.events`. Sync runs `completeRing(dropped: true)`.

### 9) The app is swiped away from recents while it is ringing

`androidStopAlarmOnTermination: false` tells the package not to stop this ring because of `onTaskRemoved`. The service stays, and the notification stays. Opening the app afterwards finds `Alarm.ringing` and opens the screen as in scenario 6, if the intent was not `RING`.

---

## 11. What to read in the native code while you learn

Read `MainActivity.kt` in this order, and do not skip:

1. `onCreate` and `onNewIntent`. Ask: why does the second exist if the first already reads `intent`? Answer: `singleTop` does not call `onCreate` again.
2. `configureFlutterEngine`. Ask: why register here, and not in `onCreate` after `super`? Answer: the channel handler has to exist before any call from Dart, and `configureFlutterEngine` is Flutter's official place for that.
3. `handleAlarmIntent`. Ask: why is `notifyDart` a parameter instead of a constant? Answer: the same function serves a dead start and a living start, and the only difference is whether Dart is listening.
4. `canUseFullScreenIntent`. Ask: why check the API level? Answer: the method does not exist before 34, and calling it crashes the app on older devices.

Then open the package, not to edit it, to see the other side. Inside `alarm-5.15.0`:

- `alarm/AlarmService.kt`: search for `ACTION_RING`, `ringPendingIntent`, and `resolveRingIntent`. This is where the intent our activity receives is built.
- `services/NotificationService.kt`: search for `setFullScreenIntent`. This is where the notification is marked full-screen.
- `alarm/AlarmReceiver.kt`: search for `ACTION_STOP`. This is the notification-button path, which does not go through our activity's Kotlin or through Dart.

When you see `queryIntentActivities` in `resolveRingIntent`, come back to the filter we wrote. That function asks the system: who in this package accepts the action `RING`? The system's answer comes from the manifest.

---

## 12. Limits to keep in view while you study

- iOS cannot open this screen from a dead process. Nothing was added for it.
- Stop pressed while the app is dead updates the database on the next open, not at the moment of the press.
- The single Flutter activity shows over the lock screen with all of its pages, not only the alarm page.
- Full-screen intent on Android 14 is the user's decision. Without it, the notification and the sound remain.
- The alarm id in the intent is not a secret. The activity is exported because it is the app launcher.

## 13. A manual pass after reading

1. Allow exact alarms, notifications, and full-screen intents.
2. Create an alarm one minute ahead, swipe the app away, and lock the phone.
3. Watch Logcat for the process. You want to see the activity being created, then, in Dart, the line `Alarm screen:`.
4. Dismiss from the screen. The activity should close. Open the app and confirm the row is disabled, or that a repeating alarm moved to the next day.
5. Repeat, and press Stop on the notification while the app is dead. Open the app. The row should already be updated.
6. Repeat, and snooze from the screen while the app is open. The app stays open after the page closes.
