import 'package:get/get.dart';

// UseCases
import '../../domain/usecases/get_notifications_usecase.dart';


class NotificationsController extends GetxController {

  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationsController({
     required this.getNotificationsUseCase
  });

}
