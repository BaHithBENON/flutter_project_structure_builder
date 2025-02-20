import '../entities/entity_user_profile.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


import '../repositories/user_profile_repository.dart';

/// A concrete implementation of [UserProfileUseCase] with parameters.
///
/// This class requires a [UserProfileRepository] to function.
/// It calls the repository method with the given parameters.
class UpdateUserProfileUseCase implements UseCase<EntityUserProfile, UpdateUserProfileUseCaseParams> {

  /// Repository to interact with data layer.
  final UserProfileRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const UpdateUserProfileUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityUserProfile?)> call(UpdateUserProfileUseCaseParams params) async {
    return await repository.updateUserProfile(id: params.id, username: params.username, profilePicture: params.profilePicture, bio: params.bio);
  }
}

/// Parameter class for [UpdateUserProfileUseCase].
///
/// Contains all the attributes required for the use case.
class UpdateUserProfileUseCaseParams {
  final int id;
  final String username;
  final String profilePicture;
  final String bio;

  /// Creates an instance of [UpdateUserProfileUseCaseParams].
    const UpdateUserProfileUseCaseParams({ required this.id, required this.username, required this.profilePicture, required this.bio });
}
