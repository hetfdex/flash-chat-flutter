import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flash_chat_core/repositories/document_repository.dart';
import 'package:flash_chat_core/utils/rsa_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const message = 'message';
  const email = 'email';
  const publicKeyPEM = 'publicKeyPEM';

  final messageCollection = {'1': 'one', '2': 'two'};

  final publicKeysCollection = {'sender': 'sender', 'publicKey': 'publicKey'};

  final keyPair = generateKeyPair();

  MockFirestoreInstance firestore;

  DocumentRepository documentRepository;

  setUp(() async {
    firestore = MockFirestoreInstance();

    documentRepository = DocumentRepository(firestore);
  });

  group('constructor', () {
    test('null firestore throws error', () {
      expect(() => DocumentRepository(null), throwsAssertionError);
    });
  });

  group('getMessageStream', () {
    test('returns stream', () async {
      await firestore.collection('messages').add(messageCollection);

      await documentRepository.getMessageStream();

      expect(
          firestore.collection('messages').snapshots(),
          emits(QuerySnapshotMatcher(
              [DocumentSnapshotMatcher('z', messageCollection)])));
    });
  });

  group('getUsersPublicKeys', () {
    test('gets public keys', () async {
      await firestore.collection('publicKeys').add(publicKeysCollection);

      final result = await documentRepository.getUsersPublicKeys();

      expect(result, publicKeysCollection);
    });
  });

  group('postMessage', () {
    test('null message throws error', () async {
      expect(
          () async => await documentRepository.postMesssage(
              message: null,
              senderEmail: email,
              privateKey: keyPair.privateKey),
          throwsArgumentError);
    });

    test('empty message throws error', () async {
      expect(
          () async => await documentRepository.postMesssage(
              message: '', senderEmail: email, privateKey: keyPair.privateKey),
          throwsArgumentError);
    });

    test('null senderEmail throws error', () async {
      expect(
          () async => await documentRepository.postMesssage(
              message: message,
              senderEmail: null,
              privateKey: keyPair.privateKey),
          throwsArgumentError);
    });

    test('empty senderEmail throws error', () async {
      expect(
          () async => await documentRepository.postMesssage(
              message: null, senderEmail: '', privateKey: keyPair.privateKey),
          throwsArgumentError);
    });

    test('null privateKey throws error', () async {
      expect(
          () async => await documentRepository.postMesssage(
              message: message, senderEmail: email, privateKey: null),
          throwsArgumentError);
    });

    test('posts message', () async {
      await documentRepository.postMesssage(
          message: message, senderEmail: email, privateKey: keyPair.privateKey);

      expect(
          firestore.collection('messages').snapshots(),
          emits(QuerySnapshotMatcher(
              [DocumentSnapshotMatcher('z', messageCollection)])));
    });
  });

  group('postUserPublicKey', () {
    test('null email throws error', () async {
      expect(
          () async => await documentRepository.postUserPublicKey(
              email: null, publicKeyPem: publicKeyPEM),
          throwsArgumentError);
    });

    test('empty email throws error', () async {
      expect(
          () async => await documentRepository.postUserPublicKey(
              email: '', publicKeyPem: publicKeyPEM),
          throwsArgumentError);
    });

    test('null publicKeyPem throws error', () async {
      expect(
          () async => await documentRepository.postUserPublicKey(
              email: email, publicKeyPem: null),
          throwsArgumentError);
    });

    test('empty publicKeyPem throws error', () async {
      expect(
          () async => await documentRepository.postUserPublicKey(
              email: email, publicKeyPem: ''),
          throwsArgumentError);
    });

    test('posts public key', () async {
      await documentRepository.postUserPublicKey(
          email: email, publicKeyPem: publicKeyPEM);

      expect(
          firestore.collection('messages').snapshots(),
          emits(QuerySnapshotMatcher([
            DocumentSnapshotMatcher(
                'z', {'email': email, 'publicKey': publicKeyPEM})
          ])));
    });
  });
}

class QuerySnapshotMatcher implements Matcher {
  final _documentSnapshotMatchers;

  QuerySnapshotMatcher(this._documentSnapshotMatchers);

  @override
  Description describe(Description description) {
    return StringDescription("Matches a query snapshot's DocumentSnapshots.");
  }

  @override
  Description describeMismatch(dynamic item, Description mismatchDescription,
      Map matchState, bool verbose) {
    mismatchDescription.add("Snapshot does not match expected data.");

    final snapshot = item as QuerySnapshot;

    for (var i = 0; i < snapshot.documents.length; i++) {
      final matcher = _documentSnapshotMatchers[i];

      final item = snapshot.documents[i];

      if (!matcher.matches(item, matchState)) {
        matcher.describeMismatch(
            item, mismatchDescription, matchState, verbose);
      }
    }
    return mismatchDescription;
  }

  @override
  bool matches(dynamic item, Map matchState) {
    final snapshot = item as QuerySnapshot;

    if (snapshot.documents.length != _documentSnapshotMatchers.length) {
      return false;
    }

    for (var i = 0; i < snapshot.documents.length; i++) {
      final matcher = _documentSnapshotMatchers[i];
      if (!matcher.matches(snapshot.documents[i], matchState)) {
        return false;
      }
    }
    return true;
  }
}

class DocumentSnapshotMatcher implements Matcher {
  final _documentId;
  final _data;

  DocumentSnapshotMatcher(this._documentId, this._data);

  @override
  Description describe(Description description) {
    return StringDescription("Matches a snapshot's documentId and data");
  }

  @override
  Description describeMismatch(dynamic item, Description mismatchDescription,
      Map matchState, bool verbose) {
    final snapshot = item as DocumentSnapshot;

    if (!equals(snapshot.documentID).matches(_documentId, matchState)) {
      equals(snapshot.documentID).describeMismatch(
          _documentId, mismatchDescription, matchState, verbose);
    }

    if (!equals(snapshot.data).matches(_data, matchState)) {
      equals(snapshot.data)
          .describeMismatch(_data, mismatchDescription, matchState, verbose);
    }
    return mismatchDescription;
  }

  @override
  bool matches(dynamic item, Map matchState) {
    final snapshot = item as DocumentSnapshot;

    return equals(snapshot.documentID).matches(_documentId, matchState) &&
        equals(snapshot.data).matches(_data, matchState);
  }
}
