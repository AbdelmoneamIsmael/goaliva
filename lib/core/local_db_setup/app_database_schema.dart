import 'package:goaliva/core/const/constant.dart';
import 'package:goaliva/core/const/tabels_name.dart';
import 'package:goaliva/core/local_db/local_db.dart';

/// App-specific database configuration.
///
/// Add a new table by:
/// 1. Adding a constant in [TablesName]
/// 2. Adding a [TableSchema] below
final DatabaseConfig appDatabaseConfig = DatabaseConfig(
  name: databaseName,
  version: databaseVersion,
  tables: [
    TableSchema(
      name: TablesName.alarms,
      createSql:
          '''
CREATE TABLE IF NOT EXISTS ${TablesName.alarms} (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  hour INTEGER NOT NULL,
  minute INTEGER NOT NULL,
  repeats INTEGER NOT NULL,
  enabled INTEGER NOT NULL,
  year INTEGER NOT NULL,
  month INTEGER NOT NULL,
  day INTEGER NOT NULL
  sound TEXT,
)
''',
    ),
  ],
  migrations: const {},
);
