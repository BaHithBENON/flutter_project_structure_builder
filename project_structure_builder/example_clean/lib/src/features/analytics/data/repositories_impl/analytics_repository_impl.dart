import '../../../../core/errors/failure.dart';


import '../../domain/entities/entity_analytics.dart';
import '../../domain/repositories/analytics_repository.dart';
import '../data_sources/analytics_data_source.dart';

/// A class that implements [AnalyticsRepository].
///
/// The class is named [AnalyticsRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class AnalyticsRepositoryImpl implements AnalyticsRepository {

  final AnalyticsDataSource dataSource;
  const AnalyticsRepositoryImpl(this.dataSource);



}
