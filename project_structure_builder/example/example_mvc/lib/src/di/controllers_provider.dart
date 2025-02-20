// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';


import '../features/authentication/controllers/authentication_controller.dart';
import '../features/user_profile/controllers/user_profile_controller.dart';
import '../features/settings/controllers/settings_controller.dart';
import '../features/notifications/controllers/notifications_controller.dart';
import '../features/analytics/controllers/analytics_controller.dart';


class ControllersProvider {

  static final AUTHENTICATION_CONTROLLER = Get.find<AuthenticationController>();
  static final USER_PROFILE_CONTROLLER = Get.find<UserProfileController>();
  static final SETTINGS_CONTROLLER = Get.find<SettingsController>();
  static final NOTIFICATIONS_CONTROLLER = Get.find<NotificationsController>();
  static final ANALYTICS_CONTROLLER = Get.find<AnalyticsController>();

}
