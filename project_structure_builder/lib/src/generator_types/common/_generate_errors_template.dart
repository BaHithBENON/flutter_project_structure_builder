/// An enumeration of the different types of errors that can occur in the app.
///
/// This class provides a set of constants that represent the different types of
/// errors that can occur in the app. The constants are used to identify the type
/// of error that has occurred.
///
/// The constants are used to generate a class that will be used to represent the
/// different types of errors that can occur in the app.
///
/// The class will have a single constructor that takes a string, an int and an
/// int as parameters. The constructor will use the parameters to set the
/// [message], [code] and [statusCode] properties of the class.
///
/// The class will have a [toString] method that will return a string containing
/// the value of the [message], [code] and [statusCode] properties.
String generateErrorTypesTemplate() {
  return '''
/// An enumeration of the different types of errors that can occur in the app.
enum ErrorTypes {
  /// A custom error that can be used to represent any type of error.
  customError("Une erreur est survenue", 0, 400),
  ;

  /// A string describing the error.
  final String message;

  /// An integer representing the code of the error.
  final int code;

  /// An integer representing the status code of the error.
  final int statusCode;
  /// A constant constructor that takes a string, an int and an int as
  /// parameters. The constructor will use the parameters to set the [message],
  /// [code] and [statusCode] properties of the class.
  const ErrorTypes(this.message, this.code, this.statusCode);

  /// A method that returns a string containing the value of the [message],
  /// [code] and [statusCode] properties.
  @override
  String toString() {
    return "{ error: \$message => code: \$code => statusCode: \$statusCode }";
  }
}
''';
}

/// A class that represents a failure in the app.
///
/// The class contains a single property, [message], which is a string describing
/// the failure.
///
/// The class is an [Equatable] which means that it can be compared with other
/// objects of the same type using the [==] operator.
///
/// The class also has a [toString] method which returns a string containing the
/// value of the [message] property.
String generateFailureTemplate() {
  return '''
import 'package:equatable/equatable.dart';

/// A class that represents a failure in the app.
class Failure extends Equatable {
  /// A string describing the failure.
  final String message;

  /// A constructor that takes a string as a parameter and uses it to set the
  /// [message] property of the class.
  const Failure([this.message = 'An unexpected error occurred,']);

  /// A method that returns a list containing the [message] property of the class.
  @override
  List get props => [message];

  /// A method that returns a string containing the value of the [message]
  /// property of the class.
  @override
  String toString() {
    return "{ message: \$message }";
  }
}

/// A class that represents a server failure in the app.
class ServerFailure extends Failure {
  /// A constructor that takes a string as a parameter and uses it to set the
  /// [message] property of the class.
  const ServerFailure([super.message = 'The server failed to respond.']);
}

/// A class that represents a connection failure in the app.
class ConnectionFailure extends Failure {
  /// A constructor that takes a string as a parameter and uses it to set the
  /// [message] property of the class.
  const ConnectionFailure([super.message = 'The connection to the server failed.']);
}

/// A class that represents a database failure in the app.
class DatabaseFailure extends Failure {
  /// A constructor that takes a string as a parameter and uses it to set the
  /// [message] property of the class.
  const DatabaseFailure([super.message = 'The database failed to respond.']);
}
''';
}

/// A class that represents an exception that can occur in the app.
///
/// The class contains two properties:
/// - [error] which is an [ErrorTypes] that represents the type of the exception.
/// - [message] which is a string that describes the exception.
///
/// The class also has a [toString] method which returns a string containing the
/// value of the [error] and [message] properties.
String generateAppExceptionTemplate() {
  return '''
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
    return "{ error: \$error => message: \$message }";
  }
}
''';
}

String generateAppErrorTemplate() {
  return '''
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
  bool get isSuccess => \$2 == null;

  /// Checks if the result is a failure.
  bool get isFailure => \$2 != null;

  /// Returns the value of the result if the result is a success, otherwise it
  /// returns the default value.
  T getOrDefault(T defaultValue) {
    if (isSuccess) return \$1;
    return defaultValue;
  }

  /// A method that takes an [ErrorFunction] and an [SuccessFunction] as
  /// parameters and uses them to return a value based on the result of the
  /// operation.
  R fold<R>({
    required R Function(E error) onFailure,
    required R Function(T value) onSuccess,
  }) {
    if (isSuccess) return onSuccess(\$1);
    return onFailure(\$2 as E);
  }

  /// Returns a string that represents the error of the result.
  String get errorMessage => \$2?.toString() ?? '';
}
''';
}
