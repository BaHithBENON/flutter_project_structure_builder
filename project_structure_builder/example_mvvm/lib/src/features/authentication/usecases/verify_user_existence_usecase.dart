import '../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/authentication_repository.dart';
import '../../../core/resources/params.dart';
import '../models/model_authentication.dart'; 

/// A concrete implementation of [AuthenticationUseCase].
///
/// This class requires a [AuthenticationRepository] to function.
/// It calls the repository method with no parameters.
class VerifyUserExistenceUseCase implements SimpleUseCase<ModelAuthentication?, NoParams> {

  /// Repository to interact with data layer.
  final AuthenticationRepository repository;

  /// Constructor for the use case, requiring a [AuthenticationRepository].
  const VerifyUserExistenceUseCase({required this.repository});

  /// Implements [AuthenticationUseCase.call].
  ///
  /// The method takes a [NoParams] as a parameter and returns a [Stream] or a [Future] depending on the value of [usecaseTypes[usecase]].
  @override
  Future<ModelAuthentication?> call(NoParams params) async {
    return await repository.verifyUserExistence();
  }
}

