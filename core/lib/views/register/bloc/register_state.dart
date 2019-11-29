import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterState extends Equatable {}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => null;
}

class RegisterFillSuccess extends RegisterState {
  @override
  List<Object> get props => null;
}

class RegisterFillInProgress extends RegisterState {
  @override
  List<Object> get props => null;
}

class RegisterValidateInProgress extends RegisterState {
  @override
  List<Object> get props => null;
}
