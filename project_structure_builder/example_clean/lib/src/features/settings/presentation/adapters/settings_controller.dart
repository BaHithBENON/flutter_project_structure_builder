import 'package:get/get.dart';

// UseCases
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/get_language_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';


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
