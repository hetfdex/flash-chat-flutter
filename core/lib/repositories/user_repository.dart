import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_core/utils/hash_utils.dart';
import 'package:flash_chat_core/utils/pem_utils.dart';
import 'package:flash_chat_core/utils/rsa_utils.dart';
import 'package:flash_chat_core/utils/secure_storage_utils.dart';
import 'package:pointycastle/api.dart';

abstract class IUserRepository {
  Future<FirebaseUser> get user;

  Future<FirebaseUser> register(String email, String password);

  Future<FirebaseUser> login(String email, String password);

  Future<void> logout();
}

class UserRepository extends IUserRepository {
  UserRepository(this._firebaseAuth, this._secureStorageUtils)
      : assert(_firebaseAuth != null),
        assert(_secureStorageUtils != null);

  final FirebaseAuth _firebaseAuth;

  final SecureStorageUtils _secureStorageUtils;

  @override
  Future<FirebaseUser> get user => _firebaseAuth.currentUser();

  @override
  Future<FirebaseUser> register(String email, String password) async {
    try {
      final String encryptedPassword = encryptPassword(password, null);

      final AuthResult authResult =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: encryptedPassword);

      if (authResult != null) {
        await _setupKeyPair(email);

        return authResult.user;
      }
      return null;
    } catch (e) {
      throw 'User Register Failed: $e';
    }
  }

  @override
  Future<FirebaseUser> login(String email, String password) async {
    try {
      final String salt = await _secureStorageUtils.getSalt(email);

      final String encryptedPassword = encryptPassword(password, salt);

      final AuthResult authResult =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: encryptedPassword);

      if (authResult != null) {
        return authResult.user;
      }
      return null;
    } catch (e) {
      throw 'User Login Failed: $e';
    }
  }

  @override
  Future<void> logout() {
    try {
      return _firebaseAuth.signOut();
    } catch (e) {
      throw 'User Logout Failed: $e';
    }
  }

  Future<void> _setupKeyPair(String email) async {
    final AsymmetricKeyPair<PublicKey, PrivateKey> keyPair = generateKeyPair();

    final String publicKeyPem = publicKeyToPem(keyPair.publicKey);

    final String privateKeyPem = privateKeyToPem(keyPair.privateKey);

    _secureStorageUtils.setKeyPair(privateKeyPem, publicKeyPem, email);
  }
}
