import 'dart:io';

import 'package:args/args.dart';

import '../attribute_format.dart';
import '../config_parser.dart';
import '../enums.dart';
import '../functions.dart';
import '../project_generator.dart';


class UpdateCommand {
  final ArgParser argParser = ArgParser();

  UpdateCommand() {
    argParser.addOption('project', abbr: 'p', help: 'Project name', defaultsTo: 'my_project');
  }

  /// Executes the project update command.
  ///
  /// This method reads the command arguments, parses the project configuration,
  /// and calls the project structure generator to update the project.
  ///
  /// Expected arguments:
  /// - [--project <project_name>] : the name of the project.
  ///
  /// If the project name is not specified, the default name is "my_flutter_app".
  ///
  /// The method reads and parses the project configuration to extract the following information:
  /// - project name
  /// - architecture type
  /// - feature strategy
  /// - state management
  /// - list of features
  /// - list of environments
  /// - list of environment variables
  ///
  /// Then, the method calls the project structure generator to update the project
  /// based on the extracted information.
  void run(List<String> arguments) {
    final ArgResults args = argParser.parse(arguments);
    final projectName = args['project'] ?? 'my_flutter_app';

    print(
      "📥 Received arguments: $arguments\n"
      "🔄 Updating project: $projectName",
    );

    try {
      final parser = ConfigParser();
      final config = parser.parseConfig();

      final String projectName = config['project_name'];
      final ArchitectureTypes architecture = ArchitectureTypes.fromValue(config['architecture']);
      final FeaturesStrategy featuresStrategy = FeaturesStrategy.fromValue(config['features_strategy']);
      final StateManagementTypes stateManagement = StateManagementTypes.fromValue(config['state_management']);
      final List<String> envsList = List<String>.from(config['envs'] ?? []);
      final List<String> envVariables = List<String>.from(config['env_variables'] ?? []);
      final List<String> features = CommonFunctions.instance.extractFeatures(config);

      print(
        "✅ Configuration successfully loaded!\n"
        "📌 Project name: $projectName\n"
        "🏗️ Architecture: ${architecture.name}\n"
        "🛠️ Feature strategy: (${featuresStrategy.name} | ${featuresStrategy.explanation})\n"
        "🔧 State management: ${stateManagement.name}\n"
        "📂 Features: $features\n"
        "🌍 Environments: $envsList\n"
        "🌍 Environment variables: $envVariables"
        ,
      );

      for (var element in features) {
        List<AttributeFormat> entityAttributes = CommonFunctions.instance.extractEntityAttributes(config, element);
        final useCases = CommonFunctions.instance.extractUseCasesForFeature(config, element);

        print(
          "\n🗂️ Entity attributes for $element \n(\n${entityAttributes.map((attr) => "\t📌 ${attr.name}").join("\n")}\n)\n"
          "\n⚡ UseCases for feature $element\n("
          "${useCases.map((useCase) => "\t📌 UseCase: $useCase").join("\n")}"
          ")"
        );
      }

      final generator = ProjectGenerator(
        projectName: projectName, 
        features: features,
        stateManagement: stateManagement, 
        config: config,
        architecture: architecture,
        featuresStrategy: architecture == ArchitectureTypes.cleanArchitecture ?
          featuresStrategy : FeaturesStrategy.inLib,
        envVariables: envVariables,
        envsList: envsList,
      );
      generator.generateStructure(Directory.current.path);

      print('✅ Update completed!');
    } catch (e) {
      print("❌ Error : $e");
    }
  }

  void help() {
    print("""
Usage:
  dart run project_structure_builder <command> [options]

Commands:
  update   : Updates the Flutter project structure based on the provided configuration.
  help     : Displays this help message.

Options:
  <command> : The command to execute (e.g., 'update' to update the project structure).
  [options] : Any additional options for the command (if applicable).

Examples:
  dart run project_structure_builder update
  dart run project_structure_builder help
    """);
  }
}
