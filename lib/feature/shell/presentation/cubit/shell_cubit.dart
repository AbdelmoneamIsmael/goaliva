import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:goaliva/core/routes/pages_keys.dart';

import 'shell_state.dart';

export 'shell_state.dart';

class ShellCubit extends Cubit<ShellState> {
  ShellCubit({String? currentPath}) : super(const ShellState()) {
    if (currentPath != null) {
      syncFromPath(currentPath);
    }
  }

  void syncFromPath(String path) {
    final int nextIndex;
    if (path.contains(PagesKeys.calendar)) {
      nextIndex = 1;
    } else if (path.contains(PagesKeys.motivation)) {
      nextIndex = 2;
    } else if (path.contains(PagesKeys.settings)) {
      nextIndex = 3;
    } else {
      nextIndex = 0;
    }
    if (state.currentIndex == nextIndex) return;
    emit(ShellState(currentIndex: nextIndex));
  }

  void selectTab(BuildContext context, int index) {
    if (state.currentIndex == index) return;
    emit(ShellState(currentIndex: index));
    switch (index) {
      case 0:
        context.goNamed(PagesKeys.home);
      case 1:
        context.goNamed(PagesKeys.calendar);
      case 2:
        context.goNamed(PagesKeys.motivation);
      case 3:
        context.goNamed(PagesKeys.settings);
    }
  }
}
