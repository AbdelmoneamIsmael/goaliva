/// Describes a single SQLite table and its optional indexes.
class TableSchema {
  const TableSchema({
    required this.name,
    required this.createSql,
    this.indexes = const [],
  });

  final String name;

  /// Full `CREATE TABLE IF NOT EXISTS ...` statement.
  final String createSql;

  /// Optional `CREATE INDEX IF NOT EXISTS ...` statements.
  final List<String> indexes;
}
