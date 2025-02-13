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
