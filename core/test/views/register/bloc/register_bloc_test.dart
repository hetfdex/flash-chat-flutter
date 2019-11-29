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
  const String emptyField = '';
  const String invalidEmail = 'email';
  const String validEmail = 'email@email.com';
  const String invalidPassword = 'password';
  const String validPassword = 'Abcde12345@';

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
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null athenticationBloc throws error', () {
      try {
        RegisterBloc(userRepository, null);
      } catch (error) {
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
      final List<RegisterState> expectedResponse = <RegisterState>[
        RegisterInitial(),
        RegisterFillInProgress(),
      ];

      expectLater(
        registerBloc.state,
        emitsInOrder(expectedResponse),
      );

      registerBloc.dispatch(RegisterChanged(emptyField, emptyField));
    });

    test('emits [RegisterInitial, RegisterFillInProgress] when email is empty',
        () {
      final List<RegisterState> expectedResponse = <RegisterState>[
        RegisterInitial(),
        RegisterFillInProgress(),
      ];

      expectLater(
        registerBloc.state,
        emitsInOrder(expectedResponse),
      );

      registerBloc.dispatch(RegisterChanged(emptyField, invalidPassword));
    });

    test(
        'emits [RegisterInitial, RegisterFillInProgress] when password is empty',
        () {
      final List<RegisterState> expectedResponse = <RegisterState>[
        RegisterInitial(),
        RegisterFillInProgress(),
      ];

      expectLater(
        registerBloc.state,
        emitsInOrder(expectedResponse),
      );

      registerBloc.dispatch(RegisterChanged(invalidEmail, emptyField));
    });

    test(
        'emits [RegisterInitial, RegisterFillInProgress] when email is invalid',
        () {
      final List<RegisterState> expectedResponse = <RegisterState>[
        RegisterInitial(),
        RegisterFillInProgress(),
      ];

      expectLater(
        registerBloc.state,
        emitsInOrder(expectedResponse),
      );

      registerBloc.dispatch(RegisterChanged(invalidEmail, validPassword));
    });

    test(
        'emits [RegisterInitial, RegisterFillInProgress] when password is invalid',
        () {
      final List<RegisterState> expectedResponse = <RegisterState>[
        RegisterInitial(),
        RegisterFillInProgress(),
      ];

      expectLater(
        registerBloc.state,
        emitsInOrder(expectedResponse),
      );

      registerBloc.dispatch(RegisterChanged(validEmail, invalidPassword));
    });

    test(
        'emits [RegisterInitial, RegisterFillSuccess] when email and password are valid',
        () {
      final List<RegisterState> expectedResponse = <RegisterState>[
        RegisterInitial(),
        RegisterFillSuccess(),
      ];

      expectLater(
        registerBloc.state,
        emitsInOrder(expectedResponse),
      );

      registerBloc.dispatch(RegisterChanged(validEmail, validPassword));
    });
  });

  group('const RegisterSubmitted', () {
    test(
        'emits [RegisterInitial, RegisterValidateInProgress, RegisterInitial] when email and password are valid',
        () {
      final List<RegisterState> expectedResponse = <RegisterState>[
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
        verify(authenticationBloc.dispatch(LoggedIn(firebaseUser))).called(1);
      });

      registerBloc.dispatch(RegisterSubmitted(
        validEmail,
        validPassword,
      ));
    });
  });
}
