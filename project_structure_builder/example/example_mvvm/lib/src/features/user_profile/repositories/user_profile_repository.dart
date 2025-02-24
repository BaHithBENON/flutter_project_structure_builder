import '../models/model_user_profile.dart';
/// An abstract class that represents a repository for the feature [UserProfile].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [UserProfileRepository] and can be used as a
/// starting point for implementing the repository for the feature.
abstract class UserProfileRepository {

  Stream<ModelUserProfile?> getUserProfile({ required int id });
  Future<ModelUserProfile?> updateUserProfile({ required int id, required String username, required String profilePicture, required String bio });

}
