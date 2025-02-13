import '../../attribute_format.dart';
import '../../custom_types.dart';
import '../../enums.dart';
import '../../functions.dart';
import '../common/common_template_generator.dart';
import 'clean_architecture_template_generator.dart';

/// Generates the project structure for the clean architecture.
///
/// The project structure is as follows:
/// - [projectName]/lib/src/features: contains the feature folders.
/// - [projectName]/lib/src/features/[featureName]: contains the feature architecture layers.
/// - [projectName]/lib/src/features/[featureName]/domain: contains the domain models.
/// - [projectName]/lib/src/features/[featureName]/data: contains the data models.
/// - [projectName]/lib/src/features/[featureName]/presentation: contains the presentation models.
/// - [projectName]/lib/bindings: contains the bindings for the features.
/// - [projectName]/lib/bindings/app_bindings.dart: contains the app bindings.
/// - [projectName]/lib/bindings/app_bindings.main.dart: contains the main app bindings.
///
/// The generated structure is based on the features and the state management type.
/// If the state management type is [StateManagementTypes.getX], it will generate
/// the binding classes for the features.
class ProjectCleanArchitectureGenerator {
  final String projectName;
  final List<String> features;
  final FeaturesStrategy featuresStrategy;
  final StateManagementTypes stateManagement;
  final Map<String, dynamic> config;

  const ProjectCleanArchitectureGenerator({
    required this.projectName,
    required this.features,
    required this.featuresStrategy,
    this.stateManagement = StateManagementTypes.getX,
    required this.config,
  });

