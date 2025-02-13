import '../models/model_user_profile.dart';

abstract class UserProfileDataSource {

  Stream<ModelUserProfile?> getUserProfile({ required int id });
  Future<ModelUserProfile?> updateUserProfile({ required int id, required String username, required String profilePicture, required String bio });

}
