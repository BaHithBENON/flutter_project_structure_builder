import 'package:get/get.dart';

// UseCases
import '../usecases/get_user_profile_usecase.dart';
import '../usecases/update_user_profile_usecase.dart';


class UserProfileViewModel extends GetxController {

  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;

  UserProfileViewModel({
     required this.getUserProfileUseCase,
      required this.updateUserProfileUseCase
  });

}
