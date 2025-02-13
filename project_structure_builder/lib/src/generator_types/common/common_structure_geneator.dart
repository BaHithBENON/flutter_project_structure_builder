import '../../enums.dart';
import '../../functions.dart';
import 'common_template_generator.dart';

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

  void generateStructure() {


    // Création des dossiers et fichiers principaux
    CommonFunctions.instance.createDir("$projectName/lib/src/core/services");
    CommonFunctions.instance.createDir("$projectName/lib/src/core/configs");

    CommonFunctions.instance.createDir("$projectName/lib/src/di");
    CommonFunctions.instance.createFile("$projectName/lib/src/di/${architecture == ArchitectureTypes.mvvmArchitecture ? "viewmodels" : "controllers"}_provider.dart", 
      CommonTemplateGenerator.instance.controllerProviderTemplate(
        stateManagement: stateManagement, 
        features: features,
        projectName: projectName,
        featuresStrategy: featuresStrategy,
        architecture: architecture,
      ),
    );


    CommonFunctions.instance.createDir("$projectName/lib/src/shared");
    CommonFunctions.instance.createDir("$projectName/lib/src/shared/properties");
    CommonFunctions.instance.createDir("$projectName/lib/src/shared/ui");
    CommonFunctions.instance.createDir("$projectName/lib/src/shared/ui/widgets");
    CommonFunctions.instance.createDir("$projectName/lib/src/shared/ui/functions");
    CommonFunctions.instance.createDir("$projectName/lib/src/shared/ui/extensions");




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

    CommonFunctions.instance.createFile("$projectName/lib/init_env.dart", 
      CommonTemplateGenerator.instance.initEnvTemplate(featuresStrategy: featuresStrategy));








    final corePath = CommonFunctions.instance.getCorePath(projectName: projectName, featuresStrategy: featuresStrategy);

    CommonFunctions.instance.createDir("$corePath/logs");
    CommonFunctions.instance.createFile("$corePath/logs/custom_logger.dart", 
      CommonTemplateGenerator.instance.appLoggerTemplate());

    CommonFunctions.instance.createDir("$corePath/errors");
    CommonFunctions.instance.createFile("$corePath/errors/error_types.dart", 
      CommonTemplateGenerator.instance.errorTypesTemplate());
    CommonFunctions.instance.createFile("$corePath/errors/failure.dart", 
      CommonTemplateGenerator.instance.failureTemplate());
    CommonFunctions.instance.createFile("$corePath/errors/app_exception.dart", 
      CommonTemplateGenerator.instance.appExceptionTemplate());
    CommonFunctions.instance.createFile("$corePath/errors/app_error.dart", 
      CommonTemplateGenerator.instance.appErrorTemplate());

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

    CommonFunctions.instance.createDir("$corePath/usecases_types");
    CommonFunctions.instance.createFile("$corePath/usecases_types/future_style_use_case_types.dart", 
      CommonTemplateGenerator.instance.futureStyleUseCaseTypesTemplate());
    CommonFunctions.instance.createFile("$corePath/usecases_types/stream_style_use_case_types.dart", 
      CommonTemplateGenerator.instance.streamStyleUseCaseTypesTemplate());

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









    CommonFunctions.instance.createDir("$projectName/envs");
    CommonFunctions.instance.createFile("$projectName/envs/.env.all", 
      CommonTemplateGenerator.instance.envTargetFileTemplate(envsList: envsList));
    for (var env in envsList) {
      CommonFunctions.instance.createFile("$projectName/envs/.env.${CommonFunctions.instance.camelCase(env)}", 
        CommonTemplateGenerator.instance.envFileTemplate(envVariables: envVariables));
    }

    CommonFunctions.instance.createFile("$projectName/lib/init_dependencies.dart", 
      CommonTemplateGenerator.instance.initDependenciesTemplate(stateManagement: stateManagement, featuresStrategy: featuresStrategy));
    CommonFunctions.instance.createFile("$projectName/lib/init_dependencies.main.dart", 
      CommonTemplateGenerator.instance.initDependenciesMainTemplate(stateManagement: stateManagement));
  }
  
}