import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => null;
}

class LoggedIn extends AuthenticationEvent {
  LoggedIn(this.user);

  final FirebaseUser user;

  @override
  String toString() => 'LoggedIn: $user';

  @override
  List<Object> get props => <Object>[user];
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object> get props => null;
}
