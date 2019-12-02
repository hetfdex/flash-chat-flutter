import 'package:equatable/equatable.dart';

/// The home states
abstract class HomeState extends Equatable {
  /// Constructs the home state
  const HomeState();

  @override
  List<Object> get props => null;
}

/// The home active state
class HomeActive extends HomeState {}

/// The login active state
class LoginActive extends HomeState {}

/// The register active state
class RegisterActive extends HomeState {}
