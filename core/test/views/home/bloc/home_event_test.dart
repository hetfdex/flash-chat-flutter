import 'package:flash_chat_core/views/home/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginButtonPressed', () {
    test('should return correct string override', () {
      const String expectedString = 'LoginButtonPressed';

      final LoginButtonPressed loginButtonPressed = LoginButtonPressed();

      expect(loginButtonPressed.toString(), expectedString);
    });

    test('props returns null', () {
      final LoginButtonPressed loginButtonPressed = LoginButtonPressed();

      expect(loginButtonPressed.props, null);
    });
  });

  group('RegisterButtonPressed', () {
    test('should return correct string override', () {
      const String expectedString = 'RegisterButtonPressed';

      final RegisterButtonPressed registerButtonPressed =
          RegisterButtonPressed();

      expect(registerButtonPressed.toString(), expectedString);
    });

    test('props returns null', () {
      final RegisterButtonPressed registerButtonPressed =
          RegisterButtonPressed();

      expect(registerButtonPressed.props, null);
    });
  });

  group('CancelButtonPressed', () {
    test('should return correct string override', () {
      const String expectedString = 'CancelButtonPressed';

      final CancelButtonPressed registerButtonPressed = CancelButtonPressed();

      expect(registerButtonPressed.toString(), expectedString);
    });

    test('props returns null', () {
      final CancelButtonPressed registerButtonPressed = CancelButtonPressed();

      expect(registerButtonPressed.props, null);
    });
  });
}
