import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// The authentication events
abstract class AuthenticationEvent extends Equatable {
  /// Constructs the authentication event
  const AuthenticationEvent();
}

/// The app started event
class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => null;
}

/// The logged in event
class LoggedIn extends AuthenticationEvent {
  /// Constructs the logged in event
  LoggedIn(this.user);

  /// The firebase user
  final FirebaseUser user;

  @override
  String toString() => 'LoggedIn: $user';

  @override
  List<Object> get props => <Object>[user];
}

/// The logged out event
class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object> get props => null;
}
