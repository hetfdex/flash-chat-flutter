import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/random/fortuna_random.dart';

String encryptMessage(String message, RSAPrivateKey privateKey) {
  if (message == null || message == '') {
    throw ArgumentError('message must not be null or empty');
  }

  if (privateKey == null) {
    throw ArgumentError('privateKey must not be null or empty');
  }

  final RSAEngine rsaEngine = RSAEngine();

  rsaEngine.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));

  final Uint8List encryptedMessage =
      rsaEngine.process(Uint8List.fromList(message.codeUnits));

  return String.fromCharCodes(encryptedMessage);
}

String decryptMessage(String message, RSAPublicKey publicKey) {
  if (message == null || message == '') {
    throw ArgumentError('message must not be null or empty');
  }

  if (publicKey == null) {
    throw ArgumentError('publicKey must not be null or empty');
  }

  final RSAEngine rsaEngine = RSAEngine();

  rsaEngine.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));

  final Uint8List decryptedMessage =
      rsaEngine.process(Uint8List.fromList(message.codeUnits));

  return String.fromCharCodes(decryptedMessage);
}

AsymmetricKeyPair<PublicKey, PrivateKey> generateKeyPair() {
  return _generateKeyPair(_getSecureRandom());
}

AsymmetricKeyPair<PublicKey, PrivateKey> _generateKeyPair(
    SecureRandom secureRandom) {
  final RSAKeyGeneratorParameters rsaKeyGeneratorParameters =
      RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 5);

  final ParametersWithRandom<CipherParameters> parametersWithRandom =
      ParametersWithRandom<CipherParameters>(
          rsaKeyGeneratorParameters, secureRandom);

  final RSAKeyGenerator rsaKeyGenerator = RSAKeyGenerator();

  rsaKeyGenerator.init(parametersWithRandom);

  return rsaKeyGenerator.generateKeyPair();
}

SecureRandom _getSecureRandom() {
  final FortunaRandom fortunaRandom = FortunaRandom();

  final Random random = Random.secure();

  final List<int> seeds = <int>[];

  for (int i = 0; i < 32; i++) {
    seeds.add(random.nextInt(255));
  }

  fortunaRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

  return fortunaRandom;
}
