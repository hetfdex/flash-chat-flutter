import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/authentication/bloc/bloc.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

class FirebaseUserMock extends Mock implements FirebaseUser {}

void main() {
  final FirebaseUser user = FirebaseUserMock();

  UserRepository userRepository;

  AuthenticationBloc authenticationBloc;

  setUp(() async {
    userRepository = UserRepositoryMock();

    authenticationBloc = AuthenticationBloc(userRepository);
  });

  tearDown(() {
    authenticationBloc?.close();
  });

  group('constructor', () {
    test('null userRepository throws error', () {
      expect(() => AuthenticationBloc(null), throwsAssertionError);
    });
  });

  test('initial state is correct', () {
    expect(authenticationBloc.initialState, Initial());
  });

  group('AppStarted', () {
    blocTest(
      'emits [Initial, ValidateSuccess] when userRepository returns valid user',
      build: () {
        when(userRepository.user)
            .thenAnswer((_) => Future<FirebaseUser>.value(user));
        return authenticationBloc;
      },
      act: (authenticationBloc) => authenticationBloc.add(AppStarted()),
      expect: [
        Initial(),
        ValidateSuccess(),
      ],
    );
    blocTest(
      'emits [Initial, ValidateFailure] when userRepository returns null user',
      build: () {
        when(userRepository.user)
            .thenAnswer((_) => Future<FirebaseUser>.value(null));
        return authenticationBloc;
      },
      act: (authenticationBloc) => authenticationBloc.add(AppStarted()),
      expect: [
        Initial(),
        ValidateFailure(),
      ],
    );
  });

  group('LoggedIn', () {
    blocTest(
      'emits [Initial, ValidateSuccess] when userRepository returns user',
      build: () {
        when(userRepository.user)
            .thenAnswer((_) => Future<FirebaseUser>.value(user));
        return authenticationBloc;
      },
      act: (authenticationBloc) => authenticationBloc.add(LoggedIn(user)),
      expect: [
        Initial(),
        ValidateSuccess(),
      ],
    );
  });

  group('LoggedOut', () {
    blocTest(
      'emits [Initial, ValidateSuccess] when userRepository returns user',
      build: () {
        when(userRepository.user)
            .thenAnswer((_) => Future<FirebaseUser>.value(user));
        return authenticationBloc;
      },
      act: (authenticationBloc) => authenticationBloc.add(LoggedOut()),
      expect: [
        Initial(),
        ValidateFailure(),
      ],
    );
  });
}
