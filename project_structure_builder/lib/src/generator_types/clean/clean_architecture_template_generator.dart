import '../../attribute_format.dart';
import '../../enums.dart';
import '_generate_clean_data_source_impl_template.dart';
import '_generate_clean_data_source_template.dart';
import '_generate_clean_entity_template.dart';
import '_generate_clean_model_template.dart';
import '_generate_clean_repository_impl_template.dart';
import '_generate_clean_repository_template.dart';
import '_generate_clean_usecase_template.dart';

class CleanArchitectureTemplateGenerator {

  // Instance unique du singleton
  static final CleanArchitectureTemplateGenerator instance = CleanArchitectureTemplateGenerator._internal();

  // Constructeur privé
  const CleanArchitectureTemplateGenerator._internal();

  String cleanEntityTemplate({required String feature, List<AttributeFormat> attributes = const []}) 
    => generateCleanEntityTemplate(feature: feature, attributes: attributes);

  String cleanModelTemplate({required String feature, List<AttributeFormat> attributes = const [], required FeaturesStrategy featuresStrategy,}) 
    => generateCleanModelTemplate(feature: feature, attributes: attributes, featuresStrategy: featuresStrategy);

  String cleanDataSourceTemplate({
    required List<String> usecases,
    required Map<String, UseCaseType> usecaseTypes,
    required Map<String, List<AttributeFormat>> usecaseAttributes,
    required String feature,
  }) => generateCleanDataSourceTemplate(feature: feature, usecases: usecases, usecaseAttributes: usecaseAttributes, usecaseTypes: usecaseTypes);
  
  String cleanDataSourceImplTemplate({required String feature,required List<String> usecases,
    required Map<String, UseCaseType> usecaseTypes,
    required Map<String, List<AttributeFormat>> usecaseAttributes,
  }) => generateCleanDataSourceImplTemplate(feature: feature, usecases: usecases, usecaseAttributes: usecaseAttributes, usecaseTypes: usecaseTypes);

  String cleanRepositoryTemplate({
    required List<String> usecases,
    required Map<String, UseCaseType> usecaseTypes,
    required Map<String, List<AttributeFormat>> usecaseAttributes,
    required String feature, required FeaturesStrategy featuresStrategy,
  }) => generateCleanRepositoryTemplate(usecases: usecases, usecaseTypes: usecaseTypes, usecaseAttributes: usecaseAttributes, feature: feature, featuresStrategy: featuresStrategy);

  String cleanRepositoryImplTemplate({
    required List<String> usecases,
    required Map<String, UseCaseType> usecaseTypes,
    required Map<String, List<AttributeFormat>> usecaseAttributes,
    required String feature, required FeaturesStrategy featuresStrategy,
  }) => generateCleanRepositoryImplTemplate(usecases: usecases, usecaseTypes: usecaseTypes, usecaseAttributes: usecaseAttributes, feature: feature, featuresStrategy: featuresStrategy);
  
  String cleanUseCaseTemplate({
    required String usecase, required UseCaseType usecaseType, List<AttributeFormat> attributes = const [],
    required String feature, required FeaturesStrategy featuresStrategy,
  }) => attributes.isEmpty ? generateCleanUseCaseTemplate(usecase: usecase, usecaseType: usecaseType, feature: feature, featuresStrategy: featuresStrategy) 
    : generateCleanUseCaseTemplateWithAttributes(usecase: usecase, usecaseType: usecaseType, attributes: attributes, feature: feature, featuresStrategy: featuresStrategy);

}
