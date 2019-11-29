import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {}

class RegisterSubmitted extends RegisterEvent {
  RegisterSubmitted(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => <Object>[email, password];
}

class RegisterChanged extends RegisterEvent {
  RegisterChanged(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => <Object>[email, password];
}
