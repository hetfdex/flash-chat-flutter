import 'package:dbcrypt/dbcrypt.dart';
import 'package:flash_chat_core/utils/hash_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const password = 'password';

  group('encryptPassword', () {
    test('valid password and salt encrypts password', () {
      final salt = DBCrypt().gensalt();

      final result = encryptPassword(password, salt);

      assert(result is String);
      expect(DBCrypt().checkpw(password, result), true);
    });

    test('valid password and null salt encrypts password', () {
      final result = encryptPassword(password, null);

      assert(result is String);
      expect(DBCrypt().checkpw(password, result), true);
    });

    test('valid password and empty salt encrypts password', () {
      final result = encryptPassword(password, '');

      assert(result is String);
      expect(DBCrypt().checkpw(password, result), true);
    });

    test('null password throws error', () {
      try {
        final salt = DBCrypt().gensalt();

        encryptPassword(null, salt);
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty password throws error', () {
      try {
        final salt = DBCrypt().gensalt();

        encryptPassword('', salt);
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });
  });
}
