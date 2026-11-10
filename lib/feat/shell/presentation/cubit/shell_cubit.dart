import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShellState extends Equatable {
  const ShellState({this.currentIndex = 0});

  final int currentIndex;

  @override
  List<Object?> get props => [currentIndex];
}

class ShellCubit extends Cubit<ShellState> {
  ShellCubit() : super(const ShellState());

  void selectTab(int index) {
    if (index == state.currentIndex) return;
    emit(ShellState(currentIndex: index));
  }
}
