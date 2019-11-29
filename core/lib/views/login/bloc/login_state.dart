import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => null;
}

class LoginFillSuccess extends LoginState {
  @override
  List<Object> get props => null;
}

class LoginFillInProgress extends LoginState {
  @override
  List<Object> get props => null;
}

class LoginValidateInProgress extends LoginState {
  @override
  List<Object> get props => null;
}
