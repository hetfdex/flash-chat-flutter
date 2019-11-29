import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_core/utils/secure_storage_utils.dart';

abstract class IDocumentRepository {}

class DocumentRepository extends IDocumentRepository {
  DocumentRepository(this._firestore, this._secureStorageUtils)
      : assert(_firestore != null),
        assert(_secureStorageUtils != null);

  final Firestore _firestore;

  final SecureStorageUtils _secureStorageUtils;

  Future<void> _addPublicKeyToFirestore(String email) async {
    final publicKeyPem = await _secureStorageUtils.getPublicKey(email);

    final data = <String, String>{
      'sender': email,
      'publicKey': publicKeyPem,
    };

    await _firestore.collection('publicKeys').add(data);
  }
}
