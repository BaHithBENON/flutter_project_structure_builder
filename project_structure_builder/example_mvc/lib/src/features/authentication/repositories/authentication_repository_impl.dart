import '../models/model_authentication.dart';
import 'authentication_repository.dart';

/// A class that implements [AuthenticationRepository].
///
/// This class is a valid implementation of [AuthenticationRepository]
/// and can be used as a starting point for implementing the repository for the feature.
class AuthenticationRepositoryImpl implements AuthenticationRepository {

  /// Implements [AuthenticationRepository.getUserOtp].
  ///
  /// The method takes as arguments the attributes of the usecase and returns
  /// a [Future] or [Stream] depending on the value of [usecaseTypes[usecase]].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<ModelAuthentication?> getUserOtp({ required String email }) async {
    // TODO: implement getUserOtp
    throw UnimplementedError();
  }


  /// Implements [AuthenticationRepository.verifyUserOtp].
  ///
  /// The method takes as arguments the attributes of the usecase and returns
  /// a [Future] or [Stream] depending on the value of [usecaseTypes[usecase]].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<ModelAuthentication?> verifyUserOtp({ required String email, required String otp }) async {
    // TODO: implement verifyUserOtp
    throw UnimplementedError();
  }


  /// Implements [AuthenticationRepository.verifyUserExistence].
  ///
  /// The method takes as arguments the attributes of the usecase and returns
  /// a [Future] or [Stream] depending on the value of [usecaseTypes[usecase]].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<ModelAuthentication?> verifyUserExistence() async {
    // TODO: implement verifyUserExistence
    throw UnimplementedError();
  }


}
