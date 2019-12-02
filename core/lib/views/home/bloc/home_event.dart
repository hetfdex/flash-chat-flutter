import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// The home events
@immutable
abstract class HomeEvent extends Equatable {
  /// Constructs the home event
  const HomeEvent();
}

/// The login button pressed event
class LoginButtonPressed extends HomeEvent {
  @override
  String toString() => 'LoginButtonPressed';

  @override
  List<Object> get props => null;
}

/// The register button pressed event
class RegisterButtonPressed extends HomeEvent {
  @override
  String toString() => 'RegisterButtonPressed';

  @override
  List<Object> get props => null;
}

/// The cancel button pressed event
class CancelButtonPressed extends HomeEvent {
  @override
  String toString() => 'CancelButtonPressed';

  @override
  List<Object> get props => null;
}
