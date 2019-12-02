final RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
final RegExp _passwordRegex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

/// Checks whether a given email is valid
bool isValidEmail(String email) {
  if (email == null || email == '') {
    return false;
  }
  return _emailRegex.hasMatch(email);
}

/// Checks whether a given password is valid
bool isValidPassword(String password) {
  if (password == null || password == '') {
    return false;
  }
  return _passwordRegex.hasMatch(password);
}
