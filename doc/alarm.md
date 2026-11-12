# Alarm feature

Alarms use two repositories so scheduling and persistence stay separate. Background ringing, the lock-screen screen, and database updates that happen outside that screen are documented in [alarm_background.md](alarm_background.md).

| Repo / service | Job |
| --- | --- |
| `AlarmRepo` | Talk to the device `alarm` package (`set` / `stop` / `init`) |
| `AlarmLocalRepo` | Persist `AlarmModel` rows in SQLite via `LocalTable` |
| `AlarmNotificationRepo` | Dismiss, snooze, and `completeRing` (plugin + SQLite) |
| `AlarmSyncService` | Apply `completeRing` when a ring ends outside the screen |

UI state lives in `AlarmCubit`. The list on screen always comes from the local database after load, add, update, toggle, or delete.

## Flow

```text
AlarmPage / AlarmFormSheet
        │
        ▼
   AlarmCubit
     ├── AlarmRepo        → device schedule / stop
     └── AlarmLocalRepo   → SQLite save / load / delete
              │
              ▼
         LocalTable<AlarmModel>
              │
              ▼
         LocalDataSource → alarms table
```

## Files

- Model: `lib/core/models/alarm/alarm.dart` (`toMap` / `fromMap`)
- Schedule helpers: `lib/core/models/alarm/alarm_schedule.dart`
- Scheduler repo: `lib/core/repo/alarm_repo/alarm_repo.dart`
- Local repo: `lib/core/repo/alarm_repo/alarm_local_repo.dart`
- Ring actions: `lib/core/repo/alarm_repo/alarm_notification_repo.dart`
- Background sync: `lib/core/services/alarm_sync_service.dart`
- Cubit: `lib/feature/alarm/presentation/cubit/alarm_cubit.dart`
- Page: `lib/feature/alarm/presentation/pages/alarm_page.dart`
- Ring screen: `lib/feature/features/alarm_notification_screen/presentation/pages/alarm_notification_screen.dart`
- Table schema: `lib/core/local_db_setup/app_database_schema.dart` (`TablesName.alarms`)

## DI wiring

```dart
sl.registerLazySingleton<AlarmRepo>(() => AlarmRepoImplement());
sl.registerLazySingleton<AlarmLocalRepo>(
  () => AlarmLocalRepoImplement(sl<LocalDataSource>()),
);
sl.registerLazySingleton<AlarmNotificationRepo>(
  () => AlarmNotificationRepoImplement(
    alarmRepo: sl<AlarmRepo>(),
    alarmLocalRepo: sl<AlarmLocalRepo>(),
  ),
);
sl.registerLazySingleton<AlarmCubit>(
  () => AlarmCubit(
    alarmRepo: sl<AlarmRepo>(),
    alarmLocalRepo: sl<AlarmLocalRepo>(),
  ),
);
sl.registerLazySingleton<AlarmSyncService>(
  () => AlarmSyncService(
    notificationRepo: sl<AlarmNotificationRepo>(),
    alarmLocalRepo: sl<AlarmLocalRepo>(),
    alarmCubit: sl<AlarmCubit>(),
  ),
);

BlocProvider.value(
  value: sl<AlarmCubit>(),
  child: const AlarmPage(),
);
```

`AlarmCubit` starts with an empty list and calls `loadAlarms()` in its constructor.

## Operations

### Load

```dart
final alarms = await alarmLocalRepo.getAll();
emit(state.copyWith(alarms: alarms));
```

Rows are ordered by `hour, minute`.

### Add

1. Schedule with `alarmRepo.setAlarm(alarm)`.
2. Persist with `alarmLocalRepo.save(alarm)`.
3. Emit the new list and show a success toast.

If either step fails, the list is left unchanged and an error toast is shown.

### Toggle enabled

- On: `setAlarm` then `save` with `enabled: true`.
- Off: `stopAlarm` then `save` with `enabled: false`.

### Update

If the alarm is enabled, reschedule with `setAlarm`, then always `save`. Disabled alarms only update the database row.

### Delete

1. `stopAlarm(id)` so the device no longer rings.
2. `alarmLocalRepo.delete(id)`.
3. Remove the item from cubit state.

## Local repo example

`AlarmLocalRepoImplement` is a thin wrapper around `LocalTable`:

```dart
class AlarmLocalRepoImplement implements AlarmLocalRepo {
  AlarmLocalRepoImplement(LocalDataSource source)
    : _table = LocalTable<AlarmModel>(
        source: source,
        name: TablesName.alarms,
        fromMap: AlarmModel.fromMap,
        toMap: (alarm) => alarm.toMap(),
      );

  final LocalTable<AlarmModel> _table;

  @override
  Future<List<AlarmModel>> getAll() {
    return _table.getAll(orderBy: 'hour, minute');
  }

  @override
  Future<void> save(AlarmModel alarm) => _table.save(alarm);

  @override
  Future<void> delete(int id) => _table.deleteById(id);
}
```

## Model mapping

Booleans are stored as SQLite integers (`0` / `1`):

```dart
Map<String, Object?> toMap() => {
  'id': id,
  'title': title,
  'description': description,
  'hour': hour,
  'minute': minute,
  'repeats': repeats ? 1 : 0,
  'enabled': enabled ? 1 : 0,
  'year': year,
  'month': month,
  'day': day,
};
```

`AlarmModel.fromMap` converts those integers back to `bool`.

## Responsibility split

- Do not put sqflite calls in `AlarmRepo`. That repo only schedules.
- Do not put `Alarm.set` / `Alarm.stop` in `AlarmLocalRepo`. That repo only persists.
- `AlarmCubit` owns the order: schedule first when needed, then write to the database, then update UI state.
