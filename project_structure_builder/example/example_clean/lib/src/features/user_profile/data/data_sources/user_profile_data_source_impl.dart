import 'user_profile_data_source.dart';
import '../models/model_user_profile.dart';

class UserProfileDataSourceImpl implements UserProfileDataSource {

  @override
  Stream<ModelUserProfile?> getUserProfile({ required int id })  {
    // TODO: implement getUserProfile
    throw UnimplementedError();
  }



  @override
  Future<ModelUserProfile?> updateUserProfile({ required int id, required String username, required String profilePicture, required String bio }) async {
    // TODO: implement updateUserProfile
    throw UnimplementedError();
  }



}
