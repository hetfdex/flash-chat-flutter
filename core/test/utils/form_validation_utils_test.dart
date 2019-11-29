import 'package:flash_chat_core/utils/form_validation_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isValidEmail', () {
    test('valid email returns true', () {
      const validEmail = 'test@email.com';

      final result = isValidEmail(validEmail);

      assert(result == true);
    });

    test('invalid email returns false', () {
      const invalidEmail = 'test';

      final result = isValidEmail(invalidEmail);

      assert(result == false);
    });

    test('invalid email returns false', () {
      const invalidEmail = 'test@test';

      final result = isValidEmail(invalidEmail);

      assert(result == false);
    });

    test('invalid email returns false', () {
      const invalidEmail = '@test.com';

      final result = isValidEmail(invalidEmail);

      assert(result == false);
    });

    test('null email returns false', () {
      const String nullEmail = null;

      final result = isValidEmail(nullEmail);

      assert(result == false);
    });

    test('empty email returns false', () {
      const emptyEmail = '';

      final result = isValidEmail(emptyEmail);

      assert(result == false);
    });
  });

  group('isValidPassword', () {
    test('valid password returns true', () {
      const validPassword = 'Abcde12345@';

      final result = isValidPassword(validPassword);

      assert(result == true);
    });

    test('invalid password returns false', () {
      const invalidPassword = 'abcde';

      final result = isValidPassword(invalidPassword);

      assert(result == false);
    });

    test('invalid password returns false', () {
      const invalidPassword = '12345';

      final result = isValidPassword(invalidPassword);

      assert(result == false);
    });

    test('invalid password returns false', () {
      const invalidPassword = '@€£!';

      final result = isValidPassword(invalidPassword);

      assert(result == false);
    });

    test('null password returns false', () {
      const String nullPassword = null;

      final result = isValidPassword(nullPassword);

      assert(result == false);
    });

    test('empty password returns false', () {
      const emptyPassword = '';

      final result = isValidPassword(emptyPassword);

      assert(result == false);
    });
  });
}
