import 'dart:io';

import 'package:yaml/yaml.dart';

import 'attribute_format.dart';
import 'enums.dart';

class CommonFunctions {

  // Instance unique du singleton
  static final CommonFunctions instance = CommonFunctions._internal();

  // Constructeur privé
  const CommonFunctions._internal();
  
  String capitalize(String text) {
    text = text.trim();
    return text
        .split('_')
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join();
  }

  String camelCase(String text) => text[0].toLowerCase() + text.substring(1);

  String toCamelCaseWithoutUnderscore(String text) {
    final parts = text.split('_');
    return parts.first + parts.skip(1).map((word) => word[0].toUpperCase() + word.substring(1)).join();
  }


  String snakeCase(String text) {
    return text
        .trim()
        .replaceAll(RegExp(r'\s+'), '_') // Remplace les espaces par des underscores
        .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) => '${match[1]}_${match[2]?.toLowerCase()}') // Sépare les mots en camelCase
        .toLowerCase(); // Convertit tout en minuscules
  }

  String generateUseCaseClassName(String usecase) => "${capitalize(usecase)}UseCase";

  String removeSuffix({required String text, required String suffix}) {
    return text.endsWith(suffix) ? text.substring(0, text.length - suffix.length) : text;
  }

  String generateControllerClassName({required String feature, required ArchitectureTypes architecture}) {
    if (architecture == ArchitectureTypes.mvvmArchitecture) {
      return "${capitalize(feature)}ViewModel";
    }
    return "${capitalize(feature)}Controller";
  }

  String generateUseCaseAsAttribute(String usecase) => " final ${generateUseCaseClassName(usecase)} ${camelCase(usecase)}UseCase;";

  String generateEntityClassName(String feature) {
    return "Entity${capitalize(feature)}";
  }

  void createDir(String path) {
    final dir = Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      print("📁 Dossier créé : $path");
    }
  }

  void createFile(String path, String content) {
    final file = File(path);
    if (!file.existsSync()) {
      file.writeAsStringSync(content);
      print("📄 Fichier créé : $path");
    }
  }

  List<String> extractFeatures(Map<String, dynamic> config) {
    final features = config["features"] as List<dynamic>? ?? [];

    List<String> featuresList = [];
    for (var feature in features) {
      final featureName = (feature as Map).keys.first;
      featuresList.add(featureName);
    }

    return featuresList;
  }

  List<(String, UseCaseType, List<AttributeFormat>)> extractUseCasesForFeature(
    Map<String, dynamic> config, String featureName,
  ) {
    final List<(String, UseCaseType, List<AttributeFormat>)> useCasesList = [];

    final features = config["features"] as List<dynamic>? ?? [];

    // Recherche de la feature spécifique
    final feature = features.firstWhere(
      (f) => (f as Map).keys.first == featureName,
      orElse: () => null,
    );

    if (feature == null) {
      return []; // Retourne une liste vide si la feature n'existe pas
    }

    final featureDetails = yamlToMap(feature[featureName] as YamlMap);
    final usecases = featureDetails["usecases"] as List<dynamic>? ?? [];

    for (var usecaseEntry in usecases) {
      final usecaseName = (usecaseEntry as Map).keys.first;
      final usecaseDetails = yamlToMap(usecaseEntry[usecaseName] as YamlMap);

      final attributes = (usecaseDetails["params"] as Map?)
              ?.entries
              .map((e) => AttributeFormat(e.key, DartDataType.fromValue(e.value as String?)))
              .toList() ??
          [];

      final useCaseType = UseCaseType.fromValue(usecaseDetails["use_case_type"] as String?);

      useCasesList.add((usecaseName, useCaseType, attributes));
    }

    return useCasesList;
  }


  Map<String, dynamic> yamlToMap(YamlMap yamlMap) {
    return Map<String, dynamic>.fromEntries(
      yamlMap.entries.map((e) => MapEntry(e.key as String, e.value)),
    );
  }

  List<AttributeFormat> extractEntityAttributes(Map<String, dynamic> config, String featureName,) {
    final List<AttributeFormat> attributesList = [];

    final features = config["features"] as List<dynamic>? ?? [];

    // Recherche de la feature spécifique
    final feature = features.firstWhere(
      (f) => (f as Map).keys.first == featureName,
      orElse: () => null,
    );

    if (feature == null) {
      return []; // Retourne une liste vide si la feature n'existe pas
    }

    final featureDetails = yamlToMap(feature[featureName] as YamlMap);
    final attributes = featureDetails["entity_attributes"] == null ? null : yamlToMap(featureDetails["entity_attributes"] as YamlMap);

    if (attributes != null) {
      for (var attributeEntry in attributes.entries) {
        final attributeName = attributeEntry.key;
        final attributeType = DartDataType.fromValue(attributeEntry.value as String?);

        attributesList.add(AttributeFormat(attributeName, attributeType));
      }
    }
    
    return attributesList;
  }

  String getFeaturePresentationLayerPath({
    required String feature, required String projectName, required FeaturesStrategy featuresStrategy, required ArchitectureTypes architecture,
  }) {
    return featuresStrategy == FeaturesStrategy.inLib ? (
      architecture == ArchitectureTypes.cleanArchitecture ?
      "$projectName/lib/src/features/$feature/presentation" :
      "$projectName/lib/src/features/$feature/views" 
    ) : 
      "$projectName/lib/src/features/$feature";
  }

  bool createFlutterModuleIfNeeded({required String projectName, required String feature, required bool inModule}) {
    try {
      String modulePath = inModule ? "$projectName/modules/${CommonFunctions.instance.snakeCase(feature)}"
          : "$projectName/${CommonFunctions.instance.snakeCase(feature)}";
      
      // Vérifier si le module existe déjà pour éviter de le recréer
      if (!Directory(modulePath).existsSync()) {
        print("🚀 Création du module Flutter indépendant : $feature...");
        final result = Process.runSync("flutter", ["create", "--template=module", modulePath]);
        if (result.exitCode != 0) {
          print("⚠️ Erreur lors de la création du module Flutter indépendant : $feature");
        }
        print("✅ Module $feature créé avec succès !");
        return true;
      } else {
        print("⚠️ Le module $feature existe déjà, aucune action requise.");
        return false;
      }
    } catch (e) {
      print("⚠️ Erreur lors de la création du module Flutter indépendant : $feature - $e");
      return false;
    }
  }

  String getFeaturePath({required String projectName, required FeaturesStrategy featuresStrategy, required String feature, required String strategy}) {
    if (featuresStrategy == FeaturesStrategy.independantModules) {
      // Creation du module independant flutter
      createFlutterModuleIfNeeded(projectName: projectName, feature: feature, inModule: true);
      return "$projectName/modules/${CommonFunctions.instance.snakeCase(feature)}/lib";
    }
    return "$strategy/$feature";
  }

  String getCorePath({required String projectName, required FeaturesStrategy featuresStrategy}) {
    if (featuresStrategy == FeaturesStrategy.independantModules) {
      createFlutterModuleIfNeeded(projectName: projectName, feature: "core", inModule: false);
      return "$projectName/core/lib/core";
    }
    return "$projectName/lib/src/core";
  }
}
