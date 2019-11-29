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

  group('LoggedIn', () {
    test('should return correct string override', () {
      final expectedString = 'LoggedIn: $user';

      final loggedIn = LoggedIn(user);

      expect(loggedIn.toString(), expectedString);
    });

    test('props returns user', () {
      final loginChanged = LoggedIn(user);

      expect(loginChanged.props, <Object>[user]);
    });

    group('LoggedOut', () {
      test('should return correct string override', () {
        const expectedString = 'LoggedOut';

        final loggedOut = LoggedOut();

        expect(loggedOut.toString(), expectedString);
      });

      test('props returns null', () {
        final loggedOut = LoggedOut();

        expect(loggedOut.props, null);
      });
    });
  });
}
