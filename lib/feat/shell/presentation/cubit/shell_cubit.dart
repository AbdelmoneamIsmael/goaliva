import 'package:flutter_bloc/flutter_bloc.dart';

import 'shell_state.dart';

export 'shell_state.dart';

class ShellCubit extends Cubit<ShellState> {
  ShellCubit() : super(const ShellState());

  void selectTab(int index) {
    if (index == state.currentIndex) return;
    emit(ShellState(currentIndex: index));
  }
}
