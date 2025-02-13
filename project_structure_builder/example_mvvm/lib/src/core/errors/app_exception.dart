import 'error_types.dart';

/// A class that represents an exception that can occur in the app.
class AppException implements Exception {
  /// The type of the exception.
  final ErrorTypes error;

  /// A string that describes the exception.
  final String message;

  /// A constructor that takes an [ErrorTypes] and an optional [String] as
  /// parameters and uses them to set the [error] and [message] properties of
  /// the class.
  const AppException(this.error, {this.message = ''});

  /// A method that returns a string containing the value of the [error] and
  /// [message] properties of the class.
  @override
  String toString() {
    return "{ error: $error => message: $message }";
  }
}
