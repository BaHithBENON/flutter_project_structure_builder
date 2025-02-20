import '../entities/entity_settings.dart';
import '../repositories/settings_repository.dart';
import '../../../../core/resources/params.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


/// A concrete implementation of [SettingsUseCase].
///
/// The constructor takes a [SettingsRepository] as a parameter.
/// The method [call] takes a [NoParams] as a parameter and returns a [Future] or [Stream]
/// depending on the value of [usecaseTypes[usecase]].
class GetSettingsUseCase implements UseCase<EntitySettings, NoParams> {

  /// The constructor takes a [SettingsRepository] as a parameter.
  final SettingsRepository repository;
  const GetSettingsUseCase({required this.repository});

  /// The method takes a [NoParams] as a parameter and returns a [Future] or [Stream]
  /// depending on the value of [usecaseTypes[usecase]].
  @override
  Future<(Failure?, EntitySettings?)> call(NoParams params) async {
    return await repository.getSettings();
  }
}

