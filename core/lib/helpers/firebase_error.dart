/// The firebase error
class FirebaseError extends Error {
  /// Constructs the firebase error
  FirebaseError(this.code) : assert(code != null);

  /// The error code
  final String code;
}
