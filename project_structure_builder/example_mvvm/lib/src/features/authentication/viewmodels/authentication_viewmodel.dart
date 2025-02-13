import 'package:get/get.dart';

// UseCases
import '../usecases/get_user_otp_usecase.dart';
import '../usecases/verify_user_otp_usecase.dart';
import '../usecases/verify_user_existence_usecase.dart';


class AuthenticationViewModel extends GetxController {

  final GetUserOtpUseCase getUserOtpUseCase;
  final VerifyUserOtpUseCase verifyUserOtpUseCase;
  final VerifyUserExistenceUseCase verifyUserExistenceUseCase;

  AuthenticationViewModel({
     required this.getUserOtpUseCase,
      required this.verifyUserOtpUseCase,
      required this.verifyUserExistenceUseCase
  });

}
