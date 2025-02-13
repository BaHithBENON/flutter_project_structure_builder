import '../models/model_authentication.dart';

abstract class AuthenticationDataSource {

  Future<ModelAuthentication?> getUserOtp({ required String email });
  Future<ModelAuthentication?> verifyUserOtp({ required String email, required String otp });
  Future<ModelAuthentication?> verifyUserExistence();

}
