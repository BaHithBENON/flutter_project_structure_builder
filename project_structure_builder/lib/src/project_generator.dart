import 'dart:io';

import 'enums.dart';
import 'generator_types/clean/project_clean_architecture_generator.dart';
import 'generator_types/common/common_structure_geneator.dart';
import 'generator_types/mvc/project_mvc_architecture_generator.dart';
import 'generator_types/mvvm/project_mvvm_architecture_generator.dart';
import 'logs/custom_logger.dart';

class ProjectGenerator {
  final String projectName;
  final ArchitectureTypes architecture;
  final List<String> features;
  final FeaturesStrategy featuresStrategy;
  final StateManagementTypes stateManagement;
  final Map<String, dynamic> config;
  final List<String> envVariables;
  final List<String> envsList;

  const ProjectGenerator({
    required this.projectName, 
    required this.features, 
    required this.config,
    required this.envVariables,
    required this.envsList,
    this.architecture = ArchitectureTypes.cleanArchitecture,
    this.featuresStrategy = FeaturesStrategy.inLib,
    this.stateManagement = StateManagementTypes.getX,
  });

  void generateStructure(String projectPath) {
    AppLogger.instance.logger.i("🚀 \uD83D\uDE80 Génération du projet '$projectName'...");

    final libDir = Directory('$projectPath/lib');
    if (!libDir.existsSync()) {
      libDir.createSync(recursive: true);
    }

    // Structure de base
    final commonStructureGenerator = CommonStructureGenerator(
      projectName: projectPath,
      architecture: architecture,
      features: features,
      featuresStrategy: featuresStrategy,
      stateManagement: stateManagement,
      config: config,
      envVariables: envVariables,
      envsList: envsList,
    );

    commonStructureGenerator.generateStructure();

    if (architecture == ArchitectureTypes.cleanArchitecture) {
      final generator = ProjectCleanArchitectureGenerator(
        projectName: projectPath, 
        features: features,
        stateManagement: stateManagement, 
        config: config,
        featuresStrategy: featuresStrategy,
      );
      generator.generateStructure();
    } else if (architecture == ArchitectureTypes.mvcArchitecture) {
      final generator = ProjectMvcArchitectureGenerator(
        projectName: projectPath, 
        features: features,
        stateManagement: stateManagement, 
        config: config,
        featuresStrategy: featuresStrategy,
      );
      generator.generateStructure();
    } else if (architecture == ArchitectureTypes.mvvmArchitecture) {
      final generator = ProjectMvvmArchitectureGenerator(
        projectName: projectPath, 
        features: features,
        stateManagement: stateManagement, 
        config: config,
        featuresStrategy: featuresStrategy,
      );
      generator.generateStructure();
    } else {
      AppLogger.instance.logger.e("❌ Architecture '$architecture' non prise en charge.");
    }

    AppLogger.instance.logger.i("✅ Structure du projet générée avec succès !");
  }

}
