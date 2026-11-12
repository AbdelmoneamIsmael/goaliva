import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:goaliva/core/di/injection.dart';
import 'package:goaliva/core/routes/page_routes.dart';
import 'package:goaliva/core/routes/pages_keys.dart';
import 'package:goaliva/core/services/alarm_launch_service.dart';
import 'package:goaliva/core/util/printer/print_helper.dart';
import 'package:goaliva/feature/features/alarm_notification_screen/presentation/alarm_notification_args.dart';

part 'app_cubit_state.dart';
part 'app_cubit_cubit.freezed.dart';

class AppCubitCubit extends Cubit<AppCubitState> {
  AppCubitCubit({AlarmLaunchService? launchService})
    : _launchService = launchService ?? sl<AlarmLaunchService>(),
      super(AppCubitState.initial()) {
    _alarmSubscription = Alarm.ringing.listen((event) {
      if (!_listening) return;
      final alarmId = event.alarms.firstOrNull?.id;
      if (alarmId == null) return;
      unawaited(_open(alarmId, exitAppOnComplete: false));
    });
    _launchSubscription = _launchService.onAlarmLaunched.listen((alarmId) {
      if (!_listening) {
        _queuedLaunchId = alarmId;
        return;
      }
      unawaited(_open(alarmId, exitAppOnComplete: false));
    });
    unawaited(_openLaunchAlarm());
  }

  final AlarmLaunchService _launchService;
  late final StreamSubscription<AlarmSet> _alarmSubscription;
  late final StreamSubscription<int> _launchSubscription;

  /// Ignores the ringing value replayed at subscribe time. Startup reads it
  /// itself so a full-screen launch can close the activity when finished.
  var _listening = false;
  int? _openAlarmId;
  int? _queuedLaunchId;

  Future<void> _openLaunchAlarm() async {
    int? launchedId;
    try {
      launchedId = await _launchService.consumeAlarmLaunch();
    } on Exception catch (e) {
      PrintHelper.print('Alarm launch consume failed: $e');
    }

    final ringingId = Alarm.ringing.value.alarms.firstOrNull?.id;
    final alarmId = launchedId ?? ringingId;
    // Only a full-screen intent started this process. A normal open that
    // happens to find a ringing alarm stays inside the app.
    final exitApp = launchedId != null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (alarmId != null) {
        unawaited(_open(alarmId, exitAppOnComplete: exitApp));
      }
      _listening = true;
      final queued = _queuedLaunchId;
      _queuedLaunchId = null;
      if (queued != null && queued != alarmId) {
        unawaited(_open(queued, exitAppOnComplete: false));
      }
    });
  }

  Future<void> _open(int alarmId, {required bool exitAppOnComplete}) async {
    if (_openAlarmId == alarmId) return;
    _openAlarmId = alarmId;
    PrintHelper.print(
      '--------------------------------Alarm screen: $alarmId--------------------------------',
    );
    try {
      await PageRoutes.pushNamed(
        PagesKeys.alarmNotification,
        arguments: AlarmNotificationArgs(
          alarmId: alarmId,
          exitAppOnComplete: exitAppOnComplete,
        ),
      );
    } on Object catch (e) {
      PrintHelper.print('Alarm screen failed to open: $e');
    } finally {
      if (_openAlarmId == alarmId) _openAlarmId = null;
    }
  }

  @override
  Future<void> close() {
    _alarmSubscription.cancel();
    _launchSubscription.cancel();
    return super.close();
  }
}
