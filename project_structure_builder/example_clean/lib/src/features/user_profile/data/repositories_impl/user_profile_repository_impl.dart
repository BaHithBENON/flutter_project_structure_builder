import '../../../../core/errors/failure.dart';


import '../../domain/entities/entity_user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../data_sources/user_profile_data_source.dart';

/// A class that implements [UserProfileRepository].
///
/// The class is named [UserProfileRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class UserProfileRepositoryImpl implements UserProfileRepository {

  final UserProfileDataSource dataSource;
  const UserProfileRepositoryImpl(this.dataSource);

  /// Implements [UserProfileRepository.getUserProfile].
  ///
  /// The method calls [UserProfileDataSource.getUserProfile]
  /// and returns the result as a tuple of [Failure] and [EntityUserProfile].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Stream<(Failure?, EntityUserProfile?)> getUserProfile({ required int id })  {
    try {
      
      return dataSource.getUserProfile(id: id)
        .map((datas) {
          return (null, datas?.toEntity());
      });

    } catch (e) {
      rethrow;
    }
  }

  /// Implements [UserProfileRepository.updateUserProfile].
  ///
  /// The method calls [UserProfileDataSource.updateUserProfile]
  /// and returns the result as a tuple of [Failure] and [EntityUserProfile].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntityUserProfile?)> updateUserProfile({ required int id, required String username, required String profilePicture, required String bio }) async {
    try {
      final result = await dataSource.updateUserProfile(id: id, username: username, profilePicture: profilePicture, bio: bio);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }


}
