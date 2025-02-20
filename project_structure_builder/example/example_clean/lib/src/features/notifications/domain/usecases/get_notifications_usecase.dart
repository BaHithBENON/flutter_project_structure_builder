import '../entities/entity_notifications.dart';
import '../repositories/notifications_repository.dart';
import '../../../../core/resources/params.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/stream_style_use_case_types.dart';


/// A concrete implementation of [NotificationsUseCase].
///
/// The constructor takes a [NotificationsRepository] as a parameter.
/// The method [call] takes a [NoParams] as a parameter and returns a [Future] or [Stream]
/// depending on the value of [usecaseTypes[usecase]].
class GetNotificationsUseCase implements StreamUseCase<EntityNotifications, NoParams> {

  /// The constructor takes a [NotificationsRepository] as a parameter.
  final NotificationsRepository repository;
  const GetNotificationsUseCase({required this.repository});

  /// The method takes a [NoParams] as a parameter and returns a [Future] or [Stream]
  /// depending on the value of [usecaseTypes[usecase]].
  @override
  Stream<(Failure?, EntityNotifications?)> call(NoParams params)  {
    return  repository.getNotifications();
  }
}

