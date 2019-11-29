import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class LoginButtonPressed extends HomeEvent {
  @override
  String toString() => 'LoginButtonPressed';

  @override
  List<Object> get props => null;
}

class RegisterButtonPressed extends HomeEvent {
  @override
  String toString() => 'RegisterButtonPressed';

  @override
  List<Object> get props => null;
}

class CancelButtonPressed extends HomeEvent {
  @override
  String toString() => 'CancelButtonPressed';

  @override
  List<Object> get props => null;
}
