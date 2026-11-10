import 'package:sqflite/sqflite.dart';

/// Generic CRUD contract over raw map rows.
///
/// Responsibility: table-level persistence only — no model mapping.
abstract class LocalDataSource {
  Future<int> insert(
    String table,
    Map<String, Object?> values, {
    ConflictAlgorithm conflict = ConflictAlgorithm.replace,
  });

  Future<void> insertAll(
    String table,
    List<Map<String, Object?>> rows, {
    ConflictAlgorithm conflict = ConflictAlgorithm.replace,
  });

  Future<int> update(
    String table,
    Map<String, Object?> values, {
    required String where,
    required List<Object?> whereArgs,
  });

  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  });

  Future<List<Map<String, Object?>>> query(
    String table, {
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  });

  Future<Map<String, Object?>?> findFirst(
    String table, {
    required String where,
    required List<Object?> whereArgs,
  });

  Future<int> count(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  });

  Future<void> clear(String table);

  Future<List<Map<String, Object?>>> rawQuery(
    String sql, [
    List<Object?>? args,
  ]);

  Future<T> transaction<T>(Future<T> Function(Transaction txn) action);
}
