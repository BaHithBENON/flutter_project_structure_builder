import '../models/model_settings.dart';
import 'settings_repository.dart';

/// A class that implements [SettingsRepository].
///
/// This class is a valid implementation of [SettingsRepository]
/// and can be used as a starting point for implementing the repository for the feature.
class SettingsRepositoryImpl implements SettingsRepository {

  /// Implements [SettingsRepository.getSettings].
  ///
  /// The method takes as arguments the attributes of the usecase and returns
  /// a [Future] or [Stream] depending on the value of [usecaseTypes[usecase]].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<ModelSettings?> getSettings() async {
    // TODO: implement getSettings
    throw UnimplementedError();
  }


  /// Implements [SettingsRepository.getLanguage].
  ///
  /// The method takes as arguments the attributes of the usecase and returns
  /// a [Future] or [Stream] depending on the value of [usecaseTypes[usecase]].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Stream<ModelSettings?> getLanguage()  {
    // TODO: implement getLanguage
    throw UnimplementedError();
  }


  /// Implements [SettingsRepository.updateSettings].
  ///
  /// The method takes as arguments the attributes of the usecase and returns
  /// a [Future] or [Stream] depending on the value of [usecaseTypes[usecase]].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<ModelSettings?> updateSettings({ required bool notificationsEnabled, required String language, required String theme }) async {
    // TODO: implement updateSettings
    throw UnimplementedError();
  }


}
