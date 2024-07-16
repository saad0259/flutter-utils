// fallback_exception_handler.dart
class BaseException implements Exception {
  final String message;
  BaseException(this.message);

  @override
  String toString() => "Exception: $message";
}

Future<T> executeSafely<T>(Future<T> Function() function) async {
  try {
    return await function();
  } catch (e) {
    print(e.toString());
    rethrow;
  }
}
