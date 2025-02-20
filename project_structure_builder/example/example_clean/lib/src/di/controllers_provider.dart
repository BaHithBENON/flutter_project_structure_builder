// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';


import '../features/authentication/presentation/adapters/authentication_controller.dart';
import '../features/user_profile/presentation/adapters/user_profile_controller.dart';
import '../features/settings/presentation/adapters/settings_controller.dart';
import '../features/notifications/presentation/adapters/notifications_controller.dart';
import '../features/analytics/presentation/adapters/analytics_controller.dart';


class ControllersProvider {

  static final AUTHENTICATION_CONTROLLER = Get.find<AuthenticationController>();
  static final USER_PROFILE_CONTROLLER = Get.find<UserProfileController>();
  static final SETTINGS_CONTROLLER = Get.find<SettingsController>();
  static final NOTIFICATIONS_CONTROLLER = Get.find<NotificationsController>();
  static final ANALYTICS_CONTROLLER = Get.find<AnalyticsController>();

}
