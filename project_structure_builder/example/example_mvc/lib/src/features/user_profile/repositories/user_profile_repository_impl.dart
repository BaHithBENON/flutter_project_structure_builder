import '../models/model_user_profile.dart';
import 'user_profile_repository.dart';

/// A class that implements [UserProfileRepository].
///
/// This class is a valid implementation of [UserProfileRepository]
/// and can be used as a starting point for implementing the repository for the feature.
class UserProfileRepositoryImpl implements UserProfileRepository {

  /// Implements [UserProfileRepository.getUserProfile].
  ///
  /// The method takes as arguments the attributes of the usecase and returns
  /// a [Future] or [Stream] depending on the value of [usecaseTypes[usecase]].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Stream<ModelUserProfile?> getUserProfile({ required int id })  {
    // TODO: implement getUserProfile
    throw UnimplementedError();
  }


  /// Implements [UserProfileRepository.updateUserProfile].
  ///
  /// The method takes as arguments the attributes of the usecase and returns
  /// a [Future] or [Stream] depending on the value of [usecaseTypes[usecase]].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<ModelUserProfile?> updateUserProfile({ required int id, required String username, required String profilePicture, required String bio }) async {
    // TODO: implement updateUserProfile
    throw UnimplementedError();
  }


}
