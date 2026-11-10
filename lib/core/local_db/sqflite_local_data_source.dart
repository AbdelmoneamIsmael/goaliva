import 'package:sqflite/sqflite.dart';

import 'database_provider.dart';
import 'local_data_source.dart';
import 'local_db_exception.dart';

/// sqflite-backed implementation of [LocalDataSource].
class SqfliteLocalDataSource implements LocalDataSource {
  SqfliteLocalDataSource(this._provider);

  final DatabaseProvider _provider;

  Future<Database> get _db => _provider.database;

  @override
  Future<int> insert(
    String table,
    Map<String, Object?> values, {
    ConflictAlgorithm conflict = ConflictAlgorithm.replace,
  }) {
    return _guard(
      'insert into $table',
      () async => (await _db).insert(table, values, conflictAlgorithm: conflict),
    );
  }

  @override
  Future<void> insertAll(
    String table,
    List<Map<String, Object?>> rows, {
    ConflictAlgorithm conflict = ConflictAlgorithm.replace,
  }) {
    return _guard('insertAll into $table', () async {
      final db = await _db;
      final batch = db.batch();
      for (final row in rows) {
        batch.insert(table, row, conflictAlgorithm: conflict);
      }
      await batch.commit(noResult: true);
    });
  }

  @override
  Future<int> update(
    String table,
    Map<String, Object?> values, {
    required String where,
    required List<Object?> whereArgs,
  }) {
    return _guard(
      'update $table',
      () async =>
          (await _db).update(table, values, where: where, whereArgs: whereArgs),
    );
  }

  @override
  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) {
    return _guard(
      'delete from $table',
      () async => (await _db).delete(table, where: where, whereArgs: whereArgs),
    );
  }

  @override
  Future<List<Map<String, Object?>>> query(
    String table, {
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) {
    return _guard(
      'query $table',
      () async => (await _db).query(
        table,
        where: where,
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      ),
    );
  }

  @override
  Future<Map<String, Object?>?> findFirst(
    String table, {
    required String where,
    required List<Object?> whereArgs,
  }) {
    return _guard('findFirst in $table', () async {
      final rows = await (await _db).query(
        table,
        where: where,
        whereArgs: whereArgs,
        limit: 1,
      );
      if (rows.isEmpty) return null;
      return rows.first;
    });
  }

  @override
  Future<int> count(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) {
    return _guard('count $table', () async {
      final buffer = StringBuffer('SELECT COUNT(*) AS c FROM $table');
      if (where != null && where.isNotEmpty) {
        buffer.write(' WHERE $where');
      }
      final rows = await (await _db).rawQuery(buffer.toString(), whereArgs);
      return Sqflite.firstIntValue(rows) ?? 0;
    });
  }

  @override
  Future<void> clear(String table) {
    return _guard('clear $table', () async {
      await (await _db).delete(table);
    });
  }

  @override
  Future<List<Map<String, Object?>>> rawQuery(
    String sql, [
    List<Object?>? args,
  ]) {
    return _guard(
      'rawQuery',
      () async => (await _db).rawQuery(sql, args),
    );
  }

  @override
  Future<T> transaction<T>(Future<T> Function(Transaction txn) action) {
    return _guard(
      'transaction',
      () async => (await _db).transaction(action),
    );
  }

  Future<T> _guard<T>(String operation, Future<T> Function() action) async {
    try {
      return await action();
    } on LocalDbException {
      rethrow;
    } catch (e) {
      throw LocalDbException('Failed to $operation', e);
    }
  }
}
