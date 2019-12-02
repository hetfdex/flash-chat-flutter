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
      act: (loginBloc) => loginBloc.add(LoginChanged(emptyField, emptyField)),
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
      act: (loginBloc) =>
          loginBloc.add(LoginChanged(emptyField, invalidPassword)),
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
      act: (loginBloc) => loginBloc.add(LoginChanged(invalidEmail, emptyField)),
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
      act: (loginBloc) =>
          loginBloc.add(LoginChanged(invalidEmail, validPassword)),
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
      act: (loginBloc) =>
          loginBloc.add(LoginChanged(validEmail, invalidPassword)),
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
      act: (loginBloc) =>
          loginBloc.add(LoginChanged(validEmail, validPassword)),
      expect: [
        LoginInitial(),
        LoginFillSuccess(),
      ],
    );
  });

  group('LoginSubmitted', () {
    blocTest(
      'emits [LoginInitial, LoginValidateInProgress, LoginInitial] when email and password are valid',
      build: () {
        when(
          userRepository.login(
            validEmail,
            validPassword,
          ),
        ).thenAnswer((_) => Future<FirebaseUser>.value(firebaseUser));

        return loginBloc;
      },
      act: (loginBloc) =>
          loginBloc.add(LoginSubmitted(validEmail, validPassword)),
      expect: [
        LoginInitial(),
        LoginValidateInProgress(),
        LoginInitial(),
      ],
    );
  });
}
