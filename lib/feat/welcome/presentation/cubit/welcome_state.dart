import 'package:equatable/equatable.dart';

import '../../../../core/widgets/app_button.dart';

class WelcomeState extends Equatable {
  const WelcomeState({this.lastAction});

  final AppButtonVariant? lastAction;

  WelcomeState copyWith({AppButtonVariant? lastAction}) {
    return WelcomeState(lastAction: lastAction ?? this.lastAction);
  }

  @override
  List<Object?> get props => [lastAction];
}
