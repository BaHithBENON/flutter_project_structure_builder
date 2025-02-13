import '../models/model_user_profile.dart'; 
import '../../../core/usecases_types/stream_style_use_case_types.dart';
import '../repositories/user_profile_repository.dart';

/// A concrete implementation of [UserProfileUseCase] with parameters.
///
/// This class requires a [UserProfileRepository] to function.
/// It calls the repository method with the given parameters.
class GetUserProfileUseCase implements SimpleStreamUseCase<ModelUserProfile?, GetUserProfileUseCaseParams> {

  /// Repository to interact with data layer.
  final UserProfileRepository repository;

  /// Constructor for the use case, requiring a [UserProfileRepository].
  const GetUserProfileUseCase({required this.repository});

  /// Implements [UserProfileUseCase.call].
  ///
  /// The method takes a [GetUserProfileUseCaseParams] as a parameter and returns a [Stream] or [Future]
  /// depending on the value of [usecaseType].
  @override
  Stream<ModelUserProfile?> call(GetUserProfileUseCaseParams params)  {
    return  repository.getUserProfile(id: params.id);
  }
}

/// Parameter class for [GetUserProfileUseCase].
///
/// This class holds the attributes required by the use case method.
class GetUserProfileUseCaseParams {
  final int id;

  /// Constructor for [GetUserProfileUseCaseParams].
  const GetUserProfileUseCaseParams({ required this.id });
}
