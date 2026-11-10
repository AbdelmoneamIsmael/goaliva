import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    required DateTime focusedDay,
    required DateTime selectedDay,
    required Set<DateTime> completedDays,
  }) = _HomeState;
}
