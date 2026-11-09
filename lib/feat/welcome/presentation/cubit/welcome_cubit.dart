import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_button.dart';
import 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(const WelcomeState());

  void onPrimaryPressed() {
    emit(state.copyWith(lastAction: AppButtonVariant.primary));
  }

  void onSecondaryPressed() {
    emit(state.copyWith(lastAction: AppButtonVariant.secondary));
  }

  void onTertiaryPressed() {
    emit(state.copyWith(lastAction: AppButtonVariant.tertiary));
  }
}
