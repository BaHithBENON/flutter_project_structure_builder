import 'dart:io';

import 'package:yaml/yaml.dart';

import 'attribute_format.dart';
import 'enums.dart';

/// Contains utility functions used throughout the project structure builder.
///
/// This class contains a variety of functions that are used to perform various
/// tasks such as generating class names, extracting features and use cases from
/// the configuration, creating directories and files, and more.
class CommonFunctions {

  static final CommonFunctions instance = CommonFunctions._internal();
  const CommonFunctions._internal();
  
  /// Capitalize a string.
  ///
  /// This function takes a string, splits it into words separated by underscores,
  /// capitalizes the first letter of each word, and then joins them back together.
  /// For example, the string "hello_world" would be transformed to "HelloWorld".
  ///
  /// [text] The input string to be capitalized.
  ///
  /// Returns a capitalized version of the input string.
  String capitalize(String text) {
    text = text.trim();
    return text
        .split('_')
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join();
  }

  String camelCase(String text) => text[0].toLowerCase() + text.substring(1);

  /// Convert a string from snake_case to camelCase without underscores.
  ///
  /// This function takes a string, splits it into words separated by underscores,
  /// capitalizes the first letter of each word (except the first), and then joins
  /// them back together without any underscores.
  ///
  /// For example, the string "hello_world" would be transformed to "helloWorld".
  ///
  /// [text] The input string to be transformed.
  ///
  /// Returns a camelCase version of the input string without any underscores.
  String toCamelCaseWithoutUnderscore(String text) {
    final parts = text.split('_');
    return parts.first + parts.skip(1).map((word) => word[0].toUpperCase() + word.substring(1)).join();
  }


