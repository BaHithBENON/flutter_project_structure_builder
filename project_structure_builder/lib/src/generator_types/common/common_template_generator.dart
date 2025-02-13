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

/// A generator for common application templates.
///
/// This class provides methods to generate various components of an application
/// based on different architectures, state management solutions, and feature strategies.
/// It includes templates for controllers, bindings, environment files, error handling,
/// use cases, and utility classes.

class CommonTemplateGenerator {
  
  static final CommonTemplateGenerator instance = CommonTemplateGenerator._internal();
  const CommonTemplateGenerator._internal();

  /// Generates a controller template for a given [feature].
  ///
  /// The generated controller is valid for both the MVC and MVVM architectures.
  ///
  /// If [stateManagement] is [StateManagementTypes.getx], the generated controller
  /// extends [GetxController] and uses GetX's built-in state management features.
  ///
  /// If [stateManagement] is [StateManagementTypes.riverpod], the generated controller
  /// extends [AutoDisposeStateNotifier] and uses Riverpod's built-in state management features.
  ///
  /// If [usecases] is not empty, the generated controller contains one abstract method
  /// for each usecase in [usecases].
  ///
  /// The generated controller is a valid implementation of
  /// [${CommonFunctions.instance.capitalize(feature)}Controller] and can be used as a
  /// starting point for implementing the controller for the feature.
  String controllerTemplate({
    required String feature, required StateManagementTypes stateManagement, List<String> usecases = const [], required FeaturesStrategy featuresStrategy, required ArchitectureTypes architecture,
  }) => generateControllerTemplate(feature: feature, stateManagement: stateManagement, usecases: usecases,featuresStrategy: featuresStrategy, architecture: architecture);

  /// Generates a controller provider template for the given [features].
  ///
  /// The generated template is a class that extends [GetxController] and contains
  /// a static getter for each feature in [features]. The getter returns an instance
  /// of the corresponding controller.
  ///
  /// If [stateManagement] is [StateManagementTypes.getx], the generated controller
  /// provider uses GetX's built-in state management features.
  ///
  /// If [stateManagement] is [StateManagementTypes.riverpod], the generated controller
  /// provider uses Riverpod's built-in state management features.
  ///
  /// The generated controller provider is a valid implementation of
  /// [ControllerProvider] and can be used as a starting point for implementing
  /// the controller provider for the features.
  String controllerProviderTemplate({
    required StateManagementTypes stateManagement, required List<String> features, required String projectName, required FeaturesStrategy featuresStrategy, 
    required ArchitectureTypes architecture,
  }) => generateControllerProviderTemplate(stateManagement: stateManagement, features: features, projectName: projectName, featuresStrategy: featuresStrategy, architecture: architecture);

  /// Generates the binding template for the application.
  ///
  /// The generated file contains the imports for the repositories, datasources,
  /// usecases and controllers.
  ///
  /// The generated file is used as a part of the app bindings.
  ///
  /// The generated binding template is based on the features and the state management type.
  /// If the state management type is [StateManagementTypes.getx], the generated binding
  /// template uses GetX's built-in state management features.
  ///
  /// If the state management type is [StateManagementTypes.riverpod], the generated binding
  /// template uses Riverpod's built-in state management features.
  ///
  /// The generated binding template is a valid implementation of
  /// [AppBinding] and can be used as a starting point for implementing
  /// the app bindings for the features.
  String bindingTemplate({
    required List<FeaturesBlocsType> featuresBlocs, required FeaturesStrategy featuresStrategy, required String projectName, required ArchitectureTypes architecture,
  }) => generateBindingTemplate(featuresBlocs: featuresBlocs, featuresStrategy: featuresStrategy, projectName: projectName, architecture: architecture);

  /// Generates the main binding template for the application.
  ///
  /// The generated file contains the bindings for the controllers and the usecases.
  ///
  /// The generated file is used as a part of the app bindings.
  ///
  /// The generated binding template is based on the features and the architecture type.
  /// If the architecture type is [ArchitectureTypes.cleanArchitecture], the generated binding
  /// template uses the clean architecture bindings.
  ///
  /// If the architecture type is [ArchitectureTypes.mvcArchitecture], the generated binding
  /// template uses the MVC architecture bindings.
  ///
  /// The generated binding template is a valid implementation of
  /// [AppBinding] and can be used as a starting point for implementing
  /// the app bindings for the features.
  String bindingMainTemplate({
    required List<FeaturesBlocsType> featuresBlocs, required ArchitectureTypes architecture,
  }) => generateBindingMainTemplate(featuresBlocs: featuresBlocs, architecture: architecture);

