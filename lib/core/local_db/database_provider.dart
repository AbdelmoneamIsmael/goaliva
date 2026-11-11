import 'package:goaliva/core/util/printer/print_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_config.dart';
import 'local_db_exception.dart';

/// Owns a single cached [Database] connection.
///
/// Responsibility: open, configure, migrate, and close — nothing else.
class DatabaseProvider {
  DatabaseProvider(this._config);

  final DatabaseConfig _config;
  Database? _db;

  Future<Database> get database async => _db ??= await _open();

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }

  Future<Database> _open() async {
    try {
      final dbPath = join(await getDatabasesPath(), _config.name);
      PrintHelper(message: 'Database path: $dbPath');
      final result = await openDatabase(
        dbPath,
        version: _config.version,
        onConfigure: _onConfigure,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
      PrintHelper(
        message: 'Database opened ----------------------------------',
      );
      PrintHelper(message: 'Database: $result');

      return result;
    } catch (e) {
      throw LocalDbException('Failed to open database "${_config.name}"', e);
    }
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
    PrintHelper(message: 'Database configured ----------------------------------');
    PrintHelper(message: 'Database: $db');
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();
    for (final table in _config.tables) {
      batch.execute(table.createSql);
      for (final index in table.indexes) {
        batch.execute(index);
      }
    }
    await batch.commit(noResult: true);
    PrintHelper(message: 'Database created ----------------------------------');
    PrintHelper(message: 'Database: $db');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (var v = oldVersion + 1; v <= newVersion; v++) {
      final statements = _config.migrations[v];
      if (statements == null) continue;
      final batch = db.batch();
      for (final sql in statements) {
        batch.execute(sql);
      }
      await batch.commit(noResult: true);
      PrintHelper(message: 'Database upgraded to version $v ----------------------------------');
      PrintHelper(message: 'Database: $db');
    }
  }
}
