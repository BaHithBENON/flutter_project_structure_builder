String generateErrorTypesTemplate() {
  return '''
enum ErrorTypes {
  customError("Une erreur est survenue", 0, 400),
  ;

  final String message;
  final int code;
  final int statusCode;
  const ErrorTypes(this.message, this.code, this.statusCode);

  @override
  String toString() {
    return "{ error: \$message => code: \$code => statusCode: \$statusCode }";
  }
}
''';
}

String generateFailureTemplate() {
  return '''
import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  const Failure([this.message = 'An unexpected error occurred,']);

  @override
  List get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}
''';
}

String generateAppExceptionTemplate() {
  return '''
import 'error_types.dart';

class AppException implements Exception {
  final ErrorTypes error;
  final String message;
  const AppException(this.error, {this.message = ''});

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

sealed class AppError {
  final ErrorTypes error;
  final Failure? failure;
  final StackTrace? stackTrace;
  const AppError(this.error, [this.failure, this.stackTrace]);
}

class ServerError extends AppError {
  const ServerError(super.error, [super.failure, super.stackTrace]);
}

class LocalError extends AppError {
  const LocalError(super.error, [super.failure, super.stackTrace]);
}

class ValidationError extends AppError {
  final Map<String, dynamic> fieldErrors;
  const ValidationError(super.error, this.fieldErrors, [super.failure, super.stackTrace]);
}

typedef Result<T, E> = (T value, E? error);
typedef AsyncResult<T, E> = Future<Result<T, E>>;
typedef ValidationResult = Result<void, ValidationError>;
typedef AppResult<T> = Result<T, AppError>;
typedef AsyncAppResult<T> = Future<AppResult<T>>;

extension AppResultExtension<T, E> on Result<T, E> {

  bool get isSuccess => \$2 == null;
  bool get isFailure => \$2 != null;

  T getOrDefault(T defaultValue) {
    if (isSuccess) return \$1;
    return defaultValue;
  }

  R fold<R>({required R Function(E error) onFailure, required R Function(T value) onSuccess}) {
    if (isSuccess) return onSuccess(\$1);
    return onFailure(\$2 as E);
  }

  String get errorMessage => \$2?.toString() ?? '';
}
''';
}

