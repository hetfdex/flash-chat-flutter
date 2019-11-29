import 'dart:convert';
import 'dart:typed_data';
import 'package:asn1lib/asn1lib.dart';
import 'package:pointycastle/pointycastle.dart';

RSAPublicKey pemToPublicKey(String pem) {
  if (pem == null) {
    throw ArgumentError('pem must not be null or empty');
  }

  final List<int> publicKeyDER = _decodePem(pem);

  final ASN1Parser asn1Parser = ASN1Parser(publicKeyDER);

  final ASN1Sequence topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

  final ASN1Object publicKeyBitString = topLevelSeq.elements[1];

  final ASN1Parser publicKeyAsn = ASN1Parser(publicKeyBitString.contentBytes());

  final ASN1Sequence publicKeySeq = publicKeyAsn.nextObject();

  final ASN1Integer modulus = publicKeySeq.elements[0] as ASN1Integer;

  final ASN1Integer exponent = publicKeySeq.elements[1] as ASN1Integer;

  final RSAPublicKey rsaPublicKey =
      RSAPublicKey(modulus.valueAsBigInteger, exponent.valueAsBigInteger);

  return rsaPublicKey;
}

RSAPrivateKey pemToPrivateKey(String pem) {
  if (pem == null) {
    throw ArgumentError('pem must not be null or empty');
  }

  final List<int> privateKeyDER = _decodePem(pem);

  ASN1Parser asn1Parser = ASN1Parser(privateKeyDER);

  final ASN1Sequence topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

  final ASN1Object privateKey = topLevelSeq.elements[2];

  asn1Parser = ASN1Parser(privateKey.contentBytes());

  final ASN1Sequence pkSeq = asn1Parser.nextObject() as ASN1Sequence;

  final ASN1Integer modulus = pkSeq.elements[1] as ASN1Integer;

  final ASN1Integer privateExponent = pkSeq.elements[3] as ASN1Integer;

  final ASN1Integer p = pkSeq.elements[4] as ASN1Integer;

  final ASN1Integer q = pkSeq.elements[5] as ASN1Integer;

  final RSAPrivateKey rsaPrivateKey = RSAPrivateKey(
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

  final ASN1Sequence algorithmSeq = ASN1Sequence();

  final ASN1Object algorithmAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList(
      <int>[0x6, 0x9, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0xd, 0x1, 0x1, 0x1]));

  final ASN1Object paramsAsn1Obj =
      ASN1Object.fromBytes(Uint8List.fromList(<int>[0x5, 0x0]));

  algorithmSeq.add(algorithmAsn1Obj);
  algorithmSeq.add(paramsAsn1Obj);

  final ASN1Sequence publicKeySeq = ASN1Sequence();

  publicKeySeq.add(ASN1Integer(publicKey.modulus));
  publicKeySeq.add(ASN1Integer(publicKey.exponent));

  final ASN1BitString publicKeySeqBitString =
      ASN1BitString(Uint8List.fromList(publicKeySeq.encodedBytes));

  final ASN1Sequence topLevelSeq = ASN1Sequence();

  topLevelSeq.add(algorithmSeq);
  topLevelSeq.add(publicKeySeqBitString);

  final String dataBase64 = base64.encode(topLevelSeq.encodedBytes);

  return '-----BEGIN PUBLIC KEY-----\r\n$dataBase64\r\n-----END PUBLIC KEY-----';
}

String privateKeyToPem(RSAPrivateKey privateKey) {
  if (privateKey == null) {
    throw ArgumentError('privateKey must not be null or empty');
  }

  final ASN1Integer version = ASN1Integer(BigInt.from(0));

  final ASN1Sequence algorithmSeq = ASN1Sequence();

  final ASN1Object algorithmAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList(
      <int>[0x6, 0x9, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0xd, 0x1, 0x1, 0x1]));

  final ASN1Object paramsAsn1Obj =
      ASN1Object.fromBytes(Uint8List.fromList(<int>[0x5, 0x0]));

  algorithmSeq.add(algorithmAsn1Obj);
  algorithmSeq.add(paramsAsn1Obj);

  final ASN1Sequence privateKeySeq = ASN1Sequence();

  final ASN1Integer modulus = ASN1Integer(privateKey.n);

  final ASN1Integer publicExponent = ASN1Integer(BigInt.parse('65537'));

  final ASN1Integer privateExponent = ASN1Integer(privateKey.d);

  final ASN1Integer p = ASN1Integer(privateKey.p);

  final ASN1Integer q = ASN1Integer(privateKey.q);

  final BigInt dP = privateKey.d % (privateKey.p - BigInt.from(1));

  final ASN1Integer exp1 = ASN1Integer(dP);

  final BigInt dQ = privateKey.d % (privateKey.q - BigInt.from(1));

  final ASN1Integer exp2 = ASN1Integer(dQ);

  final BigInt iQ = privateKey.q.modInverse(privateKey.p);

  final ASN1Integer co = ASN1Integer(iQ);

  privateKeySeq.add(version);
  privateKeySeq.add(modulus);
  privateKeySeq.add(publicExponent);
  privateKeySeq.add(privateExponent);
  privateKeySeq.add(p);
  privateKeySeq.add(q);
  privateKeySeq.add(exp1);
  privateKeySeq.add(exp2);
  privateKeySeq.add(co);

  final ASN1OctetString publicKeySeqOctetString =
      ASN1OctetString(Uint8List.fromList(privateKeySeq.encodedBytes));

  final ASN1Sequence topLevelSeq = ASN1Sequence();

  topLevelSeq.add(version);
  topLevelSeq.add(algorithmSeq);
  topLevelSeq.add(publicKeySeqOctetString);

  final String dataBase64 = base64.encode(topLevelSeq.encodedBytes);

  return '-----BEGIN PRIVATE KEY-----\r\n$dataBase64\r\n-----END PRIVATE KEY-----';
}

List<int> _decodePem(String pem) {
  final List<String> startsWith = <String>[
    '-----BEGIN PUBLIC KEY-----',
    '-----BEGIN PRIVATE KEY-----',
    '-----BEGIN PGP PUBLIC KEY BLOCK-----\r\nVersion: React-Native-OpenPGP.js 0.1\r\nComment: http://openpgpjs.org\r\n\r\n',
    '-----BEGIN PGP PRIVATE KEY BLOCK-----\r\nVersion: React-Native-OpenPGP.js 0.1\r\nComment: http://openpgpjs.org\r\n\r\n',
  ];

  final List<String> endsWith = <String>[
    '-----END PUBLIC KEY-----',
    '-----END PRIVATE KEY-----',
    '-----END PGP PUBLIC KEY BLOCK-----',
    '-----END PGP PRIVATE KEY BLOCK-----',
  ];

  for (String s in startsWith) {
    if (pem.startsWith(s)) {
      pem = pem.substring(s.length);
    }
  }

  for (String s in endsWith) {
    if (pem.endsWith(s)) {
      pem = pem.substring(0, pem.length - s.length);
    }
  }

  pem = pem.replaceAll('\n', '');
  pem = pem.replaceAll('\r', '');

  return base64.decode(pem);
}
