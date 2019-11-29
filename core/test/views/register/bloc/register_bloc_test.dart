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

  group('constructor', () {
    test('null userRepository throws error', () {
      try {
        RegisterBloc(null, authenticationBloc);
      } on Object catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null athenticationBloc throws error', () {
      try {
        RegisterBloc(userRepository, null);
      } on Object catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  test('initial state is correct', () {
    expect(registerBloc.initialState, RegisterInitial());
  });

  group('RegisterChanged', () {
    test(
        'emits [RegisterInitial, RegisterFillInProgress] when email and password are empty',
        () {
      final expectedResponse = <RegisterState>[
        RegisterInitial(),
        RegisterFillInProgress(),
      ];

      expectLater(
        registerBloc.state,
        emitsInOrder(expectedResponse),
      );

      registerBloc.add(RegisterChanged(emptyField, emptyField));
    });

    test('emits [RegisterInitial, RegisterFillInProgress] when email is empty',
        () {
      final expectedResponse = <RegisterState>[
        RegisterInitial(),
        RegisterFillInProgress(),
      ];

      expectLater(
        registerBloc.state,
        emitsInOrder(expectedResponse),
      );

      registerBloc.add(RegisterChanged(emptyField, invalidPassword));
    });

    test(
        'emits [RegisterInitial, RegisterFillInProgress] when password is empty',
        () {
      final expectedResponse = <RegisterState>[
        RegisterInitial(),
        RegisterFillInProgress(),
      ];

      expectLater(
        registerBloc.state,
        emitsInOrder(expectedResponse),
      );

      registerBloc.add(RegisterChanged(invalidEmail, emptyField));
    });

    test(
        'emits [RegisterInitial, RegisterFillInProgress] when email is invalid',
        () {
      final expectedResponse = <RegisterState>[
        RegisterInitial(),
        RegisterFillInProgress(),
      ];

      expectLater(
        registerBloc.state,
        emitsInOrder(expectedResponse),
      );

      registerBloc.add(RegisterChanged(invalidEmail, validPassword));
    });

    test(
        'emits [RegisterInitial, RegisterFillInProgress] when password is invalid',
        () {
      final expectedResponse = <RegisterState>[
        RegisterInitial(),
        RegisterFillInProgress(),
      ];

      expectLater(
        registerBloc.state,
        emitsInOrder(expectedResponse),
      );

      registerBloc.add(RegisterChanged(validEmail, invalidPassword));
    });

    test(
        'emits [RegisterInitial, RegisterFillSuccess] when email and password are valid',
        () {
      final expectedResponse = <RegisterState>[
        RegisterInitial(),
        RegisterFillSuccess(),
      ];

      expectLater(
        registerBloc.state,
        emitsInOrder(expectedResponse),
      );

      registerBloc.add(RegisterChanged(validEmail, validPassword));
    });
  });

  group('const RegisterSubmitted', () {
    test(
        'emits [RegisterInitial, RegisterValidateInProgress, RegisterInitial] when email and password are valid',
        () {
      final expectedResponse = <RegisterState>[
        RegisterInitial(),
        RegisterValidateInProgress(),
        RegisterInitial(),
      ];

      when(
        userRepository.register(
          validEmail,
          validPassword,
        ),
      ).thenAnswer((_) => Future<FirebaseUser>.value(firebaseUser));

      expectLater(
        registerBloc.state,
        emitsInOrder(expectedResponse),
      ).then((_) {
        verify(authenticationBloc.add(LoggedIn(firebaseUser))).called(1);
      });

      registerBloc.add(RegisterSubmitted(
        validEmail,
        validPassword,
      ));
    });
  });
}
