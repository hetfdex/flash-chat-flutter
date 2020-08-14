import 'dart:async';

import 'package:bloc/bloc.dart';

import 'bloc.dart';

/// The home bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// Constructs the home bloc
  HomeBloc() : super(HomeViewActive());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressedToState(event);
    } else if (event is RegisterButtonPressed) {
      yield* _mapRegisterButtonPressedToState(event);
    } else if (event is CancelButtonPressed) {
      yield* _mapCancelButtonPressedToState(event);
    }
  }

  Stream<HomeState> _mapLoginButtonPressedToState(
      LoginButtonPressed event) async* {
    yield LoginViewActive();
  }

  Stream<HomeState> _mapRegisterButtonPressedToState(
      RegisterButtonPressed event) async* {
    yield RegisterViewActive();
  }

  Stream<HomeState> _mapCancelButtonPressedToState(
      CancelButtonPressed event) async* {
    yield HomeViewActive();
  }
}
