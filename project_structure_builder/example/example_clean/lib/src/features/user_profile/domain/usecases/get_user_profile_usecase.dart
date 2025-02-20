import '../entities/entity_user_profile.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/stream_style_use_case_types.dart';


import '../repositories/user_profile_repository.dart';

/// A concrete implementation of [UserProfileUseCase] with parameters.
///
/// This class requires a [UserProfileRepository] to function.
/// It calls the repository method with the given parameters.
class GetUserProfileUseCase implements StreamUseCase<EntityUserProfile, GetUserProfileUseCaseParams> {

  /// Repository to interact with data layer.
  final UserProfileRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetUserProfileUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Stream<(Failure?, EntityUserProfile?)> call(GetUserProfileUseCaseParams params)  {
    return  repository.getUserProfile(id: params.id);
  }
}

/// Parameter class for [GetUserProfileUseCase].
///
/// Contains all the attributes required for the use case.
class GetUserProfileUseCaseParams {
  final int id;

  /// Creates an instance of [GetUserProfileUseCaseParams].
    const GetUserProfileUseCaseParams({ required this.id });
}
