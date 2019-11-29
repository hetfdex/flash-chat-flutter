import 'package:flash_chat_core/views/home/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginButtonPressed', () {
    test('should return correct string override', () {
      const expectedString = 'LoginButtonPressed';

      final loginButtonPressed = LoginButtonPressed();

      expect(loginButtonPressed.toString(), expectedString);
    });

    test('props returns null', () {
      final loginButtonPressed = LoginButtonPressed();

      expect(loginButtonPressed.props, null);
    });
  });

  group('RegisterButtonPressed', () {
    test('should return correct string override', () {
      const expectedString = 'RegisterButtonPressed';

      final registerButtonPressed = RegisterButtonPressed();

      expect(registerButtonPressed.toString(), expectedString);
    });

    test('props returns null', () {
      final registerButtonPressed = RegisterButtonPressed();

      expect(registerButtonPressed.props, null);
    });
  });

  group('CancelButtonPressed', () {
    test('should return correct string override', () {
      const expectedString = 'CancelButtonPressed';

      final registerButtonPressed = CancelButtonPressed();

      expect(registerButtonPressed.toString(), expectedString);
    });

    test('props returns null', () {
      final registerButtonPressed = CancelButtonPressed();

      expect(registerButtonPressed.props, null);
    });
  });
}
