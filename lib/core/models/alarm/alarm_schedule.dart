import 'alarm.dart';

abstract final class AlarmSchedule {
  static DateTime scheduledAt(AlarmModel alarm) {
    return DateTime(
      alarm.year,
      alarm.month,
      alarm.day,
      alarm.hour,
      alarm.minute,
    );
  }

  /// Next ring time. For repeating alarms that are already past, rolls forward
  /// one day at a time until the moment is in the future.
  static DateTime? nextRingAt(AlarmModel alarm, {DateTime? now}) {
    final reference = now ?? DateTime.now();
    var next = scheduledAt(alarm);

    if (!next.isBefore(reference)) return next;
    if (!alarm.repeats) return null;

    while (next.isBefore(reference)) {
      next = next.add(const Duration(days: 1));
    }
    return next;
  }

  /// Human-readable remaining gap, e.g. `2h 15m`, `1d 3h`, or `null` when passed.
  static String? remainingLabel(AlarmModel alarm, {DateTime? now}) {
    final reference = now ?? DateTime.now();
    final next = nextRingAt(alarm, now: reference);
    if (next == null) return null;

    final remaining = next.difference(reference);
    if (remaining.inMinutes < 1) return '1m';

    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;

    final parts = <String>[];
    if (days > 0) parts.add('${days}d');
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0 && days == 0) parts.add('${minutes}m');
    if (parts.isEmpty) parts.add('1m');

    return parts.join(' ');
  }
}
