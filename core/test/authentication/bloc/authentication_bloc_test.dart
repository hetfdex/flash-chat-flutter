import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/authentication/bloc/bloc.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

class FirebaseUserMock extends Mock implements FirebaseUser {}

void main() {
  final FirebaseUser user = FirebaseUserMock();

  UserRepository userRepository;

  AuthenticationBloc authenticationBloc;

  setUp(() async {
    userRepository = MockUserRepository();

    authenticationBloc = AuthenticationBloc(userRepository);
  });

  group('constructor', () {
    test('null userRepository throws error', () {
      try {
        AuthenticationBloc(null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  test('initial state is correct', () {
    expect(authenticationBloc.initialState, Initial());
  });

  group('AppStarted', () {
    test(
        'emits [Initial, ValidateSuccess] when UserRepository returns valid user',
        () {
      final List<AuthenticationState> expectedResponse = <AuthenticationState>[
        Initial(),
        ValidateSuccess(),
      ];

      when(userRepository.user)
          .thenAnswer((_) => Future<FirebaseUser>.value(user));

      expectLater(
        authenticationBloc.state,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.dispatch(AppStarted());
    });

    test(
        'emits [Initial, ValidateFailure] when userRepository returns null user',
        () {
      final List<AuthenticationState> expectedResponse = <AuthenticationState>[
        Initial(),
        ValidateFailure(),
      ];

      when(userRepository.user)
          .thenAnswer((_) => Future<FirebaseUser>.value(null));

      expectLater(
        authenticationBloc.state,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.dispatch(AppStarted());
    });
  });

  group('LoggedIn', () {
    test('emits [Initial, ValidateSuccess] when userRepository returns user',
        () {
      final List<AuthenticationState> expectedResponse = <AuthenticationState>[
        Initial(),
        ValidateSuccess(),
      ];

      when(userRepository.user)
          .thenAnswer((_) => Future<FirebaseUser>.value(user));

      expectLater(
        authenticationBloc.state,
        emitsInOrder(expectedResponse),
      );
      authenticationBloc.dispatch(LoggedIn(user));
    });
  });

  group('LoggedOut', () {
    test('emits [Initial, ValidateFailure] when logout request is successful',
        () {
      final List<AuthenticationState> expectedResponse = <AuthenticationState>[
        Initial(),
        ValidateFailure(),
      ];

      expectLater(
        authenticationBloc.state,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.dispatch(LoggedOut());
    });
  });
}
