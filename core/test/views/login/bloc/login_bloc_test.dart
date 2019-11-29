import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/authentication/bloc/bloc.dart';
import 'package:flash_chat_core/authentication/bloc/authentication_bloc.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flash_chat_core/views/login/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

class AuthenticationMock extends Mock implements AuthenticationBloc {}

class FirebaseUserMock extends Mock implements FirebaseUser {}

void main() {
  const String emptyField = '';
  const String invalidEmail = 'email';
  const String validEmail = 'email@email.com';
  const String invalidPassword = 'password';
  const String validPassword = 'Abcde12345@';

  final FirebaseUser firebaseUser = FirebaseUserMock();

  UserRepository userRepository;

  AuthenticationBloc authenticationBloc;

  LoginBloc loginBloc;

  setUp(() {
    userRepository = UserRepositoryMock();

    authenticationBloc = AuthenticationMock();

    loginBloc = LoginBloc(userRepository, authenticationBloc);
  });

  group('constructor', () {
    test('null userRepository throws error', () {
      try {
        LoginBloc(null, authenticationBloc);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null authenticationBloc throws error', () {
      try {
        LoginBloc(userRepository, null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  test('initial state is correct', () {
    expect(loginBloc.initialState, LoginInitial());
  });

  group('LoginChanged', () {
    test(
        'emits [LoginInitial, LoginFillInProgress] when email and password are empty',
        () {
      final List<LoginState> expectedResponse = <LoginState>[
        LoginInitial(),
        LoginFillInProgress(),
      ];

      expectLater(
        loginBloc.state,
        emitsInOrder(expectedResponse),
      );

      loginBloc.dispatch(LoginChanged(emptyField, emptyField));
    });

    test('emits [LoginInitial, LoginFillInProgress] when email is empty', () {
      final List<LoginState> expectedResponse = <LoginState>[
        LoginInitial(),
        LoginFillInProgress(),
      ];

      expectLater(
        loginBloc.state,
        emitsInOrder(expectedResponse),
      );

      loginBloc.dispatch(LoginChanged(emptyField, invalidPassword));
    });

    test('emits [LoginInitial, LoginFillInProgress] when password is empty',
        () {
      final List<LoginState> expectedResponse = <LoginState>[
        LoginInitial(),
        LoginFillInProgress(),
      ];

      expectLater(
        loginBloc.state,
        emitsInOrder(expectedResponse),
      );

      loginBloc.dispatch(LoginChanged(invalidEmail, emptyField));
    });

    test('emits [LoginInitial, LoginFillInProgress] when email is invalid', () {
      final List<LoginState> expectedResponse = <LoginState>[
        LoginInitial(),
        LoginFillInProgress(),
      ];

      expectLater(
        loginBloc.state,
        emitsInOrder(expectedResponse),
      );

      loginBloc.dispatch(LoginChanged(invalidEmail, validPassword));
    });

    test('emits [LoginInitial, LoginFillInProgress] when password is invalid',
        () {
      final List<LoginState> expectedResponse = <LoginState>[
        LoginInitial(),
        LoginFillInProgress(),
      ];

      expectLater(
        loginBloc.state,
        emitsInOrder(expectedResponse),
      );

      loginBloc.dispatch(LoginChanged(validEmail, invalidPassword));
    });

    test(
        'emits [LoginInitial, LoginFillSuccess] when email and password are valid',
        () {
      final List<LoginState> expectedResponse = <LoginState>[
        LoginInitial(),
        LoginFillSuccess(),
      ];

      expectLater(
        loginBloc.state,
        emitsInOrder(expectedResponse),
      );

      loginBloc.dispatch(LoginChanged(validEmail, validPassword));
    });
  });

  group('const LoginSubmitted', () {
    test(
        'emits [LoginInitial, LoginValidateInProgress, LoginInitial] when email and password are valid',
        () {
      final List<LoginState> expectedResponse = <LoginState>[
        LoginInitial(),
        LoginValidateInProgress(),
        LoginInitial(),
      ];

      when(
        userRepository.login(
          validEmail,
          validPassword,
        ),
      ).thenAnswer((_) => Future<FirebaseUser>.value(firebaseUser));

      expectLater(
        loginBloc.state,
        emitsInOrder(expectedResponse),
      ).then((_) {
        verify(authenticationBloc.dispatch(LoggedIn(firebaseUser))).called(1);
      });

      loginBloc.dispatch(LoginSubmitted(
        validEmail,
        validPassword,
      ));
    });
  });
}
