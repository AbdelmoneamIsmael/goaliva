part of 'alarm_notification_screen_cubit.dart';

sealed class AlarmNotificationScreenState {
  const AlarmNotificationScreenState();
}

final class AlarmNotificationScreenLoading
    extends AlarmNotificationScreenState {
  const AlarmNotificationScreenLoading();
}

final class AlarmNotificationScreenReady extends AlarmNotificationScreenState {
  const AlarmNotificationScreenReady({this.alarm});

  final AlarmModel? alarm;
}

final class AlarmNotificationScreenBusy extends AlarmNotificationScreenState {
  const AlarmNotificationScreenBusy({this.alarm});

  final AlarmModel? alarm;
}

final class AlarmNotificationScreenFailure
    extends AlarmNotificationScreenState {
  const AlarmNotificationScreenFailure({required this.message});

  final String message;
}

final class AlarmNotificationScreenCompleted
    extends AlarmNotificationScreenState {
  const AlarmNotificationScreenCompleted();
}
