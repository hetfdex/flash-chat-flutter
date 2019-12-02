import 'package:equatable/equatable.dart';

/// The register events
abstract class RegisterEvent extends Equatable {
  /// Constructs the register event
  const RegisterEvent();
}

/// The register submitted event
class RegisterSubmitted extends RegisterEvent {
  /// Constructs the register submitted event
  RegisterSubmitted(this.email, this.password);

  /// The email for registration
  final String email;

  /// The password for registration
  final String password;

  @override
  List<Object> get props => <Object>[email, password];
}

/// The register changed event
class RegisterChanged extends RegisterEvent {
  /// Constructs the register changed event
  RegisterChanged(this.email, this.password);

  /// The email for registration
  final String email;

  /// The password for registration
  final String password;

  @override
  List<Object> get props => <Object>[email, password];
}
