import 'package:flash_chat_core/views/login/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const email = 'email';
  const password = 'password';

  group('LoginSubmitted', () {
    test('should return correct string override', () {
      const expectedString = 'LoginSubmitted';

      final loginSubmitted = LoginSubmitted(email, password);

      expect(loginSubmitted.toString(), expectedString);
    });

    test('props returns email and password', () {
      final loginSubmitted = LoginSubmitted(email, password);

      expect(loginSubmitted.props, <Object>[email, password]);
    });
  });

  group('LoginChanged', () {
    test('should return correct string override', () {
      const expectedString = 'LoginChanged';

      final loginChanged = LoginChanged(email, password);

      expect(loginChanged.toString(), expectedString);
    });

    test('props returns email and password', () {
      final loginChanged = LoginChanged(email, password);

      expect(loginChanged.props, <Object>[email, password]);
    });
  });
}
