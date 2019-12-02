import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/random/fortuna_random.dart';

/// Encrypts a given message using an rsa private key
String encryptMessage(String message, RSAPrivateKey privateKey) {
  if (message == null || message == '') {
    throw ArgumentError('message must not be null or empty');
  }

  if (privateKey == null) {
    throw ArgumentError('privateKey must not be null or empty');
  }

  final rsaEngine = RSAEngine();

  rsaEngine.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));

  final encryptedMessage =
      rsaEngine.process(Uint8List.fromList(message.codeUnits));

  return String.fromCharCodes(encryptedMessage);
}

/// Decrypts a given message using an rsa public key
String decryptMessage(String message, RSAPublicKey publicKey) {
  if (message == null || message == '') {
    throw ArgumentError('message must not be null or empty');
  }

  if (publicKey == null) {
    throw ArgumentError('publicKey must not be null or empty');
  }

  final rsaEngine = RSAEngine();

  rsaEngine.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));

  final decryptedMessage =
      rsaEngine.process(Uint8List.fromList(message.codeUnits));

  return String.fromCharCodes(decryptedMessage);
}

/// Generates an asymmetric key pair
AsymmetricKeyPair<PublicKey, PrivateKey> generateKeyPair() {
  return _generateKeyPair(_getSecureRandom());
}

AsymmetricKeyPair<PublicKey, PrivateKey> _generateKeyPair(
    SecureRandom secureRandom) {
  final rsaKeyGeneratorParameters =
      RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 5);

  final parametersWithRandom = ParametersWithRandom<CipherParameters>(
      rsaKeyGeneratorParameters, secureRandom);

  final rsaKeyGenerator = RSAKeyGenerator();

  rsaKeyGenerator.init(parametersWithRandom);

  return rsaKeyGenerator.generateKeyPair();
}

SecureRandom _getSecureRandom() {
  final fortunaRandom = FortunaRandom();

  final random = Random.secure();

  final seeds = <int>[];

  for (var i = 0; i < 32; i++) {
    seeds.add(random.nextInt(255));
  }

  fortunaRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

  return fortunaRandom;
}
