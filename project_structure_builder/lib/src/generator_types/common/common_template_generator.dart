import '../../attribute_format.dart';
import '../../custom_types.dart';
import '../../enums.dart';
import '_generate_app_logger_template.dart';
import '_generate_binding_template.dart';
import '_generate_controller_template.dart';
import '_generate_core_params_template.dart';
import '_generate_database_attributs_template.dart';
import '_generate_env_file_template.dart';
import '_generate_errors_template.dart';
import '_generate_init_dependencies_template.dart';
import '_generate_init_envs_template.dart';
import '_generate_usecase_types.dart';
import '_generate_utils_files_template.dart';

class CommonTemplateGenerator {
  
  static final CommonTemplateGenerator instance = CommonTemplateGenerator._internal();
  const CommonTemplateGenerator._internal();

  String controllerTemplate({
  required String feature, required StateManagementTypes stateManagement, List<String> usecases = const [], required FeaturesStrategy featuresStrategy, required ArchitectureTypes architecture,
  }) => generateControllerTemplate(feature: feature, stateManagement: stateManagement, usecases: usecases,featuresStrategy: featuresStrategy, architecture: architecture);

  String controllerProviderTemplate({
    required StateManagementTypes stateManagement, required List<String> features, required String projectName, required FeaturesStrategy featuresStrategy, 
    required ArchitectureTypes architecture,
  }) => generateControllerProviderTemplate(stateManagement: stateManagement, features: features, projectName: projectName, featuresStrategy: featuresStrategy, architecture: architecture);

  String bindingTemplate({
    required List<FeaturesBlocsType> featuresBlocs, required FeaturesStrategy featuresStrategy, required String projectName, required ArchitectureTypes architecture,
  }) => generateBindingTemplate(featuresBlocs: featuresBlocs, featuresStrategy: featuresStrategy, projectName: projectName, architecture: architecture);

  String bindingMainTemplate({
    required List<FeaturesBlocsType> featuresBlocs, required ArchitectureTypes architecture,
  }) => generateBindingMainTemplate(featuresBlocs: featuresBlocs, architecture: architecture);

  String envFileTemplate({required List<String> envVariables}) => generateEnvFileTemplate(envVariables: envVariables);

  String envTargetFileTemplate({required List<String> envsList}) => generateEnvTargetFileTemplate(envsList: envsList);

  String errorTypesTemplate() => generateErrorTypesTemplate();
  String appExceptionTemplate() => generateAppExceptionTemplate();
  String failureTemplate() => generateFailureTemplate();
  String appErrorTemplate() => generateAppErrorTemplate();

  String futureStyleUseCaseTypesTemplate() => generateFutureStyleUseCaseTypesTemplate();
  String streamStyleUseCaseTypesTemplate() => generateStreamStyleUseCaseTypesTemplate();

  String coreParamsTemplate() => generateCoreParamsTemplate();

  String databaseAttributesResources({required List<AttributeFormat> attributes}) => generateDatabaseAttributesResources(attributes: attributes);

  String appLoggerTemplate() => generateAppLoggerTemplate();

  String initDependenciesTemplate({required StateManagementTypes stateManagement, required FeaturesStrategy featuresStrategy}) 
    => generateInitDependenciesTemplate(stateManagement: stateManagement, featuresStrategy: featuresStrategy);
  String initDependenciesMainTemplate({required StateManagementTypes stateManagement}) 
    => generateInitDependenciesMainTemplate(stateManagement: stateManagement);

  String initEnvTemplate({required FeaturesStrategy featuresStrategy}) => generateInitEnvTemplate(featuresStrategy: featuresStrategy);
  String envDatasTemplate({required FeaturesStrategy featuresStrategy, required List<String> envsList, required List<String> envVariables})
    => generateEnvDatasTemplate(featuresStrategy: featuresStrategy, envsList: envsList, envVariables: envVariables);
  String envLoaderTemplate({required FeaturesStrategy featuresStrategy}) 
    => generateEnvLoaderTemplate(featuresStrategy: featuresStrategy);
  String envObjectTemplate({required FeaturesStrategy featuresStrategy, required List<String> envVariables}) 
    => generateEnvObjectTemplate(featuresStrategy: featuresStrategy, envVariables: envVariables);

  // Utils
  String appConstantsUtilsTemplate() => generateAppConstantsUtilsTemplate();
  String appStringsUtilsTemplate() => generateAppStringsUtilsTemplate();
  String fontsNamesUtilsTemplate() => generateFontsNamesUtilsTemplate();
  String imagesSourcesUtilsTemplate() => generateImagesSourcesUtilsTemplate();
  String routesUtilsTemplate({required StateManagementTypes stateManagement}) => generateRoutesUtilsTemplate(stateManagement: stateManagement);
  String textUtilsTemplate() => generateTextUtilsTemplate();
}