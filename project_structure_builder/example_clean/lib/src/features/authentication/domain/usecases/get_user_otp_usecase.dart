import '../entities/entity_authentication.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


import '../repositories/authentication_repository.dart';

/// A concrete implementation of [AuthenticationUseCase] with parameters.
///
/// This class requires a [AuthenticationRepository] to function.
/// It calls the repository method with the given parameters.
class GetUserOtpUseCase implements UseCase<EntityAuthentication, GetUserOtpUseCaseParams> {

  /// Repository to interact with data layer.
  final AuthenticationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetUserOtpUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityAuthentication?)> call(GetUserOtpUseCaseParams params) async {
    return await repository.getUserOtp(email: params.email);
  }
}

/// Parameter class for [GetUserOtpUseCase].
///
/// Contains all the attributes required for the use case.
class GetUserOtpUseCaseParams {
  final String email;

  /// Creates an instance of [GetUserOtpUseCaseParams].
    const GetUserOtpUseCaseParams({ required this.email });
}
