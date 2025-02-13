import '../../enums.dart';
import '../../functions.dart';
import 'common_template_generator.dart';

/// This class generates the common structure for a project based on the specified architecture, 
/// features, state management, and other configurations. It creates necessary directories and files 
/// for core, shared, and environment components, facilitating an organized and maintainable codebase.

class CommonStructureGenerator {

  final String projectName;
  final List<String> features;
  final FeaturesStrategy featuresStrategy;
  final StateManagementTypes stateManagement;
  final Map<String, dynamic> config;
  final ArchitectureTypes architecture;
  final List<String> envVariables;
  final List<String> envsList;

  const CommonStructureGenerator({
    required this.projectName,
    required this.features,
    required this.featuresStrategy,
    required this.stateManagement,
    required this.config,
    required this.architecture,
    required this.envVariables,
    required this.envsList,
  });

  /// Generates the common structure for the project.
  ///
  /// This function creates necessary directories and files for the project's
  /// core, shared, and environment components based on the architecture and
  /// features specified.
  void generateStructure() {
    // Create core directories
    CommonFunctions.instance.createDir("$projectName/lib/src/core/services");
    CommonFunctions.instance.createDir("$projectName/lib/src/core/configs");

    // Create dependency injection directory and file
    CommonFunctions.instance.createDir("$projectName/lib/src/di");
    CommonFunctions.instance.createFile(
      "$projectName/lib/src/di/${architecture == ArchitectureTypes.mvvmArchitecture ? "viewmodels" : "controllers"}_provider.dart",
      CommonTemplateGenerator.instance.controllerProviderTemplate(
        stateManagement: stateManagement,
        features: features,
        projectName: projectName,
        featuresStrategy: featuresStrategy,
        architecture: architecture,
      ),
    );

    // Create shared directories
    CommonFunctions.instance.createDir("$projectName/lib/src/shared");
    CommonFunctions.instance.createDir("$projectName/lib/src/shared/properties");
    CommonFunctions.instance.createDir("$projectName/lib/src/shared/ui");
    CommonFunctions.instance.createDir("$projectName/lib/src/shared/ui/widgets");
    CommonFunctions.instance.createDir("$projectName/lib/src/shared/ui/functions");
    CommonFunctions.instance.createDir("$projectName/lib/src/shared/ui/extensions");

    // Create utility directories and files
    CommonFunctions.instance.createDir("$projectName/lib/src/core/utils");
    CommonFunctions.instance.createFile("$projectName/lib/src/core/utils/app_constants_utils.dart",
      CommonTemplateGenerator.instance.appConstantsUtilsTemplate());
    CommonFunctions.instance.createFile("$projectName/lib/src/core/utils/app_strings_utils.dart",
      CommonTemplateGenerator.instance.appStringsUtilsTemplate());
    CommonFunctions.instance.createFile("$projectName/lib/src/core/utils/fonts_names_utils.dart",
      CommonTemplateGenerator.instance.fontsNamesUtilsTemplate());
    CommonFunctions.instance.createFile("$projectName/lib/src/core/utils/images_sources_utils.dart",
      CommonTemplateGenerator.instance.imagesSourcesUtilsTemplate());
    CommonFunctions.instance.createFile("$projectName/lib/src/core/utils/routes_utils.dart",
      CommonTemplateGenerator.instance.routesUtilsTemplate(stateManagement: stateManagement));
    CommonFunctions.instance.createFile("$projectName/lib/src/core/utils/text_utils.dart",
      CommonTemplateGenerator.instance.textUtilsTemplate());

    // Create environment initialization file
    CommonFunctions.instance.createFile("$projectName/lib/init_env.dart",
      CommonTemplateGenerator.instance.initEnvTemplate(featuresStrategy: featuresStrategy));

    // Determine core path based on project name and feature strategy
    final corePath = CommonFunctions.instance.getCorePath(projectName: projectName, featuresStrategy: featuresStrategy);

    // Create logging directories and files
    CommonFunctions.instance.createDir("$corePath/logs");
    CommonFunctions.instance.createFile("$corePath/logs/custom_logger.dart",
      CommonTemplateGenerator.instance.appLoggerTemplate());

    // Create error handling directories and files
    CommonFunctions.instance.createDir("$corePath/errors");
    CommonFunctions.instance.createFile("$corePath/errors/error_types.dart",
      CommonTemplateGenerator.instance.errorTypesTemplate());
    CommonFunctions.instance.createFile("$corePath/errors/failure.dart",
      CommonTemplateGenerator.instance.failureTemplate());
    CommonFunctions.instance.createFile("$corePath/errors/app_exception.dart",
      CommonTemplateGenerator.instance.appExceptionTemplate());
    CommonFunctions.instance.createFile("$corePath/errors/app_error.dart",
      CommonTemplateGenerator.instance.appErrorTemplate());

    // Create resource directories and files
    CommonFunctions.instance.createDir("$corePath/resources");
    CommonFunctions.instance.createFile("$corePath/resources/params.dart",
      CommonTemplateGenerator.instance.coreParamsTemplate());
    CommonFunctions.instance.createFile("$corePath/resources/database_attributes_resources.dart",
      CommonTemplateGenerator.instance.databaseAttributesResources(
        attributes: [
          ...features.map((feature) => CommonFunctions.instance.extractEntityAttributes(config, feature)).expand((e) => e),
        ],
      ),
    );

    // Create use case type directories and files
    CommonFunctions.instance.createDir("$corePath/usecases_types");
    CommonFunctions.instance.createFile("$corePath/usecases_types/future_style_use_case_types.dart",
      CommonTemplateGenerator.instance.futureStyleUseCaseTypesTemplate());
    CommonFunctions.instance.createFile("$corePath/usecases_types/stream_style_use_case_types.dart",
      CommonTemplateGenerator.instance.streamStyleUseCaseTypesTemplate());

    // Create environment directories and files
    CommonFunctions.instance.createDir("$corePath/envs");
    CommonFunctions.instance.createFile("$corePath/envs/env_datas.dart",
      CommonTemplateGenerator.instance.envDatasTemplate(
        featuresStrategy: featuresStrategy,
        envsList: envsList,
        envVariables: envVariables,
      ),
    );
    CommonFunctions.instance.createFile("$corePath/envs/env_loader.dart",
      CommonTemplateGenerator.instance.envLoaderTemplate(featuresStrategy: featuresStrategy));
    CommonFunctions.instance.createFile("$corePath/envs/env.dart",
      CommonTemplateGenerator.instance.envObjectTemplate(
        featuresStrategy: featuresStrategy,
        envVariables: envVariables,
      ),
    );

    // Create project environment directories and files
    CommonFunctions.instance.createDir("$projectName/envs");
    CommonFunctions.instance.createFile("$projectName/envs/.env.all",
      CommonTemplateGenerator.instance.envTargetFileTemplate(envsList: envsList));
    for (var env in envsList) {
      CommonFunctions.instance.createFile(
        "$projectName/envs/.env.${CommonFunctions.instance.camelCase(env)}",
        CommonTemplateGenerator.instance.envFileTemplate(envVariables: envVariables));
    }

    // Create initialization files
    CommonFunctions.instance.createFile("$projectName/lib/init_dependencies.dart",
      CommonTemplateGenerator.instance.initDependenciesTemplate(stateManagement: stateManagement, featuresStrategy: featuresStrategy));
    CommonFunctions.instance.createFile("$projectName/lib/init_dependencies.main.dart",
      CommonTemplateGenerator.instance.initDependenciesMainTemplate(stateManagement: stateManagement));
  }
  
}
