import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// The login states
@immutable
abstract class LoginState extends Equatable {}

/// The login initial state
class LoginInitial extends LoginState {
  @override
  List<Object> get props => null;
}

/// The login fill success state
class LoginFillSuccess extends LoginState {
  @override
  List<Object> get props => null;
}

/// The login fill in progress state
class LoginFillInProgress extends LoginState {
  @override
  List<Object> get props => null;
}

/// The login validate in progress state
class LoginValidateInProgress extends LoginState {
  @override
  List<Object> get props => null;
}
