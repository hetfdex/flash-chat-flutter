import 'package:equatable/equatable.dart';

/// The home states
abstract class HomeState extends Equatable {
  /// Constructs the home state
  const HomeState();

  @override
  List<Object> get props => null;
}

/// The home view active state
class HomeViewActive extends HomeState {}

/// The login view active state
class LoginViewActive extends HomeState {}

/// The register view active state
class RegisterViewActive extends HomeState {}
