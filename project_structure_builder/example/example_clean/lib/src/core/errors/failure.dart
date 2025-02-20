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
    return "{ message: $message }";
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
