import 'package:equatable/equatable.dart';

class AlarmModel extends Equatable {
  const AlarmModel({
    required this.id,
    required this.title,
    required this.description,
    required this.hour,
    required this.minute,
    required this.repeats,
    required this.enabled,
    required this.year,
    required this.month,
    required this.day,
  });

  final String id;
  final String title;
  final String description;
  final int hour;
  final int minute;
  final bool repeats;
  final bool enabled;
  final int year;
  final int month;
  final int day;
  AlarmModel copyWith({
    String? title,
    String? description,
    int? hour,
    int? minute,
    bool? repeats,
    bool? enabled,
    int? year,
    int? month,
    int? day,
  }) {
    return AlarmModel(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      repeats: repeats ?? this.repeats,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    hour,
    minute,
    repeats,
    enabled,
  ];
}
