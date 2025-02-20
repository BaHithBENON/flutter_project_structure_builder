import '../../../../core/errors/failure.dart';


import '../../domain/entities/entity_authentication.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../data_sources/authentication_data_source.dart';

/// A class that implements [AuthenticationRepository].
///
/// The class is named [AuthenticationRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class AuthenticationRepositoryImpl implements AuthenticationRepository {

  final AuthenticationDataSource dataSource;
  const AuthenticationRepositoryImpl(this.dataSource);

  /// Implements [AuthenticationRepository.getUserOtp].
  ///
  /// The method calls [AuthenticationDataSource.getUserOtp]
  /// and returns the result as a tuple of [Failure] and [EntityAuthentication].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntityAuthentication?)> getUserOtp({ required String email }) async {
    try {
      final result = await dataSource.getUserOtp(email: email);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [AuthenticationRepository.verifyUserOtp].
  ///
  /// The method calls [AuthenticationDataSource.verifyUserOtp]
  /// and returns the result as a tuple of [Failure] and [EntityAuthentication].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntityAuthentication?)> verifyUserOtp({ required String email, required String otp }) async {
    try {
      final result = await dataSource.verifyUserOtp(email: email, otp: otp);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [AuthenticationRepository.verifyUserExistence].
  ///
  /// The method calls [AuthenticationDataSource.verifyUserExistence]
  /// and returns the result as a tuple of [Failure] and [EntityAuthentication].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntityAuthentication?)> verifyUserExistence() async {
    try {
      final result = await dataSource.verifyUserExistence();
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }


}
