import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_core/utils/rsa_utils.dart';
import 'package:pointycastle/export.dart';

/// The document repository interface
abstract class IDocumentRepository {
  /// Returns the messages
  Stream<QuerySnapshot> getMessageStream(
      {String collection, String orderBy, bool descending});

  /// Returns the users public keys
  Future<Map<String, String>> getUsersPublicKeys();

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
  Stream<QuerySnapshot> getMessageStream(
      {String collection, String orderBy, bool descending}) {
    if (collection == null || collection == '') {
      throw ArgumentError('collection must not be null or empty');
    }

    if (orderBy == null || orderBy == '') {
      throw ArgumentError('orderBy must not be null or empty');
    }

    if (descending == null) {
      throw ArgumentError('descending must not be null or empty');
    }

    try {
      return _firestore
          .collection(collection)
          .orderBy(orderBy, descending: descending)
          .snapshots();
    } on dynamic catch (_) {
      rethrow;
    }
  }

  @override
  Future<Map<String, String>> getUsersPublicKeys() async {
    try {
      Map<String, String> users;

      final querySnapshot =
          await _firestore.collection('publicKeys').getDocuments();

      if (querySnapshot != null) {
        for (var document in querySnapshot.documents) {
          users[document.data['sender']] = document.data['publicKey'];
        }
      }

      return users;
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
