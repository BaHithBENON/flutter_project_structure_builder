import '../models/model_settings.dart'; 
import '../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/settings_repository.dart';

/// A concrete implementation of [SettingsUseCase] with parameters.
///
/// This class requires a [SettingsRepository] to function.
/// It calls the repository method with the given parameters.
class UpdateSettingsUseCase implements SimpleUseCase<ModelSettings?, UpdateSettingsUseCaseParams> {

  /// Repository to interact with data layer.
  final SettingsRepository repository;

  /// Constructor for the use case, requiring a [SettingsRepository].
  const UpdateSettingsUseCase({required this.repository});

  /// Implements [SettingsUseCase.call].
  ///
  /// The method takes a [UpdateSettingsUseCaseParams] as a parameter and returns a [Stream] or [Future]
  /// depending on the value of [usecaseType].
  @override
  Future<ModelSettings?> call(UpdateSettingsUseCaseParams params) async {
    return await repository.updateSettings(notificationsEnabled: params.notificationsEnabled, language: params.language, theme: params.theme);
  }
}

/// Parameter class for [UpdateSettingsUseCase].
///
/// This class holds the attributes required by the use case method.
class UpdateSettingsUseCaseParams {
  final bool notificationsEnabled;
  final String language;
  final String theme;

  /// Constructor for [UpdateSettingsUseCaseParams].
  const UpdateSettingsUseCaseParams({ required this.notificationsEnabled, required this.language, required this.theme });
}
