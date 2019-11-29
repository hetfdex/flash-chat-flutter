import 'package:dbcrypt/dbcrypt.dart';

String encryptPassword(String password, String salt) {
  if (password == null || password == '') {
    throw ArgumentError('password must not be null or empty');
  }

  if (salt == null || salt == '') {
    salt = DBCrypt().gensalt();
  }
  return DBCrypt().hashpw(password, salt);
}
