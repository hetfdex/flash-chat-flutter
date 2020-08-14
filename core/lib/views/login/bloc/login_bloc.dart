import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../authentication/authentication.dart';
import '../../../repositories/repositories.dart';
import '../../../utils/utils.dart';
import 'bloc.dart';

/// The login bloc
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// Constructs the login bloc
  LoginBloc(this._userRepository, this._authenticationBloc)
      : assert(_userRepository != null),
        assert(_authenticationBloc != null),
        super(LoginInitial());

  final UserRepository _userRepository;

  final AuthenticationBloc _authenticationBloc;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginChanged) {
      yield* _mapLoginChangedToState(event);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event);
    }
  }

  Stream<LoginState> _mapLoginChangedToState(
    LoginChanged event,
  ) async* {
    yield _hasValidInputFields(event.email, event.password)
        ? LoginFillSuccess(error: null)
        : LoginFillInProgress();
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
  ) async* {
    yield LoginValidateInProgress();
    try {
      final user = await _userRepository.login(
        email: event.email,
        password: event.password,
      );

      _authenticationBloc.add(UserLoggedIn(user: user));

      yield LoginInitial();
    } on Object catch (e) {
      yield LoginFillSuccess(error: e);
    }
  }

  bool _hasValidInputFields(String email, String password) {
    return isValidEmail(email) && isValidPassword(password);
  }
}
