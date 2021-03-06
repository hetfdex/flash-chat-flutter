import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../repositories/repositories.dart';
import 'bloc.dart';

/// The authentication bloc
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// Constructs the authentication bloc
  AuthenticationBloc(this._userRepository)
      : assert(_userRepository != null),
        super(AuthenticationInitial());

  final UserRepository _userRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    } else if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState(
    AppStarted event,
  ) async* {
    yield await _hasUser() ? AuthenticationSuccess() : AuthenticationFailure();
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(
    UserLoggedIn event,
  ) async* {
    yield AuthenticationSuccess();
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(
    UserLoggedOut event,
  ) async* {
    await _userRepository.logout();

    yield AuthenticationInitial();
  }

  Future<bool> _hasUser() async {
    return await _userRepository.user != null;
  }
}
