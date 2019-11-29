import 'package:flash_chat_core/utils/secure_storage_utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFlutterStorage extends Mock implements FlutterSecureStorage {}

void main() {
  const String salt = 'salt';
  const String email = 'email';
  const String publicKey = 'publicKey';
  const String privateKey = 'privateKey';

  final FlutterSecureStorage _flutterSecureStorage = MockFlutterStorage();

  final SecureStorageUtils _secureStorageUtils =
      SecureStorageUtils(_flutterSecureStorage);

  when(_flutterSecureStorage.read(key: 'flash-chat-salt-email'))
      .thenAnswer((_) => Future<String>.value(salt));

  when(_flutterSecureStorage.read(key: 'flash-chat-pub-key-email'))
      .thenAnswer((_) => Future<String>.value(publicKey));

  when(_flutterSecureStorage.read(key: 'flash-chat-priv-key-email'))
      .thenAnswer((_) => Future<String>.value(privateKey));

  group('constructor', () {
    test('constructs valid instance if given storage is not null', () {
      final SecureStorageUtils secureStorageUtils =
          SecureStorageUtils(_flutterSecureStorage);

      assert(secureStorageUtils is SecureStorageUtils);
      expect(secureStorageUtils, isNotNull);
    });

    test('constructs invalid instance if given storage is null', () {
      try {
        SecureStorageUtils(null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  group('getSalt', () {
    test('valid email gets salt', () async {
      final String result = await _secureStorageUtils.getSalt(email);

      expect(result, salt);
    });

    test('null email throws error', () async {
      try {
        await _secureStorageUtils.getSalt(null);
      } catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty email throws error', () async {
      try {
        await _secureStorageUtils.getSalt('');
      } catch (error) {
        assert(error is ArgumentError);
      }
    });
  });

  group('setSalt', () {
    test('valid email and salt sets salt', () async {
      await _secureStorageUtils.setSalt(salt, email);

      verify(_flutterSecureStorage.write(
          key: 'flash-chat-salt-email', value: salt));
    });

    test('null email throws error', () async {
      try {
        await _secureStorageUtils.setSalt(salt, null);
      } catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty email throws error', () async {
      try {
        await _secureStorageUtils.setSalt(salt, '');
      } catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('null salt throws error', () async {
      try {
        await _secureStorageUtils.setSalt(null, email);
      } catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty salt throws error', () async {
      try {
        await _secureStorageUtils.setSalt('', email);
      } catch (error) {
        assert(error is ArgumentError);
      }
    });
  });

  group('getPublicKey', () {
    test('valid email gets publicKey', () async {
      final String publicKey = await _secureStorageUtils.getPublicKey(email);

      expect(publicKey, publicKey);
    });

    test('null email throws error', () async {
      try {
        await _secureStorageUtils.getPublicKey(null);
      } catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty email throws error', () async {
      try {
        await _secureStorageUtils.getPublicKey('');
      } catch (error) {
        assert(error is ArgumentError);
      }
    });
  });

  group('getPrivateKey', () {
    test('valid email gets privateKey', () async {
      final String privateKey = await _secureStorageUtils.getPrivateKey(email);

      expect(privateKey, privateKey);
    });

    test('null email throws error', () async {
      try {
        await _secureStorageUtils.getPrivateKey(null);
      } catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty email throws error', () async {
      try {
        await _secureStorageUtils.getPrivateKey('');
      } catch (error) {
        assert(error is ArgumentError);
      }
    });
  });

  group('setKeyPair', () {
    test('valid email, publicKey and privateKey sets keyPair', () async {
      await _secureStorageUtils.setKeyPair(publicKey, privateKey, email);

      verify(_flutterSecureStorage.write(
          key: 'flash-chat-pub-key-email', value: publicKey));

      verify(_flutterSecureStorage.write(
          key: 'flash-chat-priv-key-email', value: privateKey));
    });

    test('null publicKey throws error', () async {
      try {
        await _secureStorageUtils.setKeyPair(null, privateKey, email);
      } catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty publicKey throws error', () async {
      try {
        await _secureStorageUtils.setKeyPair('', privateKey, email);
      } catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('null privateKey throws error', () async {
      try {
        await _secureStorageUtils.setKeyPair(publicKey, null, email);
      } catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty privateKey throws error', () async {
      try {
        await _secureStorageUtils.setKeyPair(publicKey, '', email);
      } catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('null email throws error', () async {
      try {
        await _secureStorageUtils.setKeyPair(publicKey, privateKey, null);
      } catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty email throws error', () async {
      try {
        await _secureStorageUtils.setKeyPair(publicKey, privateKey, '');
      } catch (error) {
        assert(error is ArgumentError);
      }
    });
  });
}