  /// Generates the environment file template.
  ///
  /// The generated template contains key/value pairs for each environment
  /// variable, with values left empty.
  ///
  /// [envVariables] List of environment variable names to include in the template.
  ///
  /// Returns a string representing the contents of the environment file.
  String envFileTemplate({required List<String> envVariables}) 
    => generateEnvFileTemplate(envVariables: envVariables);

  /// Generates the environment target file template.
  ///
  /// The generated template sets the first environment from [envsList] as the default.
  /// The value can be modified to any environment from the list as needed.
  ///
  /// [envsList] List of environment names to include in the template.
  ///
  /// Returns a string representing the contents of the environment target file.
  String envTargetFileTemplate({required List<String> envsList}) 
    => generateEnvTargetFileTemplate(envsList: envsList);

  /// Generates the error types template.
  ///
  /// The generated template includes an enumeration of different types of errors
  /// that can occur in the app. It provides constants to identify each error type
  /// and includes a constructor and a [toString] method.
  ///
  /// Returns a string representing the error types enumeration.
  String errorTypesTemplate() 
    => generateErrorTypesTemplate();
  
  /// Generates the app exception template.
  ///
  /// The generated template includes a class that represents an exception that
  /// can occur in the app. It provides properties to identify the type of
  /// exception and includes a constructor and a [toString] method.
  ///
  /// Returns a string representing the app exception class.
  String appExceptionTemplate() 
    => generateAppExceptionTemplate();
  
  /// Generates the failure template.
  ///
  /// The generated template includes a class that represents a failure in the app.
  /// It provides a single property, [message], which is a string describing
  /// the failure. It also includes a constructor and a [toString] method.
  ///
  /// Returns a string representing the failure class.
  String failureTemplate() 
    => generateFailureTemplate();
  
  /// Generates the app error template.
  ///
  /// The generated template includes a sealed class that represents an app error.
  /// It provides two properties, [error] and [failure], which are an enumeration
  /// of different types of errors that can occur in the app and a failure object
  /// that describes the error, respectively. It also includes a constructor and a
  /// [toString] method.
  ///
  /// Returns a string representing the app error class.
  String appErrorTemplate() 
    => generateAppErrorTemplate();

  /// Generates the future style use case types template.
  ///
  /// The generated template contains an interface for each of the
  /// [SimpleUseCase], [UseCase], and [FpUseCase] types. Each interface
  /// defines a single method, [call], which returns a [Future] of either
  /// a [SimpleUseCase] or an [Either] of a failure type and a success type.
  ///
  /// Returns a string representing the future style use case types interface.
  String futureStyleUseCaseTypesTemplate() 
    => generateFutureStyleUseCaseTypesTemplate();
  
  /// Generates the stream style use case types template.
  ///
  /// The generated template contains an interface for each of the
  /// [SimpleStreamUseCase], [StreamUseCase], and [FpStreamUseCase] types. Each
  /// interface defines a single method, [call], which returns a [Stream] of
  /// either a [SimpleStreamUseCase], a [StreamUseCase], or an [Either] of a
  /// failure type and a success type.
  ///
  /// Returns a string representing the stream style use case types interface.
  String streamStyleUseCaseTypesTemplate() 
    => generateStreamStyleUseCaseTypesTemplate();

  /// Generates the core parameters template.
  ///
  /// The core parameters template contains the [NoParams] class, which is used to
  /// represent no parameters, and the [VoidType] class, which is used to represent
  /// a void type.
  ///
  /// Returns a string representing the core parameters template.
  String coreParamsTemplate() 
    => generateCoreParamsTemplate();

  /// Generates the database attributes resources template.
  ///
  /// The generated template contains a class, [DatabaseAttributesResources], with
  /// static constants for each of the attributes provided. The constants are
  /// named with the same name as the attribute, and their values are the raw
  /// names of the attributes.
  ///
  /// [attributes] is a list of attributes that define the database attributes.
  /// Returns a string representing the database attributes resources template.
  String databaseAttributesResources({required List<AttributeFormat> attributes}) 
    => generateDatabaseAttributesResources(attributes: attributes);

  /// Generates the app logger template.
  ///
  /// The app logger template contains a class, [AppLogger], which is used to
  /// log messages in the application. The class has a single static instance,
  /// [INSTANCE], which is used to log messages.
  ///
  /// Returns a string representing the app logger template.
  String appLoggerTemplate() 
    => generateAppLoggerTemplate();

  /// Generates the template for the init dependencies file.
  ///
  /// The generated template depends on the state management type and the features
  /// strategy. If the state management type is [StateManagementTypes.getX], it will
  /// import the get_it package. If the features strategy is
  /// [FeaturesStrategy.independantModules], it will import the custom logger from
  /// the core module. Otherwise, it will import it from the src/core/logs folder.
  ///
  /// Returns a string which is the template for the init dependencies file.
  String initDependenciesTemplate({required StateManagementTypes stateManagement, required FeaturesStrategy featuresStrategy}) 
    => generateInitDependenciesTemplate(stateManagement: stateManagement, featuresStrategy: featuresStrategy);

