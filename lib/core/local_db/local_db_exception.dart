/// Wrapper around low-level sqflite errors so callers never depend on
/// `DatabaseException` directly.
class LocalDbException implements Exception {
  LocalDbException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() {
    if (cause == null) return 'LocalDbException: $message';
    return 'LocalDbException: $message (cause: $cause)';
  }
}
