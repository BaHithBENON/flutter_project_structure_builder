import '../../../core/usecases_types/stream_style_use_case_types.dart';
import '../repositories/notifications_repository.dart';
import '../../../core/resources/params.dart';
import '../models/model_notifications.dart'; 

/// A concrete implementation of [NotificationsUseCase].
///
/// This class requires a [NotificationsRepository] to function.
/// It calls the repository method with no parameters.
class GetNotificationsUseCase implements SimpleStreamUseCase<ModelNotifications?, NoParams> {

  /// Repository to interact with data layer.
  final NotificationsRepository repository;

  /// Constructor for the use case, requiring a [NotificationsRepository].
  const GetNotificationsUseCase({required this.repository});

  /// Implements [NotificationsUseCase.call].
  ///
  /// The method takes a [NoParams] as a parameter and returns a [Stream] or a [Future] depending on the value of [usecaseTypes[usecase]].
  @override
  Stream<ModelNotifications?> call(NoParams params)  {
    return  repository.getNotifications();
  }
}

