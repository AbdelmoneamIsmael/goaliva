import 'local_data_source.dart';

/// Typed CRUD helper that maps rows to [T] via [fromMap] / [toMap].
///
/// Responsibility: model mapping only — persistence is delegated to [source].
class LocalTable<T> {
  LocalTable({
    required this.source,
    required this.name,
    required this.fromMap,
    required this.toMap,
    this.idColumn = 'id',
  });

  final LocalDataSource source;
  final String name;
  final T Function(Map<String, Object?> map) fromMap;
  final Map<String, Object?> Function(T item) toMap;
  final String idColumn;

  Future<int> save(T item) {
    return source.insert(name, toMap(item));
  }

  Future<void> saveAll(List<T> items) {
    return source.insertAll(name, items.map(toMap).toList());
  }

  Future<List<T>> getAll({String? orderBy}) async {
    final rows = await source.query(name, orderBy: orderBy);
    return rows.map(fromMap).toList();
  }

  Future<T?> getById(Object id) async {
    final row = await source.findFirst(
      name,
      where: '$idColumn = ?',
      whereArgs: [id],
    );
    if (row == null) return null;
    return fromMap(row);
  }

  Future<int> deleteById(Object id) {
    return source.delete(
      name,
      where: '$idColumn = ?',
      whereArgs: [id],
    );
  }

  Future<void> clear() => source.clear(name);
}
