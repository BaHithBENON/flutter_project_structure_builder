String generateFutureStyleUseCaseTypesTemplate() {
  return '''
import 'package:fpdart/fpdart.dart';

import '../errors/failure.dart';

abstract interface class SimpleUseCase<SucessType, Params> {
  Future<SucessType> call(Params params);
}

abstract interface class UseCase<SucessType, Params> {
  Future<(Failure?, SucessType?)> call(Params params);
}

abstract interface class FpUseCase<SucessType, Params> {
  Future<Either<Failure, SucessType>> call(Params params);
}
''';
}

String generateStreamStyleUseCaseTypesTemplate() {
  return '''
import 'package:fpdart/fpdart.dart';

import '../errors/failure.dart';

abstract interface class SimpleStreamUseCase<SucessType, Params> {
  Stream<SucessType> call(Params params);
}

abstract interface class StreamUseCase<SucessType, Params> {
  Stream<(Failure?, SucessType?)> call(Params params);
}

abstract interface class FpStreamUseCase<SucessType, Params> {
  Stream<Either<Failure, SucessType>> call(Params params);
}
''';
}