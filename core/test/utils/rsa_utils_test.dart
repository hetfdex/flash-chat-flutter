import 'package:flash_chat_core/utils/rsa_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pointycastle/export.dart';

void main() {
  const message = 'message';

  AsymmetricKeyPair<PublicKey, PrivateKey> keyPair;

  String encryptedMessage;

  group('generateKeyPair', () {
    test('generates valid keyPair', () {
      keyPair = generateKeyPair();

      assert(keyPair is AsymmetricKeyPair<PublicKey, PrivateKey>);
      expect(keyPair, isNotNull);
      assert(keyPair.publicKey is RSAPublicKey);
      expect(keyPair.publicKey, isNotNull);
      assert(keyPair.privateKey is RSAPrivateKey);
      expect(keyPair.privateKey, isNotNull);
    });
  });

  group('encryptMessage', () {
    test('valid message and privateKey encrypts message', () {
      encryptedMessage = encryptMessage(message, keyPair.privateKey);

      assert(encryptedMessage is String);
      expect(decryptMessage(encryptedMessage, keyPair.publicKey), isNotNull);
    });

    test('null message throws error', () {
      try {
        encryptedMessage = encryptMessage(null, keyPair.privateKey);
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty message throws error', () {
      try {
        encryptedMessage = encryptMessage('', keyPair.privateKey);
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('null privateKey throws error', () {
      try {
        encryptedMessage = encryptMessage(message, null);
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });
  });

  group('decryptMessage', () {
    test('valid message and publicKey decrypts message', () {
      final result = decryptMessage(encryptedMessage, keyPair.publicKey);

      assert(result is String);
      expect(result, message);
    });

    test('null message throws error', () {
      try {
        encryptedMessage = decryptMessage(null, keyPair.publicKey);
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty message throws error', () {
      try {
        encryptedMessage = decryptMessage('', keyPair.publicKey);
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('null privateKey throws error', () {
      try {
        encryptedMessage = decryptMessage(message, null);
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });
  });
}
