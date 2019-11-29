import 'package:dbcrypt/dbcrypt.dart';
import 'package:flash_chat_core/utils/hash_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String password = 'password';

  group('encryptPassword', () {
    test('valid password and salt encrypts password', () {
      final String salt = DBCrypt().gensalt();

      final String result = encryptPassword(password, salt);

      assert(result is String);
      expect(DBCrypt().checkpw(password, result), true);
    });

    test('valid password and null salt encrypts password', () {
      final String result = encryptPassword(password, null);

      assert(result is String);
      expect(DBCrypt().checkpw(password, result), true);
    });

    test('valid password and empty salt encrypts password', () {
      final String result = encryptPassword(password, '');

      assert(result is String);
      expect(DBCrypt().checkpw(password, result), true);
    });

    test('null password throws error', () {
      try {
        final String salt = DBCrypt().gensalt();

        encryptPassword(null, salt);
      } catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty password throws error', () {
      try {
        final String salt = DBCrypt().gensalt();

        encryptPassword('', salt);
      } catch (error) {
        assert(error is ArgumentError);
      }
    });
  });
}
