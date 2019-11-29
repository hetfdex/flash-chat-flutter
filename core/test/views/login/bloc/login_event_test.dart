import 'package:flash_chat_core/views/login/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String email = 'email';
  const String password = 'password';

  group('LoginSubmitted', () {
    test('should return correct string override', () {
      const String expectedString = 'LoginSubmitted';

      final LoginSubmitted loginSubmitted = LoginSubmitted(email, password);

      expect(loginSubmitted.toString(), expectedString);
    });

    test('props returns email and password', () {
      final LoginSubmitted loginSubmitted = LoginSubmitted(email, password);

      expect(loginSubmitted.props, <Object>[email, password]);
    });
  });

  group('LoginChanged', () {
    test('should return correct string override', () {
      const String expectedString = 'LoginChanged';

      final LoginChanged loginChanged = LoginChanged(email, password);

      expect(loginChanged.toString(), expectedString);
    });

    test('props returns email and password', () {
      final LoginChanged loginChanged = LoginChanged(email, password);

      expect(loginChanged.props, <Object>[email, password]);
    });
  });
}
