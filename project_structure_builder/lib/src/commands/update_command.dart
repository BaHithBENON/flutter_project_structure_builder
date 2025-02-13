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
    argParser.addOption('project', abbr: 'p', help: 'Nom du projet', defaultsTo: 'mon_projet');
  }

  void run(List<String> arguments) {
    final ArgResults args = argParser.parse(arguments);
    final projectName = args['project'] ?? 'my_flutter_app';

    print(
      "📥 Arguments reçus: $arguments\n"
      "🔄 Mise à jour du projet: $projectName",
    );

    try {
      final parser = ConfigParser();
      final config = parser.parseConfig();

      String projectName = config['project_name'];
      ArchitectureTypes architecture = ArchitectureTypes.fromValue(config['architecture']);
      FeaturesStrategy featuresStrategy = FeaturesStrategy.fromValue(config['features_strategy']);
      StateManagementTypes stateManagement = StateManagementTypes.fromValue(config['state_management']);
      List<String> envsList = List<String>.from(config['envs'] ?? []);
      List<String> envVariables = List<String>.from(config['env_variables'] ?? []);
      List<String> features = CommonFunctions.instance.extractFeatures(config);

      print(
        "✅ Configuration chargée avec succès !\n"
        "📌 Nom du projet : $projectName\n"
        "🏗️ Architecture : ${architecture.name}\n"
        "🛠️ Stratégie des fonctionnalités : (${featuresStrategy.name} | ${featuresStrategy.explanation})\n"
        "🔧 Gestionnaire d´état : ${stateManagement.name}\n"
        "📂 Fonctionnalités : $features\n"
        "🌍 Environnements : $envsList\n"
        "🌍 Variables d'environnement : $envVariables"
        ,
      );

      for (var element in features) {
        List<AttributeFormat> entityAttributes = CommonFunctions.instance.extractEntityAttributes(config, element);
        final useCases = CommonFunctions.instance.extractUseCasesForFeature(config, element);

        print(
          "\n🗂️ Attributs de l'entité pour $element \n(\n${entityAttributes.map((attr) => "\t📌 ${attr.name}").join("\n")}\n)\n"
          "\n⚡ UseCases pour la fonctionnalité $element\n("
          "${useCases.map((useCase) => "\t📌 UseCase : $useCase").join("\n")}"
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

      print('✅ Mise à jour terminée !');
    } catch (e) {
      print("❌ Erreur : $e");
    }
  }
}
