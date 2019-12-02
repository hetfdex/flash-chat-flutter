import 'package:equatable/equatable.dart';

/// The register states
abstract class RegisterState extends Equatable {
  /// Constructs the register state
  const RegisterState();

  @override
  List<Object> get props => null;
}

/// The register initial state
class RegisterInitial extends RegisterState {}

/// The register fill success state
class RegisterFillSuccess extends RegisterState {
  /// The error thrown
  final Error error;

  /// Constructs the register fill sucess state
  const RegisterFillSuccess(this.error);

  @override
  List get props => [error];
}

/// The register fill in progress state
class RegisterFillInProgress extends RegisterState {}

/// The register validate in progress state
class RegisterValidateInProgress extends RegisterState {}
