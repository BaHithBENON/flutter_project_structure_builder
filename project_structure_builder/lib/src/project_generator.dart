import 'dart:io';

import 'enums.dart';
import 'generator_types/clean/project_clean_architecture_generator.dart';
import 'generator_types/common/common_structure_geneator.dart';
import 'generator_types/mvc/project_mvc_architecture_generator.dart';
import 'generator_types/mvvm/project_mvvm_architecture_generator.dart';

/// This class generates the project structure for the specified architecture
/// type.
///
/// The generated structure is based on the project name, the architecture type,
/// the features, the features strategy, the state management type, and the
/// configuration.
///
/// If the architecture type is [ArchitectureTypes.cleanArchitecture], it will
/// generate the project structure for the clean architecture.
/// If the architecture type is [ArchitectureTypes.mvcArchitecture], it will
/// generate the project structure for the MVC architecture.
/// If the architecture type is [ArchitectureTypes.mvvmArchitecture], it will
/// generate the project structure for the MVVM architecture.
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

  /// Generates the project structure.
  ///
  /// The generated structure is based on the project name, the architecture type,
  /// the features, the features strategy, the state management type, and the
  /// configuration.
  /// If the architecture type is [ArchitectureTypes.cleanArchitecture], it will
  /// generate the project structure for the clean architecture.
  /// If the architecture type is [ArchitectureTypes.mvcArchitecture], it will
  /// generate the project structure for the MVC architecture.
  /// If the architecture type is [ArchitectureTypes.mvvmArchitecture], it will
  /// generate the project structure for the MVVM architecture.
  void generateStructure(String projectPath) {
    print(" \uD83D\uDE80 Generating project '$projectName'...");

    // Create the lib directory if it does not exist
    final libDir = Directory('$projectPath/lib');
    if (!libDir.existsSync()) {
      libDir.createSync(recursive: true);
    }

    // Generate the basic structure
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

    // Generate the architecture specific structure
    switch (architecture) {
      case ArchitectureTypes.cleanArchitecture:
        final generator = ProjectCleanArchitectureGenerator(
          projectName: projectPath, 
          features: features,
          stateManagement: stateManagement, 
          config: config,
          featuresStrategy: featuresStrategy,
        );
        generator.generateStructure();
        break;
      case ArchitectureTypes.mvcArchitecture:
        final generator = ProjectMvcArchitectureGenerator(
          projectName: projectPath, 
          features: features,
          stateManagement: stateManagement, 
          config: config,
          featuresStrategy: featuresStrategy,
        );
        generator.generateStructure();
        break;
      case ArchitectureTypes.mvvmArchitecture:
        final generator = ProjectMvvmArchitectureGenerator(
          projectName: projectPath, 
          features: features,
          stateManagement: stateManagement, 
          config: config,
          featuresStrategy: featuresStrategy,
        );
        generator.generateStructure();
        break;
      // ignore: unreachable_switch_default
      default:
        print(" Architecture '$architecture' not supported.");
        break;
    }

    print(" Project structure generated successfully!");
  }

}
