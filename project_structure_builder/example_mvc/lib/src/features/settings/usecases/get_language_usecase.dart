import '../../../core/usecases_types/stream_style_use_case_types.dart';
import '../repositories/settings_repository.dart';
import '../../../core/resources/params.dart';
import '../models/model_settings.dart'; 

/// A concrete implementation of [SettingsUseCase].
///
/// This class requires a [SettingsRepository] to function.
/// It calls the repository method with no parameters.
class GetLanguageUseCase implements SimpleStreamUseCase<ModelSettings?, NoParams> {

  /// Repository to interact with data layer.
  final SettingsRepository repository;

  /// Constructor for the use case, requiring a [SettingsRepository].
  const GetLanguageUseCase({required this.repository});

  /// Implements [SettingsUseCase.call].
  ///
  /// The method takes a [NoParams] as a parameter and returns a [Stream] or a [Future] depending on the value of [usecaseTypes[usecase]].
  @override
  Stream<ModelSettings?> call(NoParams params)  {
    return  repository.getLanguage();
  }
}

