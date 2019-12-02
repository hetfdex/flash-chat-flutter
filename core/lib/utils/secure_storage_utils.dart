import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// The secure storage utils
class SecureStorageUtils {
  /// Construcs the secure storage utils
  SecureStorageUtils(this._flutterSecureStorage)
      : assert(_flutterSecureStorage != null);

  final FlutterSecureStorage _flutterSecureStorage;

  /// Returns the salt for a given email
  Future<String> getSalt(String email) async {
    if (email == null || email == '') {
      throw ArgumentError('email must not be null or empty');
    }
    return await _flutterSecureStorage.read(key: 'flash-chat-salt-$email');
  }

  /// Saves the salt for a given email
  Future<void> setSalt(String salt, String email) async {
    if (salt == null || salt == '') {
      throw ArgumentError('salt must not be null or empty');
    }

    if (email == null || email == '') {
      throw ArgumentError('email must not be null or empty');
    }

    await _flutterSecureStorage.write(
        key: 'flash-chat-salt-$email', value: salt);
  }

  /// Returns the public key for a given email
  Future<String> getPublicKey(String email) async {
    if (email == null || email == '') {
      throw ArgumentError('email must not be null or empty');
    }
    return await _flutterSecureStorage.read(key: 'flash-chat-pub-key-$email');
  }

  /// Returns the private key for a given email
  Future<String> getPrivateKey(String email) async {
    if (email == null || email == '') {
      throw ArgumentError('email must not be null or empty');
    }

    return await _flutterSecureStorage.read(key: 'flash-chat-priv-key-$email');
  }

  /// Saves the key pair for a given email
  Future<void> setKeyPair(
      String publicKey, String privateKey, String email) async {
    if (publicKey == null || publicKey == '') {
      throw ArgumentError('publicKey must not be null or empty');
    }

    if (privateKey == null || privateKey == '') {
      throw ArgumentError('privateKey must not be null or empty');
    }

    if (email == null || email == '') {
      throw ArgumentError('email must not be null or empty');
    }

    await _flutterSecureStorage.write(
        key: 'flash-chat-pub-key-$email', value: publicKey);
    await _flutterSecureStorage.write(
        key: 'flash-chat-priv-key-$email', value: privateKey);
  }
}
