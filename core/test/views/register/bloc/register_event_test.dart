import 'package:flash_chat_core/views/register/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const email = 'email';
  const password = 'password';

  group('RegisterSubmitted', () {
    test('should return correct string override', () {
      const expectedString = 'RegisterSubmitted';

      final registerSubmitted =
          RegisterSubmitted(email: email, password: password);

      expect(registerSubmitted.toString(), expectedString);
    });

    test('props returns email and password', () {
      final registerSubmitted =
          RegisterSubmitted(email: email, password: password);

      expect(registerSubmitted.props, <Object>[email, password]);
    });
  });

  group('RegisterChanged', () {
    test('should return correct string override', () {
      const expectedString = 'RegisterChanged';

      final registerChanged = RegisterChanged(email: email, password: password);

      expect(registerChanged.toString(), expectedString);
    });

    test('props returns email and password', () {
      final registerChanged = RegisterChanged(email: email, password: password);

      expect(registerChanged.props, <Object>[email, password]);
    });
  });
}
