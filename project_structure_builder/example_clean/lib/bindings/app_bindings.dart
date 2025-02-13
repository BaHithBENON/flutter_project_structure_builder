import 'package:get/get.dart'

// UseCases
  import '../src/features/authentication/domain/usecases/get_user_otp_usecase.dart';
    import '../src/features/authentication/domain/usecases/verify_user_otp_usecase.dart';
    import '../src/features/authentication/domain/usecases/verify_user_existence_usecase.dart';
    import '../src/features/user_profile/domain/usecases/get_user_profile_usecase.dart';
    import '../src/features/user_profile/domain/usecases/update_user_profile_usecase.dart';
    import '../src/features/settings/domain/usecases/get_settings_usecase.dart';
    import '../src/features/settings/domain/usecases/get_language_usecase.dart';
    import '../src/features/settings/domain/usecases/update_settings_usecase.dart';
    import '../src/features/notifications/domain/usecases/get_notifications_usecase.dart';
  

// Repositories
import '../src/features/authentication/domain/repositories/authentication_repository.dart';
import '../src/features/authentication/data/repositories_impl/authentication_repository_impl.dart';
import '../src/features/user_profile/domain/repositories/user_profile_repository.dart';
import '../src/features/user_profile/data/repositories_impl/user_profile_repository_impl.dart';
import '../src/features/settings/domain/repositories/settings_repository.dart';
import '../src/features/settings/data/repositories_impl/settings_repository_impl.dart';
import '../src/features/notifications/domain/repositories/notifications_repository.dart';
import '../src/features/notifications/data/repositories_impl/notifications_repository_impl.dart';
import '../src/features/analytics/domain/repositories/analytics_repository.dart';
import '../src/features/analytics/data/repositories_impl/analytics_repository_impl.dart';


// Datasources
  import '../src/features/authentication/data/data_sources/authentication_data_source.dart';
  import '../src/features/authentication/data/data_sources/authentication_data_source_impl.dart';
    import '../src/features/user_profile/data/data_sources/user_profile_data_source.dart';
  import '../src/features/user_profile/data/data_sources/user_profile_data_source_impl.dart';
    import '../src/features/settings/data/data_sources/settings_data_source.dart';
  import '../src/features/settings/data/data_sources/settings_data_source_impl.dart';
    import '../src/features/notifications/data/data_sources/notifications_data_source.dart';
  import '../src/features/notifications/data/data_sources/notifications_data_source_impl.dart';
    import '../src/features/analytics/data/data_sources/analytics_data_source.dart';
  import '../src/features/analytics/data/data_sources/analytics_data_source_impl.dart';
  

// Controllers
import '../src/features/authentication/presentation/adapters/authentication_controller.dart';
import '../src/features/user_profile/presentation/adapters/user_profile_controller.dart';
import '../src/features/settings/presentation/adapters/settings_controller.dart';
import '../src/features/notifications/presentation/adapters/notifications_controller.dart';
import '../src/features/analytics/presentation/adapters/analytics_controller.dart';


part 'app_bindings.main.dart';
 