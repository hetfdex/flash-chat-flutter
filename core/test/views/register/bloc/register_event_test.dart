import 'package:flash_chat_core/views/register/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String email = 'email';
  const String password = 'password';

  group('RegisterSubmitted', () {
    test('should return correct string override', () {
      const String expectedString = 'RegisterSubmitted';

      final RegisterSubmitted registerSubmitted =
          RegisterSubmitted(email, password);

      expect(registerSubmitted.toString(), expectedString);
    });

    test('props returns email and password', () {
      final RegisterSubmitted registerSubmitted =
          RegisterSubmitted(email, password);

      expect(registerSubmitted.props, <Object>[email, password]);
    });
  });

  group('RegisterChanged', () {
    test('should return correct string override', () {
      const String expectedString = 'RegisterChanged';

      final RegisterChanged registerChanged = RegisterChanged(email, password);

      expect(registerChanged.toString(), expectedString);
    });

    test('props returns email and password', () {
      final RegisterChanged registerChanged = RegisterChanged(email, password);

      expect(registerChanged.props, <Object>[email, password]);
    });
  });
}
