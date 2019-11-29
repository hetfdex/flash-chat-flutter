final RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
final RegExp _passwordRegex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

bool isValidEmail(String email) {
  if (email == null || email == '') {
    return false;
  }
  return _emailRegex.hasMatch(email);
}

bool isValidPassword(String password) {
  if (password == null || password == '') {
    return false;
  }
  return _passwordRegex.hasMatch(password);
}
