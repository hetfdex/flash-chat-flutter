import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// The authentication states
@immutable
abstract class AuthenticationState extends Equatable {}

/// The initial event
class Initial extends AuthenticationState {
  @override
  String toString() => 'Initial';

  @override
  List<Object> get props => null;
}

/// The validate success event
class ValidateSuccess extends AuthenticationState {
  @override
  String toString() => 'ValidateSuccess';

  @override
  List<Object> get props => null;
}

/// The validate failure event
class ValidateFailure extends AuthenticationState {
  @override
  String toString() => 'ValidateFailure';

  @override
  List<Object> get props => null;
}
