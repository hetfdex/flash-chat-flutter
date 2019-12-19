import 'package:equatable/equatable.dart';

/// The authentication states
abstract class AuthenticationState extends Equatable {
  /// Constructs the authentication state
  const AuthenticationState();

  @override
  List<Object> get props => null;
}

/// The initial event
class Initial extends AuthenticationState {}

/// The authentication success event
class AuthenticationSuccess extends AuthenticationState {}

/// The authentication failure event
class AuthenticationFailure extends AuthenticationState {}
