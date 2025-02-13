import 'package:get/get.dart';

// UseCases
import '../usecases/get_notifications_usecase.dart';


class NotificationsViewModel extends GetxController {

  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationsViewModel({
     required this.getNotificationsUseCase
  });

}
