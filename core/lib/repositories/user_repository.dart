import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/utils/hash_utils.dart';
import 'package:flash_chat_core/utils/pem_utils.dart';
import 'package:flash_chat_core/utils/rsa_utils.dart';
import 'package:flash_chat_core/utils/secure_storage_utils.dart';

/// The user repository interface
abstract class IUserRepository {
  /// Returns the user
  Future<FirebaseUser> get user;

  /// Registers a uses
  Future<FirebaseUser> register({String email, String password});

  /// Logs a user in
  Future<FirebaseUser> login({String email, String password});

  /// Logs a user out
  Future<void> logout();
}

/// The user repository implementation
class UserRepository extends IUserRepository {
  /// Constructs the user repository
  UserRepository(this._firebaseAuth, this._secureStorageUtils)
      : assert(_firebaseAuth != null),
        assert(_secureStorageUtils != null);

  final FirebaseAuth _firebaseAuth;

  final SecureStorageUtils _secureStorageUtils;

  @override
  Future<FirebaseUser> get user => _firebaseAuth.currentUser();

  @override
  Future<FirebaseUser> register({String email, String password}) async {
    if (email == null && email == '') {
      throw ArgumentError('email must not be null or empty');
    }

    if (password == null && password == '') {
      throw ArgumentError('password must not be null or empty');
    }

    try {
      final encryptedPassword = encryptPassword(password, null);

      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: encryptedPassword);

      if (authResult != null) {
        await _setupKeyPair(email);

        return authResult.user;
      }
      return null;
    } on Object catch (e) {
      throw 'User Register Failed: $e';
    }
  }

  @override
  Future<FirebaseUser> login({String email, String password}) async {
    if (email == null && email == '') {
      throw ArgumentError('email must not be null or empty');
    }

    if (password == null && password == '') {
      throw ArgumentError('password must not be null or empty');
    }

    try {
      final salt = await _secureStorageUtils.getSalt(email);

      final encryptedPassword = encryptPassword(password, salt);

      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: encryptedPassword);

      if (authResult != null) {
        return authResult.user;
      }
      return null;
    } on Object catch (e) {
      throw 'User Login Failed: $e';
    }
  }

  @override
  Future<void> logout() {
    try {
      return _firebaseAuth.signOut();
    } on Object catch (e) {
      throw 'User Logout Failed: $e';
    }
  }

  Future<void> _setupKeyPair(String email) async {
    final keyPair = generateKeyPair();

    final publicKeyPem = publicKeyToPem(keyPair.publicKey);

    final privateKeyPem = privateKeyToPem(keyPair.privateKey);

    _secureStorageUtils.setKeyPair(privateKeyPem, publicKeyPem, email);
  }
}
