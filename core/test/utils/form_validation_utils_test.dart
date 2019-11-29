import 'package:flash_chat_core/utils/form_validation_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isValidEmail', () {
    test('valid email returns true', () {
      const String validEmail = 'test@email.com';

      final bool result = isValidEmail(validEmail);

      assert(result == true);
    });

    test('invalid email returns false', () {
      const String invalidEmail = 'test';

      final bool result = isValidEmail(invalidEmail);

      assert(result == false);
    });

    test('invalid email returns false', () {
      const String invalidEmail = 'test@test';

      final bool result = isValidEmail(invalidEmail);

      assert(result == false);
    });

    test('invalid email returns false', () {
      const String invalidEmail = '@test.com';

      final bool result = isValidEmail(invalidEmail);

      assert(result == false);
    });

    test('null email returns false', () {
      const String nullEmail = null;

      final bool result = isValidEmail(nullEmail);

      assert(result == false);
    });

    test('empty email returns false', () {
      const String emptyEmail = '';

      final bool result = isValidEmail(emptyEmail);

      assert(result == false);
    });
  });

  group('isValidPassword', () {
    test('valid password returns true', () {
      const String validPassword = 'Abcde12345@';

      final bool result = isValidPassword(validPassword);

      assert(result == true);
    });

    test('invalid password returns false', () {
      const String invalidPassword = 'abcde';

      final bool result = isValidPassword(invalidPassword);

      assert(result == false);
    });

    test('invalid password returns false', () {
      const String invalidPassword = '12345';

      final bool result = isValidPassword(invalidPassword);

      assert(result == false);
    });

    test('invalid password returns false', () {
      const String invalidPassword = '@€£!';

      final bool result = isValidPassword(invalidPassword);

      assert(result == false);
    });

    test('null password returns false', () {
      const String nullPassword = null;

      final bool result = isValidPassword(nullPassword);

      assert(result == false);
    });

    test('empty password returns false', () {
      const String emptyPassword = '';

      final bool result = isValidPassword(emptyPassword);

      assert(result == false);
    });
  });
}
