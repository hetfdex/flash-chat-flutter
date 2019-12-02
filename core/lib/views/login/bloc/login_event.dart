import 'package:equatable/equatable.dart';

/// The login events
abstract class LoginEvent extends Equatable {}

/// The login submitted event
class LoginSubmitted extends LoginEvent {
  /// Constructs the login submitted event
  LoginSubmitted(this.email, this.password);

  /// The registered email
  final String email;

  /// The registered password
  final String password;

  @override
  List<Object> get props => <Object>[email, password];
}

/// The login changed event
class LoginChanged extends LoginEvent {
  /// Constructs the login changed event
  LoginChanged(this.email, this.password);

  /// The registered email
  final String email;

  /// The registered password
  final String password;

  @override
  List<Object> get props => <Object>[email, password];
}
