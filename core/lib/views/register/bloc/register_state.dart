import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// The register states
@immutable
abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => null;
}

/// The register initial state
class RegisterInitial extends RegisterState {}

/// The register fill success state
class RegisterFillSuccess extends RegisterState {}

/// The register fill in progress state
class RegisterFillInProgress extends RegisterState {}

/// The register validate in progress state
class RegisterValidateInProgress extends RegisterState {}
