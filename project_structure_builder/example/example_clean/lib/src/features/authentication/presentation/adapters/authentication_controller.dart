import 'package:get/get.dart';

// UseCases
import '../../domain/usecases/get_user_otp_usecase.dart';
import '../../domain/usecases/verify_user_otp_usecase.dart';
import '../../domain/usecases/verify_user_existence_usecase.dart';


class AuthenticationController extends GetxController {

  final GetUserOtpUseCase getUserOtpUseCase;
  final VerifyUserOtpUseCase verifyUserOtpUseCase;
  final VerifyUserExistenceUseCase verifyUserExistenceUseCase;

  AuthenticationController({
     required this.getUserOtpUseCase,
      required this.verifyUserOtpUseCase,
      required this.verifyUserExistenceUseCase
  });

}
