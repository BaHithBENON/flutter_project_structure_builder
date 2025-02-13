import '../../../../core/errors/failure.dart';


import '../../domain/entities/entity_notifications.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../data_sources/notifications_data_source.dart';

/// A class that implements [NotificationsRepository].
///
/// The class is named [NotificationsRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class NotificationsRepositoryImpl implements NotificationsRepository {

  final NotificationsDataSource dataSource;
  const NotificationsRepositoryImpl(this.dataSource);

  /// Implements [NotificationsRepository.getNotifications].
  ///
  /// The method calls [NotificationsDataSource.getNotifications]
  /// and returns the result as a tuple of [Failure] and [EntityNotifications].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Stream<(Failure?, EntityNotifications?)> getNotifications()  {
    try {
      
      return dataSource.getNotifications()
        .map((datas) {
          return (null, datas?.toEntity());
      });

    } catch (e) {
      rethrow;
    }
  }


}
