import 'dart:async';
import 'package:flash_chat_core/authentication/bloc/bloc.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flash_chat_core/utils/form_validation_utils.dart';
import 'package:flash_chat_core/views/register/bloc/bloc.dart';
import 'package:bloc/bloc.dart';

/// The register bloc
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  /// Constructs the register bloc
  RegisterBloc(this._userRepository, this._authenticationBloc)
      : assert(_userRepository != null),
        assert(_authenticationBloc != null);

  final UserRepository _userRepository;

  final AuthenticationBloc _authenticationBloc;

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterChanged) {
      yield* _mapRegisterChangedToState(event);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event);
    }
  }

  Stream<RegisterState> _mapRegisterChangedToState(
    RegisterChanged event,
  ) async* {
    yield _hasValidInputFields(event.email, event.password)
        ? RegisterFillSuccess(error: null)
        : RegisterFillInProgress();
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
    RegisterSubmitted event,
  ) async* {
    yield RegisterValidateInProgress();
    try {
      final user = await _userRepository.register(
        email: event.email,
        password: event.password,
      );

      _authenticationBloc.add(LoggedIn(user: user));

      yield RegisterInitial();
    } on Error catch (e) {
      yield RegisterFillSuccess(error: e);
    }
  }

  bool _hasValidInputFields(String email, String password) {
    return isValidEmail(email) && isValidPassword(password);
  }
}
