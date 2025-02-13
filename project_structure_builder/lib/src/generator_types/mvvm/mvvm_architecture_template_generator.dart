import '../../attribute_format.dart';
import '../../enums.dart';
import '_generate_mvvm_repository_impl_template.dart';
import '_generate_mvvm_repository_template.dart';
import '_generate_mvvm_usecase_template.dart';
import '_generate_mvvm_model_template.dart';

class MvvmArchitectureTemplateGenerator {

  // Instance unique du singleton
  static final MvvmArchitectureTemplateGenerator instance = MvvmArchitectureTemplateGenerator._internal();

  // Constructeur privé
  const MvvmArchitectureTemplateGenerator._internal();

  String mvvmModelTemplate({required String feature, List<AttributeFormat> attributes = const []}) 
    => generateMvvmModelTemplate(feature: feature, attributes: attributes);

  String mvvmRepositoryTemplate({
    required List<String> usecases,
    required Map<String, UseCaseType> usecaseTypes,
    required Map<String, List<AttributeFormat>> usecaseAttributes,
    required String feature,
  }) => generateMvvmRepositoryTemplate(feature: feature, usecases: usecases, usecaseAttributes: usecaseAttributes, usecaseTypes: usecaseTypes);

  String mvvmRepositoryImplTemplate({
    required List<String> usecases,
    required Map<String, UseCaseType> usecaseTypes,
    required Map<String, List<AttributeFormat>> usecaseAttributes,
    required String feature,
  }) => generateMvvmRepositoryImplTemplate(usecases: usecases, usecaseTypes: usecaseTypes, usecaseAttributes: usecaseAttributes, feature: feature);

  String mvvmUseCaseTemplate({
    required String usecase, required UseCaseType usecaseType, List<AttributeFormat> attributes = const [],
    required String feature
  }) => attributes.isEmpty ? generateMvvmUseCaseTemplate(usecase: usecase, usecaseType: usecaseType, feature: feature) 
    : generateMvvmUseCaseTemplateWithAttributes(usecase: usecase, usecaseType: usecaseType, attributes: attributes, feature: feature);

}
