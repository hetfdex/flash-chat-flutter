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
  const String email = 'email';
  const String password = 'password';
  const String exception = 'exception';

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
        .thenThrow(Error());

    when(firebaseAuth.signInWithEmailAndPassword(
            email: email, password: anyNamed(password)))
        .thenAnswer((_) => Future<AuthResult>.value(authResult));

    when(firebaseAuth.signInWithEmailAndPassword(
            email: exception, password: anyNamed(password)))
        .thenThrow(Error());
  });

  group('constructor', () {
    test('null firebaseAuth throws error', () {
      try {
        UserRepository(null, secureStorageUtils);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null secureStorageUtils throws error', () {
      try {
        UserRepository(firebaseAuth, null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null firebaseAuth throws error', () {
      final UserRepository userRepository =
          UserRepository(firebaseAuth, secureStorageUtils);

      expect(userRepository, isNotNull);
    });
  });

  group('user', () {
    test('returns user', () async {
      final FirebaseUser result = await userRepository.user;

      expect(result, user);
    });
  });

  group('register', () {
    test('returns user', () async {
      final FirebaseUser result =
          await userRepository.register(email, password);

      expect(result, user);
    });

    test('throws error', () async {
      try {
        await userRepository.register(exception, password);
      } catch (error) {
        expect(error, startsWith('User Register Failed:'));
      }
    });
  });

  group('login', () {
    test('returns user', () async {
      final FirebaseUser result = await userRepository.login(email, password);

      expect(result, user);
    });

    test('throws error', () async {
      try {
        await userRepository.login(exception, password);
      } catch (error) {
        expect(error, startsWith('User Login Failed:'));
      }
    });
  });

  group('logout', () {
    test('logs out', () async {
      await userRepository.logout();

      verify(firebaseAuth.signOut()).called(1);
    });

    test('throws error', () async {
      when(firebaseAuth.signOut()).thenThrow(Error());

      try {
        await userRepository.logout();
      } catch (error) {
        expect(error, startsWith('User Logout Failed:'));
      }
    });
  });
}
