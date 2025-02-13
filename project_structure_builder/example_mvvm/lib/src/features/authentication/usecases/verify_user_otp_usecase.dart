import '../models/model_authentication.dart'; 
import '../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/authentication_repository.dart';

/// A concrete implementation of [AuthenticationUseCase] with parameters.
///
/// This class requires a [AuthenticationRepository] to function.
/// It calls the repository method with the given parameters.
class VerifyUserOtpUseCase implements SimpleUseCase<ModelAuthentication?, VerifyUserOtpUseCaseParams> {

  /// Repository to interact with data layer.
  final AuthenticationRepository repository;

  /// Constructor for the use case, requiring a [AuthenticationRepository].
  const VerifyUserOtpUseCase({required this.repository});

  /// Implements [AuthenticationUseCase.call].
  ///
  /// The method takes a [VerifyUserOtpUseCaseParams] as a parameter and returns a [Stream] or [Future]
  /// depending on the value of [usecaseType].
  @override
  Future<ModelAuthentication?> call(VerifyUserOtpUseCaseParams params) async {
    return await repository.verifyUserOtp(email: params.email, otp: params.otp);
  }
}

/// Parameter class for [VerifyUserOtpUseCase].
///
/// This class holds the attributes required by the use case method.
class VerifyUserOtpUseCaseParams {
  final String email;
  final String otp;

  /// Constructor for [VerifyUserOtpUseCaseParams].
  const VerifyUserOtpUseCaseParams({ required this.email, required this.otp });
}
