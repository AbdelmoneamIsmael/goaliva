import 'package:goaliva/core/const/tabels_name.dart';
import 'package:goaliva/core/local_db/local_db.dart';
import 'package:goaliva/core/models/alarm/alarm.dart';
import 'package:goaliva/core/repo/alarm_repo/alarm_local_repo.dart';

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
  Future<AlarmModel?> getById(int id) {
    return _table.getById(id);
  }

  @override
  Future<void> save(AlarmModel alarm) async {
    await _table.save(alarm);
  }

  @override
  Future<void> delete(int id) async {
    await _table.deleteById(id);
  }
}
