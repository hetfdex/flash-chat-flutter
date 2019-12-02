import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flash_chat_core/authentication/bloc/bloc.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';

/// The authentication bloc
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// Constructs the authentication bloc
  AuthenticationBloc(this._userRepository) : assert(_userRepository != null);

  final UserRepository _userRepository;

  @override
  AuthenticationState get initialState => Initial();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState(
    AppStarted event,
  ) async* {
    yield await _has() ? ValidateSuccess() : ValidateFailure();
  }

  Stream<AuthenticationState> _mapLoggedInToState(
    LoggedIn event,
  ) async* {
    yield ValidateSuccess();
  }

  Stream<AuthenticationState> _mapLoggedOutToState(
    LoggedOut event,
  ) async* {
    yield ValidateFailure();
  }

  Future<bool> _has() async {
    return await _userRepository.user != null;
  }
}
