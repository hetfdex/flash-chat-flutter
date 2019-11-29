import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeActive extends HomeState {
  @override
  String toString() => 'HomeActive';

  @override
  List<Object> get props => null;
}

class LoginActive extends HomeState {
  @override
  String toString() => 'LoginActive';

  @override
  List<Object> get props => null;
}

class RegisterActive extends HomeState {
  @override
  String toString() => 'RegisterActive';

  @override
  List<Object> get props => null;
}
