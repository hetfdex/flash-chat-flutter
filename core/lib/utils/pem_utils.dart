import 'dart:convert';
import 'dart:typed_data';
import 'package:asn1lib/asn1lib.dart';
import 'package:pointycastle/pointycastle.dart';

RSAPublicKey pemToPublicKey(String pem) {
  if (pem == null) {
    throw ArgumentError('pem must not be null or empty');
  }

  final publicKeyDER = _decodePem(pem);

  final asn1Parser = ASN1Parser(publicKeyDER);

  final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

  final publicKeyBitString = topLevelSeq.elements[1];

  final publicKeyAsn = ASN1Parser(publicKeyBitString.contentBytes());

  final ASN1Sequence publicKeySeq = publicKeyAsn.nextObject();

  final modulus = publicKeySeq.elements[0] as ASN1Integer;

  final exponent = publicKeySeq.elements[1] as ASN1Integer;

  final rsaPublicKey =
      RSAPublicKey(modulus.valueAsBigInteger, exponent.valueAsBigInteger);

  return rsaPublicKey;
}

RSAPrivateKey pemToPrivateKey(String pem) {
  if (pem == null) {
    throw ArgumentError('pem must not be null or empty');
  }

  final privateKeyDER = _decodePem(pem);

  var asn1Parser = ASN1Parser(privateKeyDER);

  final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

  final privateKey = topLevelSeq.elements[2];

  asn1Parser = ASN1Parser(privateKey.contentBytes());

  final pkSeq = asn1Parser.nextObject() as ASN1Sequence;

  final modulus = pkSeq.elements[1] as ASN1Integer;

  final privateExponent = pkSeq.elements[3] as ASN1Integer;

  final p = pkSeq.elements[4] as ASN1Integer;

  final q = pkSeq.elements[5] as ASN1Integer;

  final rsaPrivateKey = RSAPrivateKey(
      modulus.valueAsBigInteger,
      privateExponent.valueAsBigInteger,
      p.valueAsBigInteger,
      q.valueAsBigInteger);

  return rsaPrivateKey;
}

String publicKeyToPem(RSAPublicKey publicKey) {
  if (publicKey == null) {
    throw ArgumentError('publicKey must not be null or empty');
  }

  final algorithmSeq = ASN1Sequence();

  final algorithmAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList(
      <int>[0x6, 0x9, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0xd, 0x1, 0x1, 0x1]));

  final paramsAsn1Obj =
      ASN1Object.fromBytes(Uint8List.fromList(<int>[0x5, 0x0]));

  algorithmSeq.add(algorithmAsn1Obj);
  algorithmSeq.add(paramsAsn1Obj);

  final publicKeySeq = ASN1Sequence();

  publicKeySeq.add(ASN1Integer(publicKey.modulus));
  publicKeySeq.add(ASN1Integer(publicKey.exponent));

  final publicKeySeqBitString =
      ASN1BitString(Uint8List.fromList(publicKeySeq.encodedBytes));

  final topLevelSeq = ASN1Sequence();

  topLevelSeq.add(algorithmSeq);
  topLevelSeq.add(publicKeySeqBitString);

  final dataBase64 = base64.encode(topLevelSeq.encodedBytes);

  return '-----BEGIN PUBLIC KEY-----\r\n$dataBase64\r\n-----END PUBLIC KEY-----';
}

String privateKeyToPem(RSAPrivateKey privateKey) {
  if (privateKey == null) {
    throw ArgumentError('privateKey must not be null or empty');
  }

  final version = ASN1Integer(BigInt.from(0));

  final algorithmSeq = ASN1Sequence();

  final algorithmAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList(
      <int>[0x6, 0x9, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0xd, 0x1, 0x1, 0x1]));

  final paramsAsn1Obj =
      ASN1Object.fromBytes(Uint8List.fromList(<int>[0x5, 0x0]));

  algorithmSeq.add(algorithmAsn1Obj);
  algorithmSeq.add(paramsAsn1Obj);

  final privateKeySeq = ASN1Sequence();

  final modulus = ASN1Integer(privateKey.n);

  final publicExponent = ASN1Integer(BigInt.parse('65537'));

  final privateExponent = ASN1Integer(privateKey.d);

  final p = ASN1Integer(privateKey.p);

  final q = ASN1Integer(privateKey.q);

  final dP = privateKey.d % (privateKey.p - BigInt.from(1));

  final exp1 = ASN1Integer(dP);

  final dQ = privateKey.d % (privateKey.q - BigInt.from(1));

  final exp2 = ASN1Integer(dQ);

  final iQ = privateKey.q.modInverse(privateKey.p);

  final co = ASN1Integer(iQ);

  privateKeySeq.add(version);
  privateKeySeq.add(modulus);
  privateKeySeq.add(publicExponent);
  privateKeySeq.add(privateExponent);
  privateKeySeq.add(p);
  privateKeySeq.add(q);
  privateKeySeq.add(exp1);
  privateKeySeq.add(exp2);
  privateKeySeq.add(co);

  final publicKeySeqOctetString =
      ASN1OctetString(Uint8List.fromList(privateKeySeq.encodedBytes));

  final topLevelSeq = ASN1Sequence();

  topLevelSeq.add(version);
  topLevelSeq.add(algorithmSeq);
  topLevelSeq.add(publicKeySeqOctetString);

  final dataBase64 = base64.encode(topLevelSeq.encodedBytes);

  return '-----BEGIN PRIVATE KEY-----\r\n$dataBase64\r\n-----END PRIVATE KEY-----';
}

List<int> _decodePem(String pem) {
  final startsWith = <String>[
    '-----BEGIN PUBLIC KEY-----',
    '-----BEGIN PRIVATE KEY-----',
    '-----BEGIN PGP PUBLIC KEY BLOCK-----\r\nVersion: React-Native-OpenPGP.js 0.1\r\nComment: http://openpgpjs.org\r\n\r\n',
    '-----BEGIN PGP PRIVATE KEY BLOCK-----\r\nVersion: React-Native-OpenPGP.js 0.1\r\nComment: http://openpgpjs.org\r\n\r\n',
  ];

  final endsWith = <String>[
    '-----END PUBLIC KEY-----',
    '-----END PRIVATE KEY-----',
    '-----END PGP PUBLIC KEY BLOCK-----',
    '-----END PGP PRIVATE KEY BLOCK-----',
  ];

  for (var s in startsWith) {
    if (pem.startsWith(s)) {
      pem = pem.substring(s.length);
    }
  }

  for (var s in endsWith) {
    if (pem.endsWith(s)) {
      pem = pem.substring(0, pem.length - s.length);
    }
  }

  pem = pem.replaceAll('\n', '');
  pem = pem.replaceAll('\r', '');

  return base64.decode(pem);
}