  /// Convert a string to snake_case.
  ///
  /// This function takes a string, replaces any spaces with underscores, and then
  /// converts any camelCase words to underscore-separated words.
  ///
  /// For example, the string "hello World" would be transformed to "hello_world".
  ///
  /// [text] The input string to be transformed.
  ///
  /// Returns a snake_case version of the input string.
  String snakeCase(String text) {
    return text
        .trim()
        .replaceAll(RegExp(r'\s+'), '_') // Replace spaces with underscores
        .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) => '${match[1]}_${match[2]?.toLowerCase()}') // Handle camelCase
        .toLowerCase(); // Convert everything to lowercase
  }

  String generateUseCaseClassName(String usecase) => "${capitalize(usecase)}UseCase";

  /// Remove a specified suffix from a string if it exists.
  ///
  /// This function checks if the input [text] ends with the given [suffix].
  /// If it does, the suffix is removed from the string. Otherwise, the original
  /// string is returned unchanged.
  ///
  /// [text] The input string from which the suffix should be removed.
  /// [suffix] The suffix to be removed if present.
  ///
  /// Returns the modified string without the suffix if it was present, or the
  /// original string if the suffix was not present.
  String removeSuffix({required String text, required String suffix}) {
    return text.endsWith(suffix) ? text.substring(0, text.length - suffix.length) : text;
  }

  /// Generate a class name for a feature controller based on the given [feature]
  /// name and [architecture].
  ///
  /// If [architecture] is [ArchitectureTypes.mvvmArchitecture], the generated
  /// class name is in the format "FeatureViewModel". Otherwise, the generated
  /// class name is in the format "FeatureController".
  ///
  /// [feature] The name of the feature for which the controller class name is
  /// generated.
  /// [architecture] The architecture type that the controller class name is
  /// generated for.
  ///
  /// Returns the generated controller class name.
  String generateControllerClassName({required String feature, required ArchitectureTypes architecture}) {
    if (architecture == ArchitectureTypes.mvvmArchitecture) {
      return "${capitalize(feature)}ViewModel";
    }
    return "${capitalize(feature)}Controller";
  }

  String generateUseCaseAsAttribute(String usecase) => " final ${generateUseCaseClassName(usecase)} ${camelCase(usecase)}UseCase;";

  /// Generate the class name for a feature entity.
  ///
  /// This function takes the [feature] name and returns a string
  /// formatted as "EntityFeature", where "Feature" is the capitalized
  /// version of the input [feature] name.
  ///
  /// [feature] The name of the feature for which the entity class
  /// name is generated.
  ///
  /// Returns a string representing the generated entity class name.
  String generateEntityClassName(String feature) {
    return "Entity${capitalize(feature)}";
  }

  /// Creates a directory at the given [path].
  ///
  /// If the directory does not exist, it will be created recursively.
  /// Otherwise, nothing will happen.
  ///
  /// [path] The path of the directory to be created.
  void createDir(String path) {
    final dir = Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      print("📁 Dossier créé : $path");
    }
  }

  /// Creates a file at the given [path] with the given [content].
  ///
  /// If the file does not exist, it will be created with the given [content].
  /// Otherwise, nothing will happen.
  ///
  /// [path] The path of the file to be created.
  /// [content] The content to be written to the file.
  void createFile(String path, String content) {
    final file = File(path);
    if (!file.existsSync()) {
      file.writeAsStringSync(content);
      print("📄 Fichier créé : $path");
    }
  }

  /// Extracts the list of features from the given [config].
  ///
  /// The given [config] is a Map containing the configuration of the project.
  /// The [config] should have a key "features" which is a List of Maps.
  /// Each Map in the List should have a key which is the feature name.
  ///
  /// This function returns a List of Strings containing the feature names.
  ///
  /// [config] The configuration of the project.
  ///
  /// Returns a List of Strings containing the feature names.
  List<String> extractFeatures(Map<String, dynamic> config) {
    final features = config["features"] as List<dynamic>? ?? [];

    List<String> featuresList = [];
    for (var feature in features) {
      final featureName = (feature as Map).keys.first;
      featuresList.add(featureName);
    }

    return featuresList;
  }

  /// Extracts the list of use cases for the given [featureName].
  ///
  /// The given [config] is a Map containing the configuration of the project.
  /// The [config] should have a key "features" which is a List of Maps.
  /// Each Map in the List should have a key which is the feature name.
  ///
  /// This function returns a List of tuples containing the use case name,
  /// the use case type, and the list of attributes.
  ///
  /// [config] The configuration of the project.
  /// [featureName] The name of the feature for which the use cases are extracted.
  ///
  /// Returns a List of tuples containing the use case name, the use case type,
  /// and the list of attributes.
  List<(String, UseCaseType, List<AttributeFormat>)> extractUseCasesForFeature(
    Map<String, dynamic> config, String featureName,
  ) {
    final List<(String, UseCaseType, List<AttributeFormat>)> useCasesList = [];

    // Features list
    final features = config["features"] as List<dynamic>? ?? [];

    final feature = features.firstWhere(
      (f) => (f as Map).keys.first == featureName,
      orElse: () => null,
    );

    if (feature == null) {
      // The feature was not found
      return []; 
    }

    // Retrieve feature details
    final featureDetails = yamlToMap(feature[featureName]);
    final usecases = featureDetails["usecases"] as List<dynamic>? ?? [];

    // For each use case, extract its name, type, and attributes
    for (var usecaseEntry in usecases) {
      final usecaseName = (usecaseEntry as Map).keys.first;
      final usecaseDetails = yamlToMap(usecaseEntry[usecaseName]);

      // Retrieve use case attributes
      final attributes = (usecaseDetails["params"] as Map?)
              ?.entries
              .map((e) => AttributeFormat(e.key, DartDataType.fromValue(e.value as String?)))
              .toList() ??
          [];

      // Retrieve use case type
      final useCaseType = UseCaseType.fromValue(usecaseDetails["use_case_type"] as String?);

      // Add the use case to the list
      useCasesList.add((usecaseName, useCaseType, attributes));
    }

    return useCasesList;
  }


  /// Converts a YAML map to a Dart map.
  ///
  /// This function takes a YAML map and returns a Dart map.
  ///
  /// The YAML map is converted to a Dart map by iterating over the entries
  /// of the YAML map and adding them to a new Dart map. The keys are converted
  /// to Dart strings and the values are passed as-is.
  ///
  /// [yamlMap] The YAML map to be converted.
  ///
  /// Returns a Dart map containing the same key-value pairs as the
  /// input YAML map.
  Map<String, dynamic> yamlToMap(dynamic yamlMap) {
    if (yamlMap is YamlMap) {
      return Map<String, dynamic>.fromEntries(
        yamlMap.entries.map((e) => MapEntry(e.key as String, e.value)),
      );
    } else if (yamlMap is Map) {
      return Map<String, dynamic>.fromEntries(
        yamlMap.entries.map((e) => MapEntry(e.key as String, e.value)),
      );
    } else {
      throw ArgumentError('Expected YamlMap but got ${yamlMap.runtimeType}');
    }
  }

  /// Extracts the list of attributes of an entity for the given [featureName].
  ///
  /// The given [config] is a Map containing the configuration of the project.
  /// The [config] should have a key "features" which is a List of Maps.
  /// Each Map in the List should have a key which is the feature name.
  ///
  /// The function returns a List of [AttributeFormat] containing the attributes
  /// of the entity for the given [featureName].
  ///
  /// [config] The configuration of the project.
  /// [featureName] The name of the feature for which the entity attributes
  /// are extracted.
  ///
  /// Returns a List of [AttributeFormat] containing the attributes of the
  /// entity for the given [featureName].
  List<AttributeFormat> extractEntityAttributes(Map<String, dynamic> config, String featureName,) {
    final List<AttributeFormat> attributesList = [];

    final features = config["features"] as List<dynamic>? ?? [];

    // Search for the specific feature
    final feature = features.firstWhere(
      (f) => (f as Map).keys.first == featureName,
      orElse: () => null,
    );

    if (feature == null) {
      return []; // Returns an empty list if the feature does not exist
    }

    final featureDetails = yamlToMap(feature[featureName]);
    final attributes = featureDetails["entity_attributes"] == null ? null : yamlToMap(featureDetails["entity_attributes"]);

    if (attributes != null) {
      for (var attributeEntry in attributes.entries) {
        final attributeName = attributeEntry.key;
        final attributeType = DartDataType.fromValue(attributeEntry.value as String?);

        attributesList.add(AttributeFormat(attributeName, attributeType));
      }
    }
    
    return attributesList;
  }


  /// Returns the path to the presentation layer for a given feature.
  ///
  /// [feature] The name of the feature.
  /// [projectName] The name of the project.
  /// [featuresStrategy] The strategy for organizing feature files.
  /// [architecture] The architecture type being used.
  ///
  /// Returns the path as a string.
  String getFeaturePresentationLayerPath({
    required String feature,
    required String projectName,
    required FeaturesStrategy featuresStrategy,
    required ArchitectureTypes architecture,
  }) {
    // Determine the path based on feature strategy and architecture type
    return featuresStrategy == FeaturesStrategy.inLib
        ? (architecture == ArchitectureTypes.cleanArchitecture
            ? "$projectName/lib/src/features/$feature/presentation"
            : "$projectName/lib/src/features/$feature/views")
        : "$projectName/lib/src/features/$feature";
  }

  /// Creates a Flutter module for the specified feature if it doesn't already exist.
  ///
  /// [projectName] The name of the project.
  /// [feature] The name of the feature for which to create the module.
  /// [inModule] A boolean indicating whether the feature should be created in a module.
  ///
  /// Returns `true` if the module was created, `false` if it already existed or an error occurred.
  bool createFlutterModuleIfNeeded({
    required String projectName, 
    required String feature, 
    required bool inModule
  }) {
    try {
      // Determine the module path based on whether it's an independent module or part of the main project
      String modulePath = inModule 
          ? "$projectName/modules/${CommonFunctions.instance.snakeCase(feature)}"
          : "$projectName/${CommonFunctions.instance.snakeCase(feature)}";
      
      // Check if the module already exists to avoid recreating it
      if (!Directory(modulePath).existsSync()) {
        print("🚀 Creating independent Flutter module: $feature...");
        
        // Run Flutter command to create a new module
        final result = Process.runSync("flutter", ["create", "--template=module", modulePath]);
        
        // Check if the process was successful
        if (result.exitCode != 0) {
          print("⚠️ Error while creating the independent Flutter module: $feature");
          return false;
        }
        
        print("✅ Module $feature successfully created!");
        return true;
      } else {
        print("⚠️ The module $feature already exists, no action required.");
        return false;
      }
    } catch (e) {
      print("⚠️ Error while creating the independent Flutter module: $feature - $e");
      return false;
    }
  }


  /// Returns the path to the feature in the project.
  ///
  /// [projectName] The name of the project.
  /// [featuresStrategy] The strategy for organizing feature files.
  /// [feature] The name of the feature.
  /// [strategy] The strategy name (e.g. "clean_architecture", "mvc_architecture").
  ///
  /// If the feature strategy is [FeaturesStrategy.independantModules], the
  /// function creates a new Flutter module for the feature if it doesn't already
  /// exist. In this case, the path is the path to the module's lib directory.
  ///
  /// Otherwise, the function returns the path to the feature in the project,
  /// which is [strategy]/[feature].
  String getFeaturePath({
    required String projectName,
    required FeaturesStrategy featuresStrategy,
    required String feature,
    required String strategy,
  }) {
    if (featuresStrategy == FeaturesStrategy.independantModules) {
      createFlutterModuleIfNeeded(
        projectName: projectName,
        feature: feature,
        inModule: true,
      );
      return "$projectName/modules/${CommonFunctions.instance.snakeCase(feature)}/lib";
    }
    return "$strategy/$feature";
  }

  /// Returns the path to the core directory in the project.
  ///
  /// [projectName] The name of the project.
  /// [featuresStrategy] The strategy for organizing feature files.
  ///
  /// If the feature strategy is [FeaturesStrategy.independantModules], the
  /// function creates a new Flutter module for the core if it doesn't already
  /// exist. In this case, the path is the path to the core's lib directory.
  ///
  /// Otherwise, the function returns the path to the core directory in the project.
  String getCorePath({
    required String projectName,
    required FeaturesStrategy featuresStrategy,
  }) {
    if (featuresStrategy == FeaturesStrategy.independantModules) {
      // Create a Flutter module for the core if it doesn't exist
      createFlutterModuleIfNeeded(
        projectName: projectName,
        feature: "core",
        inModule: false,
      );
      // Return the path to the core's lib directory in the module
      return "$projectName/core/lib/core";
    }
    // Return the path to the core directory within the project structure
    return "$projectName/lib/src/core";
  }
}
