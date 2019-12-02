import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// The authentication states
@immutable
abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => null;
}

/// The initial event
class Initial extends AuthenticationState {}

/// The validate success event
class ValidateSuccess extends AuthenticationState {}

/// The validate failure event
class ValidateFailure extends AuthenticationState {}
