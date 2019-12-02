import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/authentication/bloc/bloc.dart';
import 'package:flash_chat_core/authentication/bloc/authentication_bloc.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flash_chat_core/views/register/bloc/bloc.dart';
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

  RegisterBloc registerBloc;

  setUp(() {
    userRepository = UserRepositoryMock();

    authenticationBloc = AuthenticationMock();

    registerBloc = RegisterBloc(userRepository, authenticationBloc);
  });

  tearDown(() {
    registerBloc.close();
  });

  group('constructor', () {
    test('null userRepository throws error', () {
      expect(
          () => RegisterBloc(null, authenticationBloc), throwsAssertionError);
    });

    test('null authenticationBloc throws error', () {
      expect(() => RegisterBloc(userRepository, null), throwsAssertionError);
    });
  });

  test('initial state is correct', () {
    expect(registerBloc.initialState, RegisterInitial());
  });

  group('RegisterChanged', () {
    blocTest(
      'emits [RegisterInitial, RegisterFillInProgress] when email and password are empty',
      build: () {
        return registerBloc;
      },
      act: (registerBlock) =>
          registerBlock.add(RegisterChanged(emptyField, emptyField)),
      expect: [
        RegisterInitial(),
        RegisterFillInProgress(),
      ],
    );

    blocTest(
      'emits [RegisterInitial, RegisterFillInProgress] when email is empty',
      build: () {
        return registerBloc;
      },
      act: (registerBlock) =>
          registerBlock.add(RegisterChanged(emptyField, invalidPassword)),
      expect: [
        RegisterInitial(),
        RegisterFillInProgress(),
      ],
    );

    blocTest(
      'emits [RegisterInitial, RegisterFillInProgress] when password is empty',
      build: () {
        return registerBloc;
      },
      act: (registerBlock) =>
          registerBlock.add(RegisterChanged(invalidEmail, emptyField)),
      expect: [
        RegisterInitial(),
        RegisterFillInProgress(),
      ],
    );

    blocTest(
      'emits [RegisterInitial, RegisterFillInProgress] when email is invalid',
      build: () {
        return registerBloc;
      },
      act: (registerBlock) =>
          registerBlock.add(RegisterChanged(invalidEmail, validPassword)),
      expect: [
        RegisterInitial(),
        RegisterFillInProgress(),
      ],
    );

    blocTest(
      'emits [RegisterInitial, RegisterFillInProgress] when password is invalid',
      build: () {
        return registerBloc;
      },
      act: (registerBlock) =>
          registerBlock.add(RegisterChanged(validEmail, invalidPassword)),
      expect: [
        RegisterInitial(),
        RegisterFillInProgress(),
      ],
    );

    blocTest(
      'emits [RegisterInitial, RegisterFillSuccess] when email and password are valid',
      build: () {
        return registerBloc;
      },
      act: (registerBlock) =>
          registerBlock.add(RegisterChanged(validEmail, validPassword)),
      expect: [
        RegisterInitial(),
        RegisterFillSuccess(null),
      ],
    );
  });

  group('RegisterSubmitted', () {
    blocTest(
      'emits [RegisterInitial, RegisterValidateInProgress, RegisterInitial] when email and password are valid',
      build: () {
        when(
          userRepository.login(
            email: validEmail,
            password: validPassword,
          ),
        ).thenAnswer((_) => Future<FirebaseUser>.value(firebaseUser));

        return registerBloc;
      },
      act: (registerBlock) =>
          registerBlock.add(RegisterSubmitted(validEmail, validPassword)),
      expect: [
        RegisterInitial(),
        RegisterValidateInProgress(),
        RegisterInitial(),
      ],
    );

    final error = Error();

    blocTest(
      'emits [RegisterInitial, RegisterValidateInProgress, LoginFormFillSuccess] on caught error',
      build: () {
        when(
          userRepository.register(
            email: invalidEmail,
            password: invalidPassword,
          ),
        ).thenAnswer((_) => Future.error(error));

        return registerBloc;
      },
      act: (registerBlock) =>
          registerBlock.add(RegisterSubmitted(invalidEmail, invalidPassword)),
      expect: [
        RegisterInitial(),
        RegisterValidateInProgress(),
        RegisterFillSuccess(error),
      ],
    );
  });
}
