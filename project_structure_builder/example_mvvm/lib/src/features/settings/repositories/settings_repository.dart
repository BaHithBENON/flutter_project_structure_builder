import '../models/model_settings.dart';
/// An abstract class that represents a repository for the feature [Settings].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [SettingsRepository] and can be used as a
/// starting point for implementing the repository for the feature.
abstract class SettingsRepository {

  Future<ModelSettings?> getSettings();
  Stream<ModelSettings?> getLanguage();
  Future<ModelSettings?> updateSettings({ required bool notificationsEnabled, required String language, required String theme });

}
