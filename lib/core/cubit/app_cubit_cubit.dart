import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:goaliva/core/routing/app_router.dart';
import 'package:goaliva/core/routing/page_keys.dart';
import 'package:goaliva/core/util/printer/print_helper.dart';

part 'app_cubit_state.dart';
part 'app_cubit_cubit.freezed.dart';

class AppCubitCubit extends Cubit<AppCubitState> {
  AppCubitCubit() : super(AppCubitState.initial()) {
    _alarmSubscription = Alarm.ringing.listen((event) {
      PrintHelper.print(
        '--------------------------------Alarm triggered: ${event.alarms.firstOrNull?.id}--------------------------------',
      );
      PrintHelper.print(
        '--------------------------------Alarm object: ${event.props.firstOrNull}--------------------------------',
      );
      final alarmId = event.alarms.firstOrNull?.id;
      if (alarmId != null) {
        PageAppRoute.pushNamed(
          PageKeys.alarmNotificationScreen,
          arguments: alarmId,
        );
      }
    });
  }
  late final StreamSubscription<AlarmSet> _alarmSubscription;
  @override
  Future<void> close() {
    _alarmSubscription.pause();
    _alarmSubscription.cancel();
    return super.close();
  }
}
