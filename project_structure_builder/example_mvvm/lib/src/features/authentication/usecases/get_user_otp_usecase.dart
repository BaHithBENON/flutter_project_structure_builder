import '../models/model_authentication.dart'; 
import '../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/authentication_repository.dart';

/// A concrete implementation of [AuthenticationUseCase] with parameters.
///
/// This class requires a [AuthenticationRepository] to function.
/// It calls the repository method with the given parameters.
class GetUserOtpUseCase implements SimpleUseCase<ModelAuthentication?, GetUserOtpUseCaseParams> {

  /// Repository to interact with data layer.
  final AuthenticationRepository repository;

  /// Constructor for the use case, requiring a [AuthenticationRepository].
  const GetUserOtpUseCase({required this.repository});

  /// Implements [AuthenticationUseCase.call].
  ///
  /// The method takes a [GetUserOtpUseCaseParams] as a parameter and returns a [Stream] or [Future]
  /// depending on the value of [usecaseType].
  @override
  Future<ModelAuthentication?> call(GetUserOtpUseCaseParams params) async {
    return await repository.getUserOtp(email: params.email);
  }
}

/// Parameter class for [GetUserOtpUseCase].
///
/// This class holds the attributes required by the use case method.
class GetUserOtpUseCaseParams {
  final String email;

  /// Constructor for [GetUserOtpUseCaseParams].
  const GetUserOtpUseCaseParams({ required this.email });
}
