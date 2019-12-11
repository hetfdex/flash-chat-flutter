import 'package:bloc_test/bloc_test.dart';
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
  const emptyField = '';
  const invalidEmail = 'email';
  const validEmail = 'email@email.com';
  const invalidPassword = 'password';
  const validPassword = 'Abcde12345@';

  final FirebaseUser firebaseUser = FirebaseUserMock();

  UserRepository userRepository;

  AuthenticationBloc authenticationBloc;

  LoginBloc loginBloc;

  setUp(() {
    userRepository = UserRepositoryMock();

    authenticationBloc = AuthenticationMock();

    loginBloc = LoginBloc(userRepository, authenticationBloc);
  });

  tearDown(() {
    loginBloc?.close();
  });

  group('constructor', () {
    test('null userRepository throws error', () {
      expect(() => LoginBloc(null, authenticationBloc), throwsAssertionError);
    });

    test('null authenticationBloc throws error', () {
      expect(() => LoginBloc(userRepository, null), throwsAssertionError);
    });
  });

  test('initial state is correct', () {
    expect(loginBloc.initialState, LoginInitial());
  });

  group('LoginChanged', () {
    blocTest(
      'emits [LoginInitial, LoginFillInProgress] when email and password are empty',
      build: () {
        return loginBloc;
      },
      act: (loginBloc) =>
          loginBloc.add(LoginChanged(email: emptyField, password: emptyField)),
      expect: [
        LoginInitial(),
        LoginFillInProgress(),
      ],
    );

    blocTest(
      'emits [LoginInitial, LoginFillInProgress] when email is empty',
      build: () {
        return loginBloc;
      },
      act: (loginBloc) => loginBloc
          .add(LoginChanged(email: emptyField, password: invalidPassword)),
      expect: [
        LoginInitial(),
        LoginFillInProgress(),
      ],
    );

    blocTest(
      'emits [LoginInitial, LoginFillInProgress] when password is empty',
      build: () {
        return loginBloc;
      },
      act: (loginBloc) => loginBloc
          .add(LoginChanged(email: invalidEmail, password: emptyField)),
      expect: [
        LoginInitial(),
        LoginFillInProgress(),
      ],
    );

    blocTest(
      'emits [LoginInitial, LoginFillInProgress] when email is invalid',
      build: () {
        return loginBloc;
      },
      act: (loginBloc) => loginBloc
          .add(LoginChanged(email: invalidEmail, password: validPassword)),
      expect: [
        LoginInitial(),
        LoginFillInProgress(),
      ],
    );

    blocTest(
      'emits [LoginInitial, LoginFillInProgress] when password is invalid',
      build: () {
        return loginBloc;
      },
      act: (loginBloc) => loginBloc
          .add(LoginChanged(email: validEmail, password: invalidPassword)),
      expect: [
        LoginInitial(),
        LoginFillInProgress(),
      ],
    );

    blocTest(
      'emits [LoginInitial, LoginFillSuccess] when email and password are valid',
      build: () {
        return loginBloc;
      },
      act: (loginBloc) => loginBloc
          .add(LoginChanged(email: validEmail, password: validPassword)),
      expect: [
        LoginInitial(),
        LoginFillSuccess(error: null),
      ],
    );
  });

  group('LoginSubmitted', () {
    blocTest(
      'emits [LoginInitial, LoginValidateInProgress, LoginInitial] when email and password are valid',
      build: () {
        when(
          userRepository.login(
            email: validEmail,
            password: validPassword,
          ),
        ).thenAnswer((_) => Future<FirebaseUser>.value(firebaseUser));

        return loginBloc;
      },
      act: (loginBloc) => loginBloc
          .add(LoginSubmitted(email: validEmail, password: validPassword)),
      expect: [
        LoginInitial(),
        LoginValidateInProgress(),
        LoginInitial(),
      ],
    );

    final error = Error();

    blocTest(
      'emits [LoginInitial, LoginValidateInProgress, LoginFormFillSuccess] on caught error',
      build: () {
        when(
          userRepository.login(
            email: invalidEmail,
            password: invalidPassword,
          ),
        ).thenAnswer((_) => Future.error(error));

        return loginBloc;
      },
      act: (loginBlock) => loginBlock
          .add(LoginSubmitted(email: invalidEmail, password: invalidPassword)),
      expect: [
        LoginInitial(),
        LoginValidateInProgress(),
        LoginFillSuccess(error: error),
      ],
    );
  });
}
