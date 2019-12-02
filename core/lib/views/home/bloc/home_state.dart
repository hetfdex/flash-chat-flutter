import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// The home states
@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => null;
}

/// The home active state
class HomeActive extends HomeState {}

/// The login active state
class LoginActive extends HomeState {}

/// The register active state
class RegisterActive extends HomeState {}
