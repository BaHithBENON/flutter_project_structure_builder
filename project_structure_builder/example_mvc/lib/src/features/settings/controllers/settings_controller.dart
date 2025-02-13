import 'package:get/get.dart';

// UseCases
import '../usecases/get_settings_usecase.dart';
import '../usecases/get_language_usecase.dart';
import '../usecases/update_settings_usecase.dart';


class SettingsController extends GetxController {

  final GetSettingsUseCase getSettingsUseCase;
  final GetLanguageUseCase getLanguageUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;

  SettingsController({
     required this.getSettingsUseCase,
      required this.getLanguageUseCase,
      required this.updateSettingsUseCase
  });

}
