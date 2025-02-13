part of 'app_bindings.dart';

/// AppBinding class which extends GetX Bindings
///
/// This class specifies the dependencies required by the app,
/// and uses the list of feature bindings generated above.
class AppBinding extends Bindings {

  /// Overrides the dependencies method to register all dependencies
  @override
  void dependencies() {

        /*
      * Authentication Controller
    */
    Get.lazyPut<AuthenticationRepository>(() => AuthenticationRepositoryImpl(Get.find()));
      Get.lazyPut<AuthenticationDataSource>(() => AuthenticationDataSourceImpl());
      Get.lazyPut<GetUserOtpUseCase>(() => GetUserOtpUseCase(repository: Get.find(),));
    Get.lazyPut<VerifyUserOtpUseCase>(() => VerifyUserOtpUseCase(repository: Get.find(),));
    Get.lazyPut<VerifyUserExistenceUseCase>(() => VerifyUserExistenceUseCase(repository: Get.find(),));
    Get.put(AuthenticationController(
      getUserOtpUseCase: Get.find<GetUserOtpUseCase>(),
      verifyUserOtpUseCase: Get.find<VerifyUserOtpUseCase>(),
      verifyUserExistenceUseCase: Get.find<VerifyUserExistenceUseCase>(),
    ));


    /*
      * UserProfile Controller
    */
    Get.lazyPut<UserProfileRepository>(() => UserProfileRepositoryImpl(Get.find()));
      Get.lazyPut<UserProfileDataSource>(() => UserProfileDataSourceImpl());
      Get.lazyPut<GetUserProfileUseCase>(() => GetUserProfileUseCase(repository: Get.find(),));
    Get.lazyPut<UpdateUserProfileUseCase>(() => UpdateUserProfileUseCase(repository: Get.find(),));
    Get.put(UserProfileController(
      getUserProfileUseCase: Get.find<GetUserProfileUseCase>(),
      updateUserProfileUseCase: Get.find<UpdateUserProfileUseCase>(),
    ));


    /*
      * Settings Controller
    */
    Get.lazyPut<SettingsRepository>(() => SettingsRepositoryImpl(Get.find()));
      Get.lazyPut<SettingsDataSource>(() => SettingsDataSourceImpl());
      Get.lazyPut<GetSettingsUseCase>(() => GetSettingsUseCase(repository: Get.find(),));
    Get.lazyPut<GetLanguageUseCase>(() => GetLanguageUseCase(repository: Get.find(),));
    Get.lazyPut<UpdateSettingsUseCase>(() => UpdateSettingsUseCase(repository: Get.find(),));
    Get.put(SettingsController(
      getSettingsUseCase: Get.find<GetSettingsUseCase>(),
      getLanguageUseCase: Get.find<GetLanguageUseCase>(),
      updateSettingsUseCase: Get.find<UpdateSettingsUseCase>(),
    ));


    /*
      * Notifications Controller
    */
    Get.lazyPut<NotificationsRepository>(() => NotificationsRepositoryImpl(Get.find()));
      Get.lazyPut<NotificationsDataSource>(() => NotificationsDataSourceImpl());
      Get.lazyPut<GetNotificationsUseCase>(() => GetNotificationsUseCase(repository: Get.find(),));
    Get.put(NotificationsController(
      getNotificationsUseCase: Get.find<GetNotificationsUseCase>(),
    ));


    /*
      * Analytics Controller
    */
    Get.lazyPut<AnalyticsRepository>(() => AnalyticsRepositoryImpl(Get.find()));
      Get.lazyPut<AnalyticsDataSource>(() => AnalyticsDataSourceImpl());
      Get.put(AnalyticsController(
      
    ));


  }

}
