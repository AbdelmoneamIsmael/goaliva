import 'package:equatable/equatable.dart';
import 'package:goaliva/core/util/functoins/parsers.dart';

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

  final int id;
  final String title;
  final String description;
  final int hour;
  final int minute;
  final bool repeats;
  final bool enabled;
  final int year;
  final int month;
  final int day;

  factory AlarmModel.fromMap(Map<String, Object?> map) {
    return AlarmModel(
      id: asInt(map['id']),
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      hour: asInt(map['hour']),
      minute: asInt(map['minute']),
      repeats: asBool(map['repeats']),
      enabled: asBool(map['enabled']),
      year: asInt(map['year']),
      month: asInt(map['month']),
      day: asInt(map['day']),
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'hour': hour,
      'minute': minute,
      'repeats': repeats ? 1 : 0,
      'enabled': enabled ? 1 : 0,
      'year': year,
      'month': month,
      'day': day,
    };
  }

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
    year,
    month,
    day,
  ];
}
