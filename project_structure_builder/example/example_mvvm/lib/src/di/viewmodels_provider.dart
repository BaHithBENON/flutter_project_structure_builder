// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';


import '../features/authentication/viewmodels/authentication_viewmodel.dart';
import '../features/user_profile/viewmodels/user_profile_viewmodel.dart';
import '../features/settings/viewmodels/settings_viewmodel.dart';
import '../features/notifications/viewmodels/notifications_viewmodel.dart';
import '../features/analytics/viewmodels/analytics_viewmodel.dart';


class ViewModelsProvider {

  static final AUTHENTICATION_VIEWMODEL = Get.find<AuthenticationViewModel>();
  static final USER_PROFILE_VIEWMODEL = Get.find<UserProfileViewModel>();
  static final SETTINGS_VIEWMODEL = Get.find<SettingsViewModel>();
  static final NOTIFICATIONS_VIEWMODEL = Get.find<NotificationsViewModel>();
  static final ANALYTICS_VIEWMODEL = Get.find<AnalyticsViewModel>();

}
