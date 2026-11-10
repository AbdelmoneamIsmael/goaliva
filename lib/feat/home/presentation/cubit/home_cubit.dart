import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.focusedDay,
    required this.selectedDay,
    required this.completedDays,
  });

  final DateTime focusedDay;
  final DateTime selectedDay;
  final Set<DateTime> completedDays;

  HomeState copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
    Set<DateTime>? completedDays,
  }) {
    return HomeState(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      completedDays: completedDays ?? this.completedDays,
    );
  }

  @override
  List<Object?> get props => [focusedDay, selectedDay, completedDays];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({DateTime? now}) : super(_initial(now ?? DateTime.now()));

  static HomeState _initial(DateTime now) {
    return HomeState(
      focusedDay: now,
      selectedDay: now,
      completedDays: mockCompletedDays(now),
    );
  }

  /// Marks Mon–Thu of the focused week as completed (design mock).
  static Set<DateTime> mockCompletedDays(DateTime around) {
    final monday = around.subtract(Duration(days: around.weekday - 1));
    return {
      for (var i = 0; i < 4; i++)
        DateTime(monday.year, monday.month, monday.day + i),
    };
  }

  void selectDay(DateTime selected, DateTime focused) {
    emit(
      state.copyWith(
        selectedDay: selected,
        focusedDay: focused,
      ),
    );
  }

  void changeWeek(DateTime focused) {
    emit(
      state.copyWith(
        focusedDay: focused,
        completedDays: mockCompletedDays(focused),
      ),
    );
  }
}