  /// Generates the main dependencies initialization template.
  ///
  /// The generated template depends on the state management type.
  /// If the state management type is [StateManagementTypes.getX], it will include
  /// initialization for the GetX service locator.
  ///
  /// Returns a string that is the main template for initializing dependencies.
  String initDependenciesMainTemplate({required StateManagementTypes stateManagement}) 
    => generateInitDependenciesMainTemplate(stateManagement: stateManagement);

  /// Generates the InitEnv class template.
  ///
  /// The generated InitEnv class is responsible for initializing the environment
  /// variables.
  ///
  /// The generated class is based on the features strategy.
  ///
  /// Returns a string which is the template for the InitEnv class.
  String initEnvTemplate({required FeaturesStrategy featuresStrategy}) 
    => generateInitEnvTemplate(featuresStrategy: featuresStrategy);

  /// Generates the EnvDatas class template.
  ///
  /// The generated EnvDatas class is responsible for storing the environment data.
  ///
  /// The generated class is based on the features strategy and the environment
  /// variables.
  ///
  /// [featuresStrategy] is the features strategy.
  /// [envsList] is the list of environment names.
  /// [envVariables] is the list of environment variables.
  ///
  /// Returns a string which is the template for the EnvDatas class.
  String envDatasTemplate({required FeaturesStrategy featuresStrategy, required List<String> envsList, required List<String> envVariables})
    => generateEnvDatasTemplate(featuresStrategy: featuresStrategy, envsList: envsList, envVariables: envVariables);

  /// Generates the EnvLoader class template.
  ///
  /// The generated EnvLoader class is responsible for loading the environment
  /// variables.
  ///
  /// The generated class is based on the features strategy.
  ///
  /// [featuresStrategy] is the features strategy.
  ///
  /// Returns a string which is the template for the EnvLoader class.
  String envLoaderTemplate({required FeaturesStrategy featuresStrategy}) 
    => generateEnvLoaderTemplate(featuresStrategy: featuresStrategy);

  /// Generates the EnvObject class template.
  ///
  /// The EnvObject class is responsible for providing access to environment
  /// variables based on the specified features strategy and list of environment
  /// variables.
  ///
  /// [featuresStrategy] determines how the features are organized.
  /// [envVariables] is a list of environment variable names to include in the
  /// EnvObject class.
  ///
  /// Returns a string representing the EnvObject class template.
  String envObjectTemplate({required FeaturesStrategy featuresStrategy, required List<String> envVariables}) 
    => generateEnvObjectTemplate(featuresStrategy: featuresStrategy, envVariables: envVariables);

  // Utils
  /// Generates the AppConstantsUtils class template.
  ///
  /// The AppConstantsUtils class contains constant values that are used
  /// throughout the application.
  ///
  /// Returns a string which is the template for the AppConstantsUtils class.
  String appConstantsUtilsTemplate() 
    => generateAppConstantsUtilsTemplate();

  /// Generates the AppStringsUtils class template.
  ///
  /// The AppStringsUtils class provides string utilities that are used
  /// throughout the application, such as the application name and version.
  ///
  /// Returns a string representing the AppStringsUtils class template.
  String appStringsUtilsTemplate() 
    => generateAppStringsUtilsTemplate();

  /// Generates the FontsNamesUtils class template.
  ///
  /// The FontsNamesUtils class provides constants for the font names used in the
  /// application.
  ///
  /// Returns a string which is the template for the FontsNamesUtils class.
  String fontsNamesUtilsTemplate() 
    => generateFontsNamesUtilsTemplate();

  /// Generates the ImagesSourcesUtils class template.
  ///
  /// The ImagesSourcesUtils class provides utility methods for accessing image
  /// sources in the application.
  ///
  /// Returns a string which is the template for the ImagesSourcesUtils class.
  String imagesSourcesUtilsTemplate() 
    => generateImagesSourcesUtilsTemplate();

  /// Generates the RoutesUtils class template.
  ///
  /// The RoutesUtils class provides utility methods for navigating between
  /// pages in the application.
  ///
  /// [stateManagement] determines how the pages are managed.
  ///
  /// Returns a string which is the template for the RoutesUtils class.
  String routesUtilsTemplate({required StateManagementTypes stateManagement}) 
    => generateRoutesUtilsTemplate(stateManagement: stateManagement);

  /// Generates the TextUtils class template.
  ///
  /// The TextUtils class provides utility methods for working with text in the
  /// application, such as removing HTML tags from a string.
  ///
  /// Returns a string which is the template for the TextUtils class.
  String textUtilsTemplate() 
    => generateTextUtilsTemplate();
}