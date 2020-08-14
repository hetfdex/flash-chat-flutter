import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/authentication/bloc/authentication_bloc.dart';
import 'package:flash_chat_core/authentication/bloc/bloc.dart';
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
    expect(registerBloc.state, RegisterInitial());
  });

  group('RegisterChanged', () {
    blocTest(
      'emits [RegisterFillInProgress] when email and password are empty',
      build: () {
        return registerBloc;
      },
      act: (registerBlock) => registerBlock
          .add(RegisterChanged(email: emptyField, password: emptyField)),
      expect: [
        RegisterFillInProgress(),
      ],
    );

    blocTest(
      'emits [RegisterFillInProgress] when email is empty',
      build: () {
        return registerBloc;
      },
      act: (registerBlock) => registerBlock
          .add(RegisterChanged(email: emptyField, password: invalidPassword)),
      expect: [
        RegisterFillInProgress(),
      ],
    );

    blocTest(
      'emits [RegisterFillInProgress] when password is empty',
      build: () {
        return registerBloc;
      },
      act: (registerBlock) => registerBlock
          .add(RegisterChanged(email: invalidEmail, password: emptyField)),
      expect: [
        RegisterFillInProgress(),
      ],
    );

    blocTest(
      'emits [RegisterFillInProgress] when email is invalid',
      build: () {
        return registerBloc;
      },
      act: (registerBlock) => registerBlock
          .add(RegisterChanged(email: invalidEmail, password: validPassword)),
      expect: [
        RegisterFillInProgress(),
      ],
    );

    blocTest(
      'emits [RegisterFillInProgress] when password is invalid',
      build: () {
        return registerBloc;
      },
      act: (registerBlock) => registerBlock
          .add(RegisterChanged(email: validEmail, password: invalidPassword)),
      expect: [
        RegisterFillInProgress(),
      ],
    );

    blocTest(
      'emits [RegisterFillSuccess] when email and password are valid',
      build: () {
        return registerBloc;
      },
      act: (registerBlock) => registerBlock
          .add(RegisterChanged(email: validEmail, password: validPassword)),
      expect: [
        RegisterFillSuccess(error: null),
      ],
    );
  });

  group('RegisterSubmitted', () {
    blocTest(
      'emits [RegisterValidateInProgress, RegisterInitial] when email and password are valid',
      build: () {
        when(
          userRepository.login(
            email: validEmail,
            password: validPassword,
          ),
        ).thenAnswer((_) => Future<FirebaseUser>.value(firebaseUser));

        return registerBloc;
      },
      act: (registerBlock) => registerBlock
          .add(RegisterSubmitted(email: validEmail, password: validPassword)),
      expect: [
        RegisterValidateInProgress(),
        RegisterInitial(),
      ],
    );

    final error = Error();

    blocTest(
      'emits [RegisterValidateInProgress, LoginFormFillSuccess] on caught error',
      build: () {
        when(
          userRepository.register(
            email: invalidEmail,
            password: invalidPassword,
          ),
        ).thenAnswer((_) => Future.error(error));

        return registerBloc;
      },
      act: (registerBlock) => registerBlock.add(
          RegisterSubmitted(email: invalidEmail, password: invalidPassword)),
      expect: [
        RegisterValidateInProgress(),
        RegisterFillSuccess(error: error),
      ],
    );
  });
}
