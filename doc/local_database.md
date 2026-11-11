# Local database layer

Reusable sqflite helpers live under `lib/core/local_db/`. That folder has no Goaliva-specific imports, so you can copy it into another Flutter app and wire a new `DatabaseConfig`.

App-specific names, version, and schemas live outside that folder:

- `lib/core/const/tabels_name.dart` — table name constants
- `lib/core/const/constant.dart` — `databaseName`, `databaseVersion`
- `lib/core/local_db_setup/app_database_schema.dart` — builds `DatabaseConfig`
- `lib/core/di/injection.dart` — registers `DatabaseProvider` and `LocalDataSource`

## Architecture

```text
TablesName + constants
        │
        ▼
app_database_schema.dart  →  DatabaseConfig
        │
        ▼
DatabaseProvider  →  opens / migrates / closes SQLite
        │
        ▼
SqfliteLocalDataSource  →  raw CRUD on Map rows
        │
        ▼
LocalTable<T>  →  typed CRUD via fromMap / toMap
        │
        ▼
Feature repo (e.g. AlarmLocalRepo)
```

Each class has one job:

| Class | Responsibility |
| --- | --- |
| `TableSchema` | Table name, `CREATE TABLE` SQL, optional indexes |
| `DatabaseConfig` | DB file name, version, tables, migrations |
| `DatabaseProvider` | Open, cache, migrate, close one `Database` |
| `LocalDataSource` | Abstract CRUD on raw maps |
| `SqfliteLocalDataSource` | sqflite implementation + `LocalDbException` wrapping |
| `LocalTable<T>` | Map rows to models |
| `LocalDbException` | Single error type for callers |

Import everything with:

```dart
import 'package:goaliva/core/local_db/local_db.dart';
```

## How it is wired in Goaliva

`configureDependencies()` registers:

```dart
sl.registerLazySingleton(() => DatabaseProvider(appDatabaseConfig));
sl.registerLazySingleton<LocalDataSource>(
  () => SqfliteLocalDataSource(sl()),
);
```

Any feature can resolve the shared data source:

```dart
final source = sl<LocalDataSource>();
```

Foreign keys are enabled with `PRAGMA foreign_keys = ON` when the file opens.

## When the database opens (lazy)

`registerLazySingleton` does **not** open the DB at startup. It only registers a factory. The DB opens on the **first real use**.

There are two lazy layers:

1. **GetIt lazy singleton** — the object is created the first time you call `sl<T>()`.
2. **`DatabaseProvider.database`** — the SQLite file opens the first time something awaits `provider.database`:

```dart
Future<Database> get database async => _db ??= await _open();
```

### Call chain

```text
main()
  └─ configureDependencies()
       └─ registerLazySingleton(...)   ← only registers, nothing created yet

later: ShellPage builds
  └─ AlarmCubit(... alarmLocalRepo: sl<AlarmLocalRepo>())
       └─ first sl<AlarmLocalRepo>() creates AlarmLocalRepoImplement
            └─ that needs LocalDataSource → creates SqfliteLocalDataSource
                 └─ that needs DatabaseProvider → creates DatabaseProvider(appDatabaseConfig)
                      └─ still NO openDatabase yet

AlarmCubit constructor calls loadAlarms()
  └─ alarmLocalRepo.getAll()
       └─ LocalTable.getAll()
            └─ source.query(...)
                 └─ await _provider.database   ← HERE the file opens
                      └─ _db ??= await _open()
                           └─ openDatabase(...) → onCreate / onUpgrade
```

Summary:

- App start → config registered only
- First `sl<AlarmLocalRepo>()` → provider + data source objects created
- First query/insert (`loadAlarms`) → `goaliva.db` actually opens

After that, `_db` is cached, so later calls reuse the same connection.

## Add a new table

1. Add a name in `TablesName`:

```dart
abstract final class TablesName {
  static const alarms = 'alarms';
  static const goals = 'goals';
}
```

2. Add a `TableSchema` in `app_database_schema.dart`.

3. If the DB already exists on devices, bump `databaseVersion` in `constant.dart` and add a migration keyed by the new version:

```dart
final DatabaseConfig appDatabaseConfig = DatabaseConfig(
  name: databaseName,
  version: databaseVersion, // e.g. 2
  tables: [
    // ...existing + new TableSchema
  ],
  migrations: {
    2: [
      '''
CREATE TABLE IF NOT EXISTS goals (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL
)
''',
    ],
  },
);
```

`onCreate` runs all `tables` for a fresh install. `onUpgrade` runs migration SQL for each version from `oldVersion + 1` to `newVersion`.

## Use `LocalTable<T>`

Give the table a model with `fromMap` / `toMap`, then wrap the shared `LocalDataSource`:

```dart
final alarms = LocalTable<AlarmModel>(
  source: sl<LocalDataSource>(),
  name: TablesName.alarms,
  fromMap: AlarmModel.fromMap,
  toMap: (alarm) => alarm.toMap(),
);

await alarms.save(alarm);
final all = await alarms.getAll(orderBy: 'hour, minute');
final one = await alarms.getById(1);
await alarms.deleteById(1);
```

For custom queries, call `LocalDataSource` directly:

```dart
final rows = await sl<LocalDataSource>().query(
  TablesName.alarms,
  where: 'enabled = ?',
  whereArgs: [1],
  orderBy: 'hour, minute',
);
```

## Error handling

sqflite failures are wrapped as `LocalDbException`. Catch that type in repos or cubits:

```dart
try {
  await localRepo.save(alarm);
} on LocalDbException catch (e) {
  // show toast / log e.message and e.cause
}
```

## Port to another app

1. Copy `lib/core/local_db/`.
2. Add `sqflite` and `path` to that app's `pubspec.yaml`.
3. Create table-name constants, a `DatabaseConfig`, and register `DatabaseProvider` + `LocalDataSource` in DI.
4. Build feature repos with `LocalTable<T>` or `LocalDataSource`.
