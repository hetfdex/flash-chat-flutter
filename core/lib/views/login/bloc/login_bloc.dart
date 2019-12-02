import 'dart:async';
import 'package:flash_chat_core/authentication/bloc/bloc.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flash_chat_core/utils/form_validation_utils.dart';
import 'package:flash_chat_core/views/login/bloc/bloc.dart';
import 'package:bloc/bloc.dart';

/// The login bloc
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// Constructs the login bloc
  LoginBloc(this._userRepository, this._authenticationBloc)
      : assert(_userRepository != null),
        assert(_authenticationBloc != null);

  final UserRepository _userRepository;

  final AuthenticationBloc _authenticationBloc;

  @override
  LoginState get initialState => LoginInitial();

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
        ? LoginFillSuccess()
        : LoginFillInProgress();
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
  ) async* {
    yield LoginValidateInProgress();
    try {
      final user = await _userRepository.login(
        event.email,
        event.password,
      );

      _authenticationBloc.add(LoggedIn(user));

      yield LoginInitial();
    } on Object catch (_) {
      rethrow;
    }
  }

  bool _hasValidInputFields(String email, String password) {
    return isValidEmail(email) && isValidPassword(password);
  }
}
