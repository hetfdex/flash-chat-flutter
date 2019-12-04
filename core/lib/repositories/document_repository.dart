import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_core/utils/rsa_utils.dart';
import 'package:pointycastle/export.dart';

/// The document repository interface
abstract class IDocumentRepository {
  /// Returns the messages
  Stream<QuerySnapshot> getMessageStream();

  /// Returns the users public keys
  Future<QuerySnapshot> getUsersPublicKeys();

  /// Posts a message
  Future<void> postMesssage(
      {String message, String senderEmail, RSAPrivateKey privateKey});

  /// Post a user's public key
  Future<void> postUserPublicKey({String email, String publicKeyPem});
}

/// The document repository implementation
class DocumentRepository extends IDocumentRepository {
  /// Constructs the document repository
  DocumentRepository(this._firestore) : assert(_firestore != null);

  final Firestore _firestore;

  @override
  Stream<QuerySnapshot> getMessageStream() {
    try {
      return _firestore.collection('messages').snapshots();
    } on dynamic catch (_) {
      rethrow;
    }
  }

  @override
  Future<QuerySnapshot> getUsersPublicKeys() async {
    try {
      return await _firestore.collection('publicKeys').getDocuments();
    } on dynamic catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> postMesssage(
      {String message, String senderEmail, RSAPrivateKey privateKey}) async {
    if (message == null || message == '') {
      throw ArgumentError('message must not be null or empty');
    }

    if (senderEmail == null || senderEmail == '') {
      throw ArgumentError('senderEmail must not be null or empty');
    }

    if (privateKey == null) {
      throw ArgumentError('privateKey must not be null');
    }

    try {
      final encryptedMessage = encryptMessage(message, privateKey);

      final data = <String, Object>{
        'message': encryptedMessage,
        'sender': senderEmail,
        'timestamp': DateTime.now().millisecondsSinceEpoch
      };

      await _firestore.collection('messages').add(data);
    } on dynamic catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> postUserPublicKey({String email, String publicKeyPem}) async {
    if (email == null || email == '') {
      throw ArgumentError('email must not be null or empty');
    }

    if (publicKeyPem == null || publicKeyPem == '') {
      throw ArgumentError('password must not be null or empty');
    }

    try {
      final data = <String, String>{
        'sender': email,
        'publicKey': publicKeyPem,
      };

      await _firestore.collection('publicKeys').add(data);
    } on dynamic catch (_) {
      rethrow;
    }
  }
}
