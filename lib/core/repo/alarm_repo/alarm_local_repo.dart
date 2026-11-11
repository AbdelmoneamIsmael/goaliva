import 'package:goaliva/core/models/alarm/alarm.dart';

/// Persists alarms in the local SQLite database.
abstract class AlarmLocalRepo {
  Future<List<AlarmModel>> getAll();

  Future<void> save(AlarmModel alarm);

  Future<void> delete(int id);
}
