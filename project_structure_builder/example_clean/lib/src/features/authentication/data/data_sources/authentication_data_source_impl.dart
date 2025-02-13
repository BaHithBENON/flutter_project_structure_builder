import 'authentication_data_source.dart';
import '../models/model_authentication.dart';

class AuthenticationDataSourceImpl implements AuthenticationDataSource {

  @override
  Future<ModelAuthentication?> getUserOtp({ required String email }) async {
    // TODO: implement getUserOtp
    throw UnimplementedError();
  }



  @override
  Future<ModelAuthentication?> verifyUserOtp({ required String email, required String otp }) async {
    // TODO: implement verifyUserOtp
    throw UnimplementedError();
  }



  @override
  Future<ModelAuthentication?> verifyUserExistence() async {
    // TODO: implement verifyUserExistence
    throw UnimplementedError();
  }



}
