class AlarmNotificationArgs {
  const AlarmNotificationArgs({
    required this.alarmId,
    this.exitAppOnComplete = false,
  });

  final int alarmId;

  /// Close the Android activity after dismiss or snooze.
  ///
  /// Set when a full-screen alarm intent started this process, so leaving the
  /// screen returns to the lock screen instead of the home page.
  final bool exitAppOnComplete;
}
