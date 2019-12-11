import 'package:equatable/equatable.dart';

/// The login states
abstract class LoginState extends Equatable {
  /// Constructs the login state
  const LoginState();

  @override
  List<Object> get props => null;
}

/// The login initial state
class LoginInitial extends LoginState {}

/// The login fill success state
class LoginFillSuccess extends LoginState {
  /// The error thrown
  final Error error;

  /// Constructs the login fill sucess state
  const LoginFillSuccess({this.error});

  @override
  List get props => [error];
}

/// The login fill in progress state
class LoginFillInProgress extends LoginState {}

/// The login validate in progress state
class LoginValidateInProgress extends LoginState {}
