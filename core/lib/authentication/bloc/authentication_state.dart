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

/// The validate success event
class ValidateSuccess extends AuthenticationState {}

/// The validate failure event
class ValidateFailure extends AuthenticationState {}
