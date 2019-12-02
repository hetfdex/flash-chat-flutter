import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// The login states
@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => null;
}

/// The login initial state
class LoginInitial extends LoginState {}

/// The login fill success state
class LoginFillSuccess extends LoginState {}

/// The login fill in progress state
class LoginFillInProgress extends LoginState {}

/// The login validate in progress state
class LoginValidateInProgress extends LoginState {}
