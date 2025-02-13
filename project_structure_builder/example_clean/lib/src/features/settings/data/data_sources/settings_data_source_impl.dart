import 'settings_data_source.dart';
import '../models/model_settings.dart';

class SettingsDataSourceImpl implements SettingsDataSource {

  @override
  Future<ModelSettings?> getSettings() async {
    // TODO: implement getSettings
    throw UnimplementedError();
  }



  @override
  Stream<ModelSettings?> getLanguage()  {
    // TODO: implement getLanguage
    throw UnimplementedError();
  }



  @override
  Future<ModelSettings?> updateSettings({ required bool notificationsEnabled, required String language, required String theme }) async {
    // TODO: implement updateSettings
    throw UnimplementedError();
  }



}
