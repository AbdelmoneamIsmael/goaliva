import 'table_schema.dart';

/// App-supplied configuration for opening and migrating the local database.
class DatabaseConfig {
  const DatabaseConfig({
    required this.name,
    required this.version,
    required this.tables,
    this.migrations = const {},
  });

  /// Database file name, e.g. `goaliva.db`.
  final String name;

  /// Current schema version.
  final int version;

  /// Tables created on first open (`onCreate`).
  final List<TableSchema> tables;

  /// SQL statements keyed by the version they upgrade *to*.
  /// Example: `{ 2: ['ALTER TABLE alarms ADD COLUMN sound TEXT'] }`.
  final Map<int, List<String>> migrations;
}
