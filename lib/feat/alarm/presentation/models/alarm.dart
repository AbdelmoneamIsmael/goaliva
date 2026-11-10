import 'package:equatable/equatable.dart';

class Alarm extends Equatable {
  const Alarm({
    required this.id,
    required this.title,
    required this.description,
    required this.hour,
    required this.minute,
    required this.repeats,
    required this.enabled,
  });

  final String id;
  final String title;
  final String description;
  final int hour;
  final int minute;
  final bool repeats;
  final bool enabled;

  Alarm copyWith({
    String? title,
    String? description,
    int? hour,
    int? minute,
    bool? repeats,
    bool? enabled,
  }) {
    return Alarm(
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
