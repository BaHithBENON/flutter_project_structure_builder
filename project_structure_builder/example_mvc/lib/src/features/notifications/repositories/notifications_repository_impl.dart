import '../models/model_notifications.dart';
import 'notifications_repository.dart';

/// A class that implements [NotificationsRepository].
///
/// This class is a valid implementation of [NotificationsRepository]
/// and can be used as a starting point for implementing the repository for the feature.
class NotificationsRepositoryImpl implements NotificationsRepository {

  /// Implements [NotificationsRepository.getNotifications].
  ///
  /// The method takes as arguments the attributes of the usecase and returns
  /// a [Future] or [Stream] depending on the value of [usecaseTypes[usecase]].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Stream<ModelNotifications?> getNotifications()  {
    // TODO: implement getNotifications
    throw UnimplementedError();
  }


}
