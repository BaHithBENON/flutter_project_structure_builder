import '../models/model_authentication.dart';
/// An abstract class that represents a repository for the feature [Authentication].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [AuthenticationRepository] and can be used as a
/// starting point for implementing the repository for the feature.
abstract class AuthenticationRepository {

  Future<ModelAuthentication?> getUserOtp({ required String email });
  Future<ModelAuthentication?> verifyUserOtp({ required String email, required String otp });
  Future<ModelAuthentication?> verifyUserExistence();

}
