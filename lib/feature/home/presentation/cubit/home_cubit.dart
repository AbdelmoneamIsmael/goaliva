import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

export 'home_state.dart';

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