  /// Generates the project structure for the clean architecture.
  ///
  /// The project structure is as follows:
  /// - [projectName]/lib/src/features: contains the feature folders.
  /// - [projectName]/lib/src/features/[featureName]: contains the feature architecture layers.
  /// - [projectName]/lib/src/features/[featureName]/domain: contains the domain models.
  /// - [projectName]/lib/src/features/[featureName]/data: contains the data models.
  /// - [projectName]/lib/src/features/[featureName]/presentation: contains the presentation models.
  /// - [projectName]/lib/bindings: contains the bindings for the features.
  /// - [projectName]/lib/bindings/app_bindings.dart: contains the app bindings.
  /// - [projectName]/lib/bindings/app_bindings.main.dart: contains the main app bindings.
  ///
  /// The generated structure is based on the features and the state management type.
  /// If the state management type is [StateManagementTypes.getX], it will generate
  /// the binding classes for the features.
  void generateStructure() {

    String featureStrategy = "$projectName/lib/src/features";

    CommonFunctions.instance.createDir(featureStrategy);

    // Feature´s creation in Clean architecture
    for (var feature in features) {
      feature = CommonFunctions.instance.snakeCase(feature);

      _createFeature(
        feature, 
        featureStrategy: featureStrategy, 
        featurePresentationLayerPath: CommonFunctions.instance.getFeaturePresentationLayerPath(
          feature: feature, projectName: projectName, featuresStrategy: featuresStrategy, architecture: ArchitectureTypes.cleanArchitecture
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
                CommonFunctions.instance.generateControllerClassName(feature: feature, architecture: ArchitectureTypes.cleanArchitecture),
              )
          ],
          featuresStrategy: featuresStrategy,
          projectName: projectName,
          architecture: ArchitectureTypes.cleanArchitecture,
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
                CommonFunctions.instance.generateControllerClassName(feature: feature, architecture: ArchitectureTypes.cleanArchitecture),
              )
          ],
          architecture: ArchitectureTypes.cleanArchitecture,
        ),
      );
    }

    print("✅ Project structure for the '${ArchitectureTypes.cleanArchitecture.name}' architecture generated successfully!");
  }

  /// Creates the feature structure in the clean architecture.
  ///
  /// The structure is as follows:
  /// - [projectName]/lib/src/features/[featureName]: contains the feature architecture layers.
  /// - [projectName]/lib/src/features/[featureName]/domain: contains the domain models.
  /// - [projectName]/lib/src/features/[featureName]/data: contains the data models.
  /// - [projectName]/lib/src/features/[featureName]/presentation: contains the presentation models.
  ///
  /// The generated structure is based on the features and the state management type.
  /// If the state management type is [StateManagementTypes.getX], it will generate
  /// the binding classes for the features.
  void _createFeature(String feature, {
    required String featureStrategy, required String featurePresentationLayerPath, 
    List<(String, UseCaseType, List<AttributeFormat>)> usecases = const [],
    List<AttributeFormat> entityAttributes = const [],
  }) {

    final featurePath = CommonFunctions.instance.getFeaturePath(
      feature: feature, strategy: featureStrategy, featuresStrategy: featuresStrategy, projectName: projectName,
    );
    //

    CommonFunctions.instance.createDir("$featurePath/domain/enums");
    CommonFunctions.instance.createDir("$featurePath/domain/functions");

    CommonFunctions.instance.createDir("$featurePath/domain/entities");
    CommonFunctions.instance.createFile("$featurePath/domain/entities/entity_$feature.dart", 
      CleanArchitectureTemplateGenerator.instance.cleanEntityTemplate(feature: feature, attributes: entityAttributes));

    CommonFunctions.instance.createDir("$featurePath/data/models");
    CommonFunctions.instance.createFile("$featurePath/data/models/model_$feature.dart", 
      CleanArchitectureTemplateGenerator.instance.cleanModelTemplate(feature: feature, attributes: entityAttributes, featuresStrategy: featuresStrategy));

    CommonFunctions.instance.createDir("$featurePath/domain/repositories");
    CommonFunctions.instance.createFile("$featurePath/domain/repositories/${feature}_repository.dart", 
      CleanArchitectureTemplateGenerator.instance.cleanRepositoryTemplate(
        feature: feature, 
        usecases: usecases.map((u) => u.$1).toList(), 
        usecaseTypes: <String, UseCaseType>{for (var usecase in usecases) usecase.$1: usecase.$2}, 
        usecaseAttributes: <String, List<AttributeFormat>>{ for (var usecase in usecases) usecase.$1: usecase.$3 }, 
        featuresStrategy: featuresStrategy, 
    ));

    CommonFunctions.instance.createDir("$featurePath/data/data_sources");
    CommonFunctions.instance.createFile("$featurePath/data/data_sources/${feature}_data_source.dart", 
      CleanArchitectureTemplateGenerator.instance.cleanDataSourceTemplate(
        feature: feature, 
        usecases: usecases.map((u) => u.$1).toList(), 
        usecaseTypes: <String, UseCaseType>{for (var usecase in usecases) usecase.$1: usecase.$2}, 
        usecaseAttributes: <String, List<AttributeFormat>>{ for (var usecase in usecases) usecase.$1: usecase.$3 },  
      ));

    CommonFunctions.instance.createDir("$featurePath/data/repositories_impl");
    CommonFunctions.instance.createFile("$featurePath/data/repositories_impl/${feature}_repository_impl.dart", 
      CleanArchitectureTemplateGenerator.instance.cleanRepositoryImplTemplate(
        feature: feature, 
        usecases: usecases.map((u) => u.$1).toList(), 
        usecaseTypes: <String, UseCaseType>{for (var usecase in usecases) usecase.$1: usecase.$2}, 
        usecaseAttributes: <String, List<AttributeFormat>>{ for (var usecase in usecases) usecase.$1: usecase.$3 },  
        featuresStrategy: featuresStrategy,
      ));

    CommonFunctions.instance.createFile("$featurePath/data/data_sources/${feature}_data_source_impl.dart", 
      CleanArchitectureTemplateGenerator.instance.cleanDataSourceImplTemplate(
        feature: feature, 
        usecases: usecases.map((u) => u.$1).toList(),
        usecaseTypes: <String, UseCaseType>{for (var usecase in usecases) usecase.$1: usecase.$2}, 
        usecaseAttributes: <String, List<AttributeFormat>>{ for (var usecase in usecases) usecase.$1: usecase.$3 },  
      ),
    );
      
    CommonFunctions.instance.createDir("$featurePath/domain/usecases");
    for (var usecase in usecases) {
      CommonFunctions.instance.createFile("$featurePath/domain/usecases/${CommonFunctions.instance.snakeCase(usecase.$1)}_usecase.dart", 
        CleanArchitectureTemplateGenerator.instance.cleanUseCaseTemplate(
          usecase: usecase.$1, 
          usecaseType: usecase.$2, 
          attributes: usecase.$3, 
          feature: feature,
          featuresStrategy: featuresStrategy,
        ));
    }
    

    // Presentation Layer
    CommonFunctions.instance.createDir("$featurePresentationLayerPath/data");
    CommonFunctions.instance.createDir("$featurePresentationLayerPath/ui");
    CommonFunctions.instance.createDir("$featurePresentationLayerPath/functions");
    CommonFunctions.instance.createDir("$featurePresentationLayerPath/adapters");
    CommonFunctions.instance.createFile("$featurePresentationLayerPath/adapters/${feature}_controller.dart", 
      CommonTemplateGenerator.instance.controllerTemplate(
        feature: feature,
        stateManagement: stateManagement,
        usecases: usecases.map((u) => u.$1).toList(),
        featuresStrategy: featuresStrategy,
        architecture: ArchitectureTypes.cleanArchitecture,
      ),
    );
  }

}
