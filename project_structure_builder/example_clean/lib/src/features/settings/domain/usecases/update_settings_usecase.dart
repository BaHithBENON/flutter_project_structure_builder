import '../entities/entity_settings.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


import '../repositories/settings_repository.dart';

/// A concrete implementation of [SettingsUseCase] with parameters.
///
/// This class requires a [SettingsRepository] to function.
/// It calls the repository method with the given parameters.
class UpdateSettingsUseCase implements UseCase<EntitySettings, UpdateSettingsUseCaseParams> {

  /// Repository to interact with data layer.
  final SettingsRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const UpdateSettingsUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntitySettings?)> call(UpdateSettingsUseCaseParams params) async {
    return await repository.updateSettings(notificationsEnabled: params.notificationsEnabled, language: params.language, theme: params.theme);
  }
}

/// Parameter class for [UpdateSettingsUseCase].
///
/// Contains all the attributes required for the use case.
class UpdateSettingsUseCaseParams {
  final bool notificationsEnabled;
  final String language;
  final String theme;

  /// Creates an instance of [UpdateSettingsUseCaseParams].
    const UpdateSettingsUseCaseParams({ required this.notificationsEnabled, required this.language, required this.theme });
}
