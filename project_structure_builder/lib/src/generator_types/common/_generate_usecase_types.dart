/// Contains types for use cases that return a [Future].
///
/// The types are:
///
/// - [SimpleUseCase]: A use case that returns a [Future] of a success type.
/// - [UseCase]: A use case that returns a [Future] of a tuple containing a
///   failure type and a success type.
/// - [FpUseCase]: A use case that returns a [Future] of an [Either] of a failure
///   type and a success type.
///
/// The failure type is always a [Failure] and the success type is a type
/// parameter.
String generateFutureStyleUseCaseTypesTemplate() {
  return '''
import 'package:fpdart/fpdart.dart';

import '../errors/failure.dart';

/// A use case that returns a [Future] of a success type.
///
/// The use case takes a parameter of type [Params] and returns a [Future]
/// of a success type.
abstract interface class SimpleUseCase<SucessType, Params> {
  /// Calls the use case with the given [params] and returns a [Future]
  /// of a success type.
  Future<SucessType> call(Params params);
}

/// A use case that returns a [Future] of a tuple containing a failure type
/// and a success type.
///
/// The use case takes a parameter of type [Params] and returns a [Future]
/// of a tuple containing a failure type and a success type.
abstract interface class UseCase<SucessType, Params> {
  /// Calls the use case with the given [params] and returns a [Future]
  /// of a tuple containing a failure type and a success type.
  Future<(Failure?, SucessType?)> call(Params params);
}

/// A use case that returns a [Future] of an [Either] of a failure type and
/// a success type.
///
/// The use case takes a parameter of type [Params] and returns a [Future]
/// of an [Either] of a failure type and a success type.
abstract interface class FpUseCase<SucessType, Params> {
  /// Calls the use case with the given [params] and returns a [Future]
  /// of an [Either] of a failure type and a success type.
  Future<Either<Failure, SucessType>> call(Params params);
}
''';
}

String generateStreamStyleUseCaseTypesTemplate() {
  return '''
import 'package:fpdart/fpdart.dart';
import '../errors/failure.dart';

/// This file defines the stream style use case types for handling asynchronous operations
/// that return streams of success or error results.

/// A use case that returns a [Stream] of a success type.
///
/// This use case is designed for operations that emit a continuous stream
/// of successful values. It takes a parameter of type [Params] and returns
/// a [Stream] of a success type.
abstract interface class SimpleStreamUseCase<SucessType, Params> {
  /// Executes the use case with the provided [params] and returns a [Stream]
  /// of a success type.
  Stream<SucessType> call(Params params);
}

/// A use case that returns a [Stream] of a tuple containing a failure type
/// and a success type.
///
/// This use case is suitable for operations that may emit both successful
/// and failed results over time. It takes a parameter of type [Params] and
/// returns a [Stream] of a tuple containing a failure type and a success type.
abstract interface class StreamUseCase<SucessType, Params> {
  /// Executes the use case with the provided [params] and returns a [Stream]
  /// of a tuple containing a failure type and a success type.
  Stream<(Failure?, SucessType?)> call(Params params);
}

/// A use case that returns a [Stream] of an [Either] of a failure type and
/// a success type.
///
/// This use case is ideal for operations where each emitted value is either
/// a success or a failure. It takes a parameter of type [Params] and returns
/// a [Stream] of an [Either] of a failure type and a success type.
abstract interface class FpStreamUseCase<SucessType, Params> {
  /// Executes the use case with the provided [params] and returns a [Stream]
  /// of an [Either] of a failure type and a success type.
  Stream<Either<Failure, SucessType>> call(Params params);
}
''';
}
