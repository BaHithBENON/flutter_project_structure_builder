import '../models/model_settings.dart';

abstract class SettingsDataSource {

  Future<ModelSettings?> getSettings();
  Stream<ModelSettings?> getLanguage();
  Future<ModelSettings?> updateSettings({ required bool notificationsEnabled, required String language, required String theme });

}
