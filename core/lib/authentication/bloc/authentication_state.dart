import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {}

class Initial extends AuthenticationState {
  @override
  String toString() => 'Initial';

  @override
  List<Object> get props => null;
}

class ValidateSuccess extends AuthenticationState {
  @override
  String toString() => 'ValidateSuccess';

  @override
  List<Object> get props => null;
}

class ValidateFailure extends AuthenticationState {
  @override
  String toString() => 'ValidateFailure';

  @override
  List<Object> get props => null;
}
