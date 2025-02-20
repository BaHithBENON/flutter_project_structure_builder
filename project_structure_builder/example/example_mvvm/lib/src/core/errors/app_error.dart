import 'error_types.dart';
import 'failure.dart';
/// A sealed class that represents the result of an operation that may or may not
/// contain an error.
///
/// The class contains two properties:
/// - [error] which is an [ErrorTypes] that represents the type of the error.
/// - [failure] which is a [Failure] that represents the error itself.
/// - [stackTrace] which is a [StackTrace] that represents the stack trace of
///   the error.
///
/// The class also has a [toString] method which returns a string containing the
/// value of the [error], [failure] and [stackTrace] properties of the class.
sealed class AppError {
  /// The type of the error.
  final ErrorTypes error;

  /// The error itself.
  final Failure? failure;

  /// The stack trace of the error.
  final StackTrace? stackTrace;

  /// A constructor that takes an [ErrorTypes] and optional [Failure] and
  /// [StackTrace] as parameters and uses them to set the [error], [failure] and
  /// [stackTrace] properties of the class.
  const AppError(this.error, [this.failure, this.stackTrace]);
}

/// A class that represents a server error.
class ServerError extends AppError {
  /// A constructor that takes an [ErrorTypes] and optional [Failure] and
  /// [StackTrace] as parameters and uses them to set the [error], [failure] and
  /// [stackTrace] properties of the class.
  const ServerError(super.error, [super.failure, super.stackTrace]);
}

/// A class that represents a local error.
class LocalError extends AppError {
  /// A constructor that takes an [ErrorTypes] and optional [Failure] and
  /// [StackTrace] as parameters and uses them to set the [error], [failure] and
  /// [stackTrace] properties of the class.
  const LocalError(super.error, [super.failure, super.stackTrace]);
}

/// A class that represents a validation error.
class ValidationError extends AppError {
  /// The field errors.
  final Map<String, dynamic> fieldErrors;

  /// A constructor that takes an [ErrorTypes], a [Map<String, dynamic>] that
  /// contains the field errors and optional [Failure] and [StackTrace] as
  /// parameters and uses them to set the [error], [fieldErrors], [failure] and
  /// [stackTrace] properties of the class.
  const ValidationError(super.error, this.fieldErrors, [super.failure, super.stackTrace]);
}

/// A type alias for a [Result] that contains a [T] value and an optional [E] error.
typedef Result<T, E> = (T value, E? error);

/// A type alias for an [AsyncResult] that contains a [T] value and an optional [E] error.
typedef AsyncResult<T, E> = Future<Result<T, E>>;

/// A type alias for a [ValidationResult] that contains a [void] value and an optional [ValidationError] error.
typedef ValidationResult = Result<void, ValidationError>;

/// A type alias for an [AppResult] that contains a [T] value and an optional [AppError] error.
typedef AppResult<T> = Result<T, AppError>;

/// A type alias for an [AsyncAppResult] that contains a [T] value and an optional [AppError] error.
typedef AsyncAppResult<T> = Future<AppResult<T>>;

/// A type alias for a [Function] that takes an [E] error and returns an [R] value.
typedef ErrorFunction<R, E> = R Function(E error);

/// A type alias for a [Function] that takes an [E] error and returns an [R] value.
typedef SuccessFunction<R, T> = R Function(T value);

/// An extension on the [Result] class.
extension AppResultExtension<T, E> on Result<T, E> {
  /// Checks if the result is a success.
  bool get isSuccess => $2 == null;

  /// Checks if the result is a failure.
  bool get isFailure => $2 != null;

  /// Returns the value of the result if the result is a success, otherwise it
  /// returns the default value.
  T getOrDefault(T defaultValue) {
    if (isSuccess) return $1;
    return defaultValue;
  }

  /// A method that takes an [ErrorFunction] and an [SuccessFunction] as
  /// parameters and uses them to return a value based on the result of the
  /// operation.
  R fold<R>({
    required R Function(E error) onFailure,
    required R Function(T value) onSuccess,
  }) {
    if (isSuccess) return onSuccess($1);
    return onFailure($2 as E);
  }

  /// Returns a string that represents the error of the result.
  String get errorMessage => $2?.toString() ?? '';
}
