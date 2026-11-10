import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm_form_state.freezed.dart';

@freezed
abstract class AlarmFormFieldErrors with _$AlarmFormFieldErrors {
  const AlarmFormFieldErrors._();

  const factory AlarmFormFieldErrors({
    String? titleKey,
    String? descriptionKey,
    String? timeKey,
  }) = _AlarmFormFieldErrors;

  static const empty = AlarmFormFieldErrors();

  bool get hasErrors =>
      titleKey != null || descriptionKey != null || timeKey != null;
}

@freezed
abstract class AlarmFormResult with _$AlarmFormResult {
  const factory AlarmFormResult({
    String? id,
    required String title,
    required String description,
    required int hour,
    required int minute,
    required bool repeats,
  }) = _AlarmFormResult;
}

@freezed
abstract class AlarmFormState with _$AlarmFormState {
  const AlarmFormState._();

  const factory AlarmFormState({
    String? id,
    @Default('') String title,
    @Default('') String description,
    int? hour,
    int? minute,
    @Default(false) bool repeats,
    @Default(AlarmFormFieldErrors()) AlarmFormFieldErrors fieldErrors,
  }) = _AlarmFormState;

  bool get isEditing => id != null;

  bool get hasTime => hour != null && minute != null;
}
