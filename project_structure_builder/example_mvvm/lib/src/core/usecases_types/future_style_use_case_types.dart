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
