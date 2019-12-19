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

/// The user logged in event
class UserLoggedIn extends AuthenticationEvent {
  /// Constructs the logged in event
  UserLoggedIn({this.user});

  /// The firebase user
  final FirebaseUser user;

  @override
  String toString() => 'UserLoggedIn: $user';

  @override
  List<Object> get props => <Object>[user];
}

/// The user logged out event
class UserLoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'UserLoggedOut';

  @override
  List<Object> get props => null;
}
