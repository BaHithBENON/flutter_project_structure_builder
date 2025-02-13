import '../../attribute_format.dart';
import '../../custom_types.dart';
import '../../enums.dart';
import '../../functions.dart';
import '../common/common_template_generator.dart';
import '../mvc/mvc_architecture_template_generator.dart';
import 'mvvm_architecture_template_generator.dart';

class ProjectMvvmArchitectureGenerator {
  final String projectName;
  final List<String> features;
  final FeaturesStrategy featuresStrategy;
  final StateManagementTypes stateManagement;
  final Map<String, dynamic> config;

  const ProjectMvvmArchitectureGenerator({
    required this.projectName,
    required this.features,
    required this.featuresStrategy,
    required this.stateManagement,
    required this.config,
  });

  void generateStructure() {

    String featureStrategy = "$projectName/lib/src/features";

    CommonFunctions.instance.createDir(featureStrategy);
    
    CommonFunctions.instance.createDir("$projectName/lib/src/core/enums");

    // Création des fonctionnalités en MVVM Architecture
    for (var feature in features) {
      feature = CommonFunctions.instance.snakeCase(feature);

      _createFeature(
        feature, 
        featureStrategy: featureStrategy, 
        featurePresentationLayerPath: CommonFunctions.instance.getFeaturePresentationLayerPath(
          feature: feature, projectName: projectName, featuresStrategy: featuresStrategy, architecture: ArchitectureTypes.mvvmArchitecture
        ),
        usecases: CommonFunctions.instance.extractUseCasesForFeature(config, feature),
        entityAttributes: CommonFunctions.instance.extractEntityAttributes(config, feature),
      );
    }

    if (stateManagement == StateManagementTypes.getX) {
      CommonFunctions.instance.createDir("$projectName/lib/bindings");
      CommonFunctions.instance.createFile("$projectName/lib/bindings/app_bindings.dart", 
        CommonTemplateGenerator.instance.bindingTemplate(
          featuresBlocs: <FeaturesBlocsType>[
            for (var feature in features) 
              (
                CommonFunctions.instance.snakeCase(feature), 
                "${CommonFunctions.instance.capitalize(feature)}Repository", 
                "${CommonFunctions.instance.capitalize(feature)}DataSource", 
                [
                  ...CommonFunctions.instance.extractUseCasesForFeature(config, feature).map((u) => "${CommonFunctions.instance.camelCase(u.$1)}UseCase"),
                ], 
                CommonFunctions.instance.generateControllerClassName(feature: feature, architecture: ArchitectureTypes.mvvmArchitecture),
              )
          ],
          featuresStrategy: featuresStrategy,
          projectName: projectName,
          architecture: ArchitectureTypes.mvvmArchitecture,
        ),
      );
      CommonFunctions.instance.createFile("$projectName/lib/bindings/app_bindings.main.dart", 
        CommonTemplateGenerator.instance.bindingMainTemplate(
          featuresBlocs: <FeaturesBlocsType>[
            for (var feature in features) 
              (
                CommonFunctions.instance.snakeCase(feature), 
                "${CommonFunctions.instance.capitalize(feature)}Repository", 
                "${CommonFunctions.instance.capitalize(feature)}DataSource", 
                [
                  ...CommonFunctions.instance.extractUseCasesForFeature(config, feature).map((u) => CommonFunctions.instance.generateUseCaseClassName(u.$1)),
                ], 
                CommonFunctions.instance.generateControllerClassName(feature: feature, architecture: ArchitectureTypes.mvvmArchitecture),
              )
          ],
          architecture: ArchitectureTypes.mvvmArchitecture,
        ),
      );
    }

    print("✅ Structure du projet pour l´architecture ´´${ArchitectureTypes.mvvmArchitecture.name}´´ générée avec succès !");
  }

  void _createFeature(String feature, {
    required String featureStrategy, required String featurePresentationLayerPath, 
    List<(String, UseCaseType, List<AttributeFormat>)> usecases = const [],
    List<AttributeFormat> entityAttributes = const [],
  }) {
    
    final featurePath = CommonFunctions.instance.getFeaturePath(
      feature: feature, strategy: featureStrategy, featuresStrategy: featuresStrategy, projectName: projectName,
    );
    //
    
    CommonFunctions.instance.createDir("$featurePath/enums");
    CommonFunctions.instance.createDir("$featurePath/functions");
    
    CommonFunctions.instance.createDir("$featurePath/models");
    CommonFunctions.instance.createFile("$featurePath/models/model_$feature.dart", 
      MvvmArchitectureTemplateGenerator.instance.mvvmModelTemplate(feature: feature, attributes: entityAttributes));

    // Presentation Layer
    CommonFunctions.instance.createDir("$featurePath/data");
    CommonFunctions.instance.createDir(featurePresentationLayerPath);
    CommonFunctions.instance.createDir("$featurePath/viewmodels");
    CommonFunctions.instance.createFile("$featurePath/viewmodels/${CommonFunctions.instance.snakeCase(feature)}_viewmodel.dart", 
      CommonTemplateGenerator.instance.controllerTemplate(
        feature: feature,
        stateManagement: stateManagement,
        usecases: usecases.map((u) => u.$1).toList(),
        featuresStrategy: featuresStrategy,
        architecture: ArchitectureTypes.mvvmArchitecture,
      ),
    );

    CommonFunctions.instance.createDir("$featurePath/repositories");
    CommonFunctions.instance.createFile("$featurePath/repositories/${CommonFunctions.instance.snakeCase(feature)}_repository.dart", 
      MvcArchitectureTemplateGenerator.instance.mvcRepositoryTemplate(
        feature: feature, 
        usecases: usecases.map((u) => u.$1).toList(), 
        usecaseTypes: <String, UseCaseType>{for (var usecase in usecases) usecase.$1: usecase.$2}, 
        usecaseAttributes: <String, List<AttributeFormat>>{ for (var usecase in usecases) usecase.$1: usecase.$3 },  
      ),
    );
    CommonFunctions.instance.createFile("$featurePath/repositories/${CommonFunctions.instance.snakeCase(feature)}_repository_impl.dart", 
      MvcArchitectureTemplateGenerator.instance.mvcRepositoryImplTemplate(
        feature: feature, 
        usecases: usecases.map((u) => u.$1).toList(), 
        usecaseTypes: <String, UseCaseType>{for (var usecase in usecases) usecase.$1: usecase.$2}, 
        usecaseAttributes: <String, List<AttributeFormat>>{ for (var usecase in usecases) usecase.$1: usecase.$3 },  
      ),
    );


    CommonFunctions.instance.createDir("$featurePath/usecases");
    for (var usecase in usecases) {
      CommonFunctions.instance.createFile("$featurePath/usecases/${CommonFunctions.instance.snakeCase(usecase.$1)}_usecase.dart", 
        MvcArchitectureTemplateGenerator.instance.mvcUseCaseTemplate(
          usecase: usecase.$1, 
          usecaseType: usecase.$2, 
          attributes: usecase.$3, 
          feature: feature, 
        ),
      );
    }
  }
}