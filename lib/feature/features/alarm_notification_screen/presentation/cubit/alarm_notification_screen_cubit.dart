import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'alarm_notification_screen_state.dart';

class AlarmNotificationScreenCubit extends Cubit<AlarmNotificationScreenState> {
  AlarmNotificationScreenCubit() : super(AlarmNotificationScreenInitial());
}
