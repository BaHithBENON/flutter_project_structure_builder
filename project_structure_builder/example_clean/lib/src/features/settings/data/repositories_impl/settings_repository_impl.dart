import '../../../../core/errors/failure.dart';


import '../../domain/entities/entity_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../data_sources/settings_data_source.dart';

/// A class that implements [SettingsRepository].
///
/// The class is named [SettingsRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class SettingsRepositoryImpl implements SettingsRepository {

  final SettingsDataSource dataSource;
  const SettingsRepositoryImpl(this.dataSource);

  /// Implements [SettingsRepository.getSettings].
  ///
  /// The method calls [SettingsDataSource.getSettings]
  /// and returns the result as a tuple of [Failure] and [EntitySettings].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntitySettings?)> getSettings() async {
    try {
      final result = await dataSource.getSettings();
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [SettingsRepository.getLanguage].
  ///
  /// The method calls [SettingsDataSource.getLanguage]
  /// and returns the result as a tuple of [Failure] and [EntitySettings].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Stream<(Failure?, EntitySettings?)> getLanguage()  {
    try {
      
      return dataSource.getLanguage()
        .map((datas) {
          return (null, datas?.toEntity());
      });

    } catch (e) {
      rethrow;
    }
  }

  /// Implements [SettingsRepository.updateSettings].
  ///
  /// The method calls [SettingsDataSource.updateSettings]
  /// and returns the result as a tuple of [Failure] and [EntitySettings].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntitySettings?)> updateSettings({ required bool notificationsEnabled, required String language, required String theme }) async {
    try {
      final result = await dataSource.updateSettings(notificationsEnabled: notificationsEnabled, language: language, theme: theme);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }


}
