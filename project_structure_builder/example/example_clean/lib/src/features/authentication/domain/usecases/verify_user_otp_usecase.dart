import '../entities/entity_authentication.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


import '../repositories/authentication_repository.dart';

/// A concrete implementation of [AuthenticationUseCase] with parameters.
///
/// This class requires a [AuthenticationRepository] to function.
/// It calls the repository method with the given parameters.
class VerifyUserOtpUseCase implements UseCase<EntityAuthentication, VerifyUserOtpUseCaseParams> {

  /// Repository to interact with data layer.
  final AuthenticationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const VerifyUserOtpUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityAuthentication?)> call(VerifyUserOtpUseCaseParams params) async {
    return await repository.verifyUserOtp(email: params.email, otp: params.otp);
  }
}

/// Parameter class for [VerifyUserOtpUseCase].
///
/// Contains all the attributes required for the use case.
class VerifyUserOtpUseCaseParams {
  final String email;
  final String otp;

  /// Creates an instance of [VerifyUserOtpUseCaseParams].
    const VerifyUserOtpUseCaseParams({ required this.email, required this.otp });
}
