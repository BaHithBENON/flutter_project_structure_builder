import '../models/model_notifications.dart';

abstract class NotificationsDataSource {

  Stream<ModelNotifications?> getNotifications();

}
