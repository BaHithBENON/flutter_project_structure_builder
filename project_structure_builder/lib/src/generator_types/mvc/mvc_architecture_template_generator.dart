import '../../attribute_format.dart';
import '../../enums.dart';
import '_generate_mvc_repository_impl_template.dart';
import '_generate_mvc_repository_template.dart';
import '_generate_mvc_usecase_template.dart';
import '_generate_mvc_model_template.dart';

class MvcArchitectureTemplateGenerator {

  // Instance unique du singleton
  static final MvcArchitectureTemplateGenerator instance = MvcArchitectureTemplateGenerator._internal();

  // Constructeur privé
  const MvcArchitectureTemplateGenerator._internal();

  String mvcModelTemplate({required String feature, List<AttributeFormat> attributes = const []}) 
    => generateMvcModelTemplate(feature: feature, attributes: attributes);

  String mvcRepositoryTemplate({
    required List<String> usecases,
    required Map<String, UseCaseType> usecaseTypes,
    required Map<String, List<AttributeFormat>> usecaseAttributes,
    required String feature,
  }) => generateMvcRepositoryTemplate(feature: feature, usecases: usecases, usecaseAttributes: usecaseAttributes, usecaseTypes: usecaseTypes);

  String mvcRepositoryImplTemplate({
    required List<String> usecases,
    required Map<String, UseCaseType> usecaseTypes,
    required Map<String, List<AttributeFormat>> usecaseAttributes,
    required String feature,
  }) => generateMvcRepositoryImplTemplate(usecases: usecases, usecaseTypes: usecaseTypes, usecaseAttributes: usecaseAttributes, feature: feature);

  String mvcUseCaseTemplate({
    required String usecase, required UseCaseType usecaseType, List<AttributeFormat> attributes = const [],
    required String feature
  }) => attributes.isEmpty ? generateMvcUseCaseTemplate(usecase: usecase, usecaseType: usecaseType, feature: feature) 
    : generateMvcUseCaseTemplateWithAttributes(usecase: usecase, usecaseType: usecaseType, attributes: attributes, feature: feature);

}
