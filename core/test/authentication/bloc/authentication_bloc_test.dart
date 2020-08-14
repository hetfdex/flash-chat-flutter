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

  test('AuthenticationInitial state is correct', () {
    expect(authenticationBloc.state, AuthenticationInitial());
  });

  group('AppStarted', () {
    blocTest(
      'emits [AuthenticationInitial, AuthenticationSuccess] when userRepository returns valid user',
      build: () {
        when(userRepository.user)
            .thenAnswer((_) => Future<FirebaseUser>.value(user));
        return authenticationBloc;
      },
      act: (authenticationBloc) => authenticationBloc.add(AppStarted()),
      expect: [
        AuthenticationInitial(),
        AuthenticationSuccess(),
      ],
    );
    blocTest(
      'emits [AuthenticationInitial, AuthenticationFailure] when userRepository returns null user',
      build: () {
        when(userRepository.user)
            .thenAnswer((_) => Future<FirebaseUser>.value(null));
        return authenticationBloc;
      },
      act: (authenticationBloc) => authenticationBloc.add(AppStarted()),
      expect: [
        AuthenticationInitial(),
        AuthenticationFailure(),
      ],
    );
  });

  group('UserLoggedIn', () {
    blocTest(
      'emits [AuthenticationInitial, AuthenticationSuccess] when userRepository returns user',
      build: () {
        when(userRepository.user)
            .thenAnswer((_) => Future<FirebaseUser>.value(user));
        return authenticationBloc;
      },
      act: (authenticationBloc) =>
          authenticationBloc.add(UserLoggedIn(user: user)),
      expect: [
        AuthenticationInitial(),
        AuthenticationSuccess(),
      ],
    );
  });

  group('UserLoggedOut', () {
    blocTest(
      'emits [AuthenticationInitial] when userRepository returns user',
      build: () {
        return authenticationBloc;
      },
      act: (authenticationBloc) => authenticationBloc.add(UserLoggedOut()),
      expect: [AuthenticationInitial()],
    );
  });
}
