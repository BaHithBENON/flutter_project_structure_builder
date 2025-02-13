/// An abstract class that represents a repository for the feature [Notifications].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [NotificationsRepository] and can be used as a
/// starting point for implementing the repository for the feature.
import '../../../../core/errors/failure.dart';


import '../entities/entity_notifications.dart';

abstract class NotificationsRepository {

  Stream<(Failure?, EntityNotifications?)> getNotifications();

}
