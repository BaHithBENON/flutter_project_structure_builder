import 'package:get/get.dart';

// UseCases
import '../usecases/get_user_profile_usecase.dart';
import '../usecases/update_user_profile_usecase.dart';


class UserProfileController extends GetxController {

  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;

  UserProfileController({
     required this.getUserProfileUseCase,
      required this.updateUserProfileUseCase
  });

}
