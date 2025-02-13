import 'package:get/get.dart';

// UseCases
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/update_user_profile_usecase.dart';


class UserProfileController extends GetxController {

  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;

  UserProfileController({
     required this.getUserProfileUseCase,
      required this.updateUserProfileUseCase
  });

}
