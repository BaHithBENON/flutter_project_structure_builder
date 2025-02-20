import '../models/model_user_profile.dart'; 
import '../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/user_profile_repository.dart';

/// A concrete implementation of [UserProfileUseCase] with parameters.
///
/// This class requires a [UserProfileRepository] to function.
/// It calls the repository method with the given parameters.
class UpdateUserProfileUseCase implements SimpleUseCase<ModelUserProfile?, UpdateUserProfileUseCaseParams> {

  /// Repository to interact with data layer.
  final UserProfileRepository repository;

  /// Constructor for the use case, requiring a [UserProfileRepository].
  const UpdateUserProfileUseCase({required this.repository});

  /// Implements [UserProfileUseCase.call].
  ///
  /// The method takes a [UpdateUserProfileUseCaseParams] as a parameter and returns a [Stream] or [Future]
  /// depending on the value of [usecaseType].
  @override
  Future<ModelUserProfile?> call(UpdateUserProfileUseCaseParams params) async {
    return await repository.updateUserProfile(id: params.id, username: params.username, profilePicture: params.profilePicture, bio: params.bio);
  }
}

/// Parameter class for [UpdateUserProfileUseCase].
///
/// This class holds the attributes required by the use case method.
class UpdateUserProfileUseCaseParams {
  final int id;
  final String username;
  final String profilePicture;
  final String bio;

  /// Constructor for [UpdateUserProfileUseCaseParams].
  const UpdateUserProfileUseCaseParams({ required this.id, required this.username, required this.profilePicture, required this.bio });
}
