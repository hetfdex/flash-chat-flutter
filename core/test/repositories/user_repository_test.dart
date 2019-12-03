import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/repositories/user_repository.dart';
import 'package:flash_chat_core/utils/secure_storage_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class SecureStorageUtilsMock extends Mock implements SecureStorageUtils {}

class FirebaseUserMock extends Mock implements FirebaseUser {}

class AuthResultMock extends Mock implements AuthResult {}

void main() {
  const email = 'email';
  const password = 'password';
  const exception = 'exception';

  final e = Exception('exception');

  FirebaseAuth firebaseAuth;

  SecureStorageUtils secureStorageUtils;

  FirebaseUser user;

  AuthResult authResult;

  UserRepository userRepository;

  setUp(() {
    firebaseAuth = FirebaseAuthMock();

    secureStorageUtils = SecureStorageUtilsMock();

    user = FirebaseUserMock();

    authResult = AuthResultMock();

    userRepository = UserRepository(firebaseAuth, secureStorageUtils);

    when(firebaseAuth.currentUser())
        .thenAnswer((_) => Future<FirebaseUser>.value(user));

    when(authResult.user).thenReturn(user);

    when(firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: anyNamed(password)))
        .thenAnswer((_) => Future<AuthResult>.value(authResult));

    when(firebaseAuth.createUserWithEmailAndPassword(
            email: exception, password: anyNamed(password)))
        .thenThrow(e);

    when(firebaseAuth.signInWithEmailAndPassword(
            email: email, password: anyNamed(password)))
        .thenAnswer((_) => Future<AuthResult>.value(authResult));

    when(firebaseAuth.signInWithEmailAndPassword(
            email: exception, password: anyNamed(password)))
        .thenThrow(e);
  });

  group('constructor', () {
    test('null firebaseAuth throws error', () {
      expect(
          () => UserRepository(null, secureStorageUtils), throwsAssertionError);
    });

    test('null secureStorageUtils throws error', () {
      expect(() => UserRepository(firebaseAuth, null), throwsAssertionError);
    });
  });

  group('user', () {
    test('returns user', () async {
      final result = await userRepository.user;

      expect(result, user);
    });
  });

  group('register', () {
    test('null email throws error', () async {
      expect(
          () async =>
              await userRepository.register(email: null, password: password),
          throwsArgumentError);
    });

    test('empty email throws error', () async {
      expect(
          () async =>
              await userRepository.register(email: '', password: password),
          throwsArgumentError);
    });

    test('null password throws error', () async {
      expect(
          () async =>
              await userRepository.register(email: email, password: null),
          throwsArgumentError);
    });

    test('empty password throws error', () async {
      expect(
          () async => await userRepository.register(email: email, password: ''),
          throwsArgumentError);
    });

    test('returns user', () async {
      final result =
          await userRepository.register(email: email, password: password);

      expect(result, user);
    });

    test('throws exception', () async {
      expect(
          () async => await userRepository.register(
              email: exception, password: exception),
          throwsException);
    });
  });

  group('login', () {
    test('null email throws error', () async {
      expect(
          () async =>
              await userRepository.login(email: null, password: password),
          throwsArgumentError);
    });

    test('empty email throws error', () async {
      expect(
          () async => await userRepository.login(email: '', password: password),
          throwsArgumentError);
    });

    test('null password throws error', () async {
      expect(
          () async => await userRepository.login(email: email, password: null),
          throwsArgumentError);
    });

    test('empty password throws error', () async {
      expect(() async => await userRepository.login(email: email, password: ''),
          throwsArgumentError);
    });

    test('returns user', () async {
      final result =
          await userRepository.login(email: email, password: password);

      expect(result, user);
    });

    test('throws exception', () async {
      expect(
          () async =>
              await userRepository.login(email: exception, password: exception),
          throwsException);
    });
  });

  group('logout', () {
    test('logs out', () async {
      await userRepository.logout();

      verify(firebaseAuth.signOut()).called(1);
    });

    test('throws exception', () async {
      when(firebaseAuth.signOut()).thenThrow(e);

      expect(() async => await userRepository.logout(), throwsException);
    });
  });
}
