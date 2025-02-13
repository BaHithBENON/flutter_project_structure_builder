import '../entities/entity_authentication.dart';
import '../repositories/authentication_repository.dart';
import '../../../../core/resources/params.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


/// A concrete implementation of [AuthenticationUseCase].
///
/// The constructor takes a [AuthenticationRepository] as a parameter.
/// The method [call] takes a [NoParams] as a parameter and returns a [Future] or [Stream]
/// depending on the value of [usecaseTypes[usecase]].
class VerifyUserExistenceUseCase implements UseCase<EntityAuthentication, NoParams> {

  /// The constructor takes a [AuthenticationRepository] as a parameter.
  final AuthenticationRepository repository;
  const VerifyUserExistenceUseCase({required this.repository});

  /// The method takes a [NoParams] as a parameter and returns a [Future] or [Stream]
  /// depending on the value of [usecaseTypes[usecase]].
  @override
  Future<(Failure?, EntityAuthentication?)> call(NoParams params) async {
    return await repository.verifyUserExistence();
  }
}

