import 'package:flutter_bloc/flutter_bloc.dart';

import 'alarm_form_state.dart';

export 'alarm_form_state.dart';

class AlarmFormCubit extends Cubit<AlarmFormState> {
  AlarmFormCubit({
    int? id,
    String title = '',
    String description = '',
    int? hour,
    int? minute,
    int? year,
    int? month,
    int? day,
    bool repeats = false,
  }) : super(
         AlarmFormState(
           id: id,
           title: title,
           description: description,
           hour: hour,
           minute: minute,
           year: year ?? DateTime.now().year,
           month: month ?? DateTime.now().month,
           day: day ?? DateTime.now().day,
           repeats: repeats,
         ),
       );

  static const int maxTitleLength = 60;
  static const int maxDescriptionLength = 160;

  void setTitle(String value) {
    emit(state.copyWith(title: value, fieldErrors: AlarmFormFieldErrors.empty));
  }

  void setDescription(String value) {
    emit(
      state.copyWith(
        description: value,
        fieldErrors: AlarmFormFieldErrors.empty,
      ),
    );
  }

  void setTime({required int hour, required int minute}) {
    emit(
      state.copyWith(
        hour: hour,
        minute: minute,
        fieldErrors: AlarmFormFieldErrors.empty,
      ),
    );
  }

  void setDate(DateTime date) {
    emit(
      state.copyWith(
        year: date.year,
        month: date.month,
        day: date.day,
        fieldErrors: AlarmFormFieldErrors.empty,
      ),
    );
  }

  void setRepeats(bool value) {
    emit(state.copyWith(repeats: value));
  }

  void clearFieldErrors() {
    if (state.fieldErrors == AlarmFormFieldErrors.empty) return;
    emit(state.copyWith(fieldErrors: AlarmFormFieldErrors.empty));
  }

  /// Returns a valid result, or `null` when field errors were emitted.
  AlarmFormResult? validate() {
    final errors = _validate(
      title: state.title,
      description: state.description,
      hour: state.hour,
      minute: state.minute,
    );

    if (errors.hasErrors) {
      emit(state.copyWith(fieldErrors: errors));
      return null;
    }

    emit(state.copyWith(fieldErrors: AlarmFormFieldErrors.empty));

    return AlarmFormResult(
      id: state.id,
      title: state.title.trim(),
      description: state.description.trim(),
      hour: state.hour!,
      minute: state.minute!,
      repeats: state.repeats,
      year: state.year,
      month: state.month,
      day: state.day,
    );
  }

  AlarmFormFieldErrors _validate({
    required String title,
    required String description,
    int? hour,
    int? minute,
  }) {
    String? titleKey;
    String? timeKey;

    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      titleKey = 'alarm.validation_title_required';
    } else if (trimmedTitle.length > maxTitleLength) {
      titleKey = 'alarm.validation_title_max';
    }

    final trimmedDescription = description.trim();
    if (trimmedDescription.isEmpty) {}

    if (hour == null || minute == null) {
      timeKey = 'alarm.validation_time_required';
    }

    return AlarmFormFieldErrors(titleKey: titleKey, timeKey: timeKey);
  }
}
