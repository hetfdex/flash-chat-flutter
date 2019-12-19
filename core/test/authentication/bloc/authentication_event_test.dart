import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/authentication/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FirebaseUserMock extends Mock implements FirebaseUser {}

void main() {
  final FirebaseUser user = FirebaseUserMock();

  group('AppStarted', () {
    test('should return correct string override', () {
      const expectedString = 'AppStarted';

      final appStarted = AppStarted();

      expect(appStarted.toString(), expectedString);
    });

    test('props returns null', () {
      final appStarted = AppStarted();

      expect(appStarted.props, null);
    });
  });

  group('UserLoggedIn', () {
    test('should return correct string override', () {
      final expectedString = 'UserLoggedIn: $user';

      final userloggedIn = UserLoggedIn(user: user);

      expect(userloggedIn.toString(), expectedString);
    });

    test('props returns user', () {
      final loginChanged = UserLoggedIn(user: user);

      expect(loginChanged.props, <Object>[user]);
    });

    group('UserLoggedOut', () {
      test('should return correct string override', () {
        const expectedString = 'UserLoggedOut';

        final userloggedOut = UserLoggedOut();

        expect(userloggedOut.toString(), expectedString);
      });

      test('props returns null', () {
        final userloggedOut = UserLoggedOut();

        expect(userloggedOut.props, null);
      });
    });
  });
}
