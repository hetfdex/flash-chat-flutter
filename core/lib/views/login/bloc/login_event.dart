import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginSubmitted extends LoginEvent {
  LoginSubmitted(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => <Object>[email, password];
}

class LoginChanged extends LoginEvent {
  LoginChanged(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => <Object>[email, password];
}
