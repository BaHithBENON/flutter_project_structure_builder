import 'package:get/get.dart'

// UseCases
import '../src/features/authentication/usecases/get_user_otp_usecase.dart';
import '../src/features/authentication/usecases/verify_user_otp_usecase.dart';
import '../src/features/authentication/usecases/verify_user_existence_usecase.dart';
import '../src/features/user_profile/usecases/get_user_profile_usecase.dart';
import '../src/features/user_profile/usecases/update_user_profile_usecase.dart';
import '../src/features/settings/usecases/get_settings_usecase.dart';
import '../src/features/settings/usecases/get_language_usecase.dart';
import '../src/features/settings/usecases/update_settings_usecase.dart';
import '../src/features/notifications/usecases/get_notifications_usecase.dart';


// Repositories
import '../src/features/authentication/repositories/authentication_repository.dart';
import '../src/features/authentication/repositories/authentication_repository_impl.dart';
import '../src/features/user_profile/repositories/user_profile_repository.dart';
import '../src/features/user_profile/repositories/user_profile_repository_impl.dart';
import '../src/features/settings/repositories/settings_repository.dart';
import '../src/features/settings/repositories/settings_repository_impl.dart';
import '../src/features/notifications/repositories/notifications_repository.dart';
import '../src/features/notifications/repositories/notifications_repository_impl.dart';
import '../src/features/analytics/repositories/analytics_repository.dart';
import '../src/features/analytics/repositories/analytics_repository_impl.dart';


// Datasources


// Controllers
import '../src/features/authentication/controllers/authentication_controller.dart';
import '../src/features/user_profile/controllers/user_profile_controller.dart';
import '../src/features/settings/controllers/settings_controller.dart';
import '../src/features/notifications/controllers/notifications_controller.dart';
import '../src/features/analytics/controllers/analytics_controller.dart';


part 'app_bindings.main.dart';
 