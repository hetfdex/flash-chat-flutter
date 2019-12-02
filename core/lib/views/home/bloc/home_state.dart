import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// The home states
@immutable
abstract class HomeState extends Equatable {}

/// The home active state
class HomeActive extends HomeState {
  @override
  String toString() => 'HomeActive';

  @override
  List<Object> get props => null;
}

/// The login active state
class LoginActive extends HomeState {
  @override
  String toString() => 'LoginActive';

  @override
  List<Object> get props => null;
}

/// The register active state
class RegisterActive extends HomeState {
  @override
  String toString() => 'RegisterActive';

  @override
  List<Object> get props => null;
}
