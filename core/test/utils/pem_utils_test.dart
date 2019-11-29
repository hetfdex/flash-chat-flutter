import 'package:flash_chat_core/utils/pem_utils.dart';
import 'package:flash_chat_core/utils/rsa_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pointycastle/export.dart';

void main() {
  const publicKeyPEM =
      '-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMYfnvWtC8Id5bPKae5yXSxQTt+Zpul6AnnZWfI2TtIarvjHBFUtXRo96y7hoL4VWOPKGCsRqMFDkrbeUjRrx8iL914/srnyf6sh9c8Zk04xEOpK1ypvBz+Ks4uZObtjnnitf0NBGdjMKxveTq+VE7BWUIyQjtQ8mbDOsiLLvh7wIDAQAB\r\n-----END PUBLIC KEY-----';

  const privateKeyPREM =
      '-----BEGIN PRIVATE KEY-----\r\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDDXIUAeDtvNAJAh+tyg/xZEyZlugxRht3+Fzx1TceJsgScFhFa9CNn+6Jto+0BDXQnX8qaNDRNnqOeUSaw97VfnW/oM3GoYbdr15WxIauJhnbXSxDnajdKkYPE6s5acPmazRolJX8XNqqbptbRTb+oSZjExMMKQwZ+u1UQSTU1SfPa0OTMjsMCHksrKfJctc6DJ83828Jer9k+AkkIvmJiZq+GR3Cl/FySkqWUc7ovIeCnTLdnKeH1JmKc/Dnym/q/1tD9RKVNfTMfC5Sc12JKFSExHOC1dWyVRHcr31HiLykos2kneDJeMXkNBsanIaMDU6nR8uF5Qx42RN4um7xNAgMBAAECggEBAJy3cmY/DQaXBRt5LXIO2PcnuoyuY8Ve2GRFhZVgUKpv6OzBcyiwYlq+7LzhXHWUslIHsQJk0HRXx09wMAaUn6XVKPlvk0SNJtPW/Fk89lt7R4hLyoKpnTMvajIkXmcE6+a3k7qqyrn3e4Mjon4CzbWVXHy0jvWDcQlnA8TtxUY54+Qcat8P6oASgFfiadIzdJfB3Pp1AdEh/Px8EMfM29HbRLiBS0PnTcRZPw9A5PFeFFWKFNMdrsFpXPImuybZENXCm9AZnRDcSQMHMUHflYMnts05or0d1aKTwZ+Ql7o6vikE5hhBDsXBVTClQjL+ciCMkRXQGER79g3dHZx1ei0CgYEA/69ueTJzHzCCBaQmeJ2XnijIl3+XXUnJWNn+8JuXd6xPAAEoc7moS6nmX/0o2UvaB3zvVxbYh9sSh857fu/T524zrUMJFVNCZarC/kQO4pBcfOcvDJLsC+3r+/aa6/ltF57/m6648b20XtmIuVcM/SBTeI3ZLU0Se+LCg35KQp8CgYEAw5oUWBj90R07hiDLwFmjS6PkoGIOkmLToIgKqbFZmYAhEjCuLKR7cRihvL+E3NDSEXey5+MdG8wUICtFkMpJFSGULEyPv76BKpIUGnGw6NpG76cw3bqXWWB0aAubtdE3jlPinx0yRduKJJZ0z4OHHiMWs2AEEs1WYlLK5YSZpZMCgYACAVw6cxzYB8ddR/ZNR98ijGtWVNfZEXUUz1DijjXX6HAOLfQlRDV/smtuIUwquB+To3U1F6bHGf7BNeteCX999y1MlJQDqM2Cgp5Y5CvBtyQijqWd0aEsTsdlCIAajbA/WS3kCLDGpJg/jjE2Uup1KcW90k77vfkBI7wmz9zBPQKBgEwvWTkvEr0+O470eyfCQh4WCdiGGNLfdzoRgsWxdAqbo0XofA6bShE03NodZmxzUT7IdoBnL1FCXZxh/kh04Z4/Y+0VLPAsDTc9imL6YUNwsSxq3Fegc462SOC1lMJuaMsg1SXQQ2J+LgIuL/Ubb6dHV3IqNav1Gm5VfP2EdivNAoGAZoNeXk9xTTRFZdYQ9nO3FZdcfK7Zul0C0syhJDQxQuXmK3syFGhehIPqrFJxBe7RO0VmM4UTpDH0/UoJICxvWMhBJW4PxcNsdVhDL6ChyGWY1sawPsQ7KYdXe925k5fWXrrmlnAeIg3h0V/5+21XpllxcpSYrnm+JZtSW+uMF78=\r\n-----END PRIVATE KEY-----';

  final keyPair = generateKeyPair();

  final publicKey = keyPair.publicKey;

  final privateKey = keyPair.privateKey;

  group('pemToPublicKey', () {
    test('valid pem returns publicKey', () {
      final PublicKey publicKey = pemToPublicKey(publicKeyPEM);

      assert(publicKey is PublicKey);
      expect(publicKeyToPem(publicKey), publicKeyPEM);
    });

    test('null pem throws error', () {
      try {
        pemToPublicKey(null);
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty pem throws error', () {
      try {
        pemToPublicKey('');
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });
  });

  group('pemtoPrivateKey', () {
    test('valid pem returns privateKey', () {
      final PrivateKey privateKey = pemToPrivateKey(privateKeyPREM);

      assert(privateKey is PrivateKey);
      expect(privateKeyToPem(privateKey), privateKeyPREM);
    });

    test('null pem throws error', () {
      try {
        pemToPrivateKey(null);
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });

    test('empty pem throws error', () {
      try {
        pemToPrivateKey('');
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });
  });

  group('publicKeyToPEM', () {
    test('valid publicKey returns pem', () {
      final pem = publicKeyToPem(publicKey);

      assert(pem is String);
      expect(pemToPublicKey(pem), publicKey);
    });

    test('null publicKey throws error', () {
      try {
        publicKeyToPem(null);
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });
  });

  group('privateKeyToPEM', () {
    test('valid privateKey returns pem', () {
      final pem = privateKeyToPem(privateKey);

      assert(pem is String);
      expect(pemToPrivateKey(pem), privateKey);
    });

    test('null privateKey throws error', () {
      try {
        privateKeyToPem(null);
      } on Object catch (error) {
        assert(error is ArgumentError);
      }
    });
  });
}
