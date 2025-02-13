import 'dart:io';
import 'package:yaml/yaml.dart';

/// A class responsible for parsing configuration files.
///
/// The `ConfigParser` class provides functionality to read and parse a YAML
/// configuration file. It returns the parsed configuration as a map of dynamic
/// Dart values. The configuration file is expected to be in the same directory
/// as the project, and the default file name is `"project_structure_builder.yml"`.
/// If the file is not found, an exception is thrown.
class ConfigParser {
  final String configPath;
  const ConfigParser({this.configPath = "project_structure_builder.yml"});

  /// Parse the configuration file and returns a map of configuration.
  ///
  /// The configuration file must be in the same directory as the project.
  /// If the file is not found, it throws an exception.
  Map<String, dynamic> parseConfig() {
    final file = File(configPath);

    // Check if the file exists
    if (!file.existsSync()) {
      throw Exception("❌ Fichier de configuration '$configPath' introuvable.");
    }

    // Read the file content
    final yamlString = file.readAsStringSync();

    // Parse the yaml string
    final yamlMap = loadYaml(yamlString) as Map;

    // Conversion of the yaml map to Map<String, dynamic>
    return yamlMap.map((key, value) => MapEntry(key.toString(), _convertYamlValue(value)));
  }

  /// Converts a YAML value to a dynamic Dart value.
  ///
  /// This function recursively converts YAML structures (such as lists and maps)
  /// into their Dart equivalents. It handles nested lists and maps by calling
  /// itself recursively.
  ///
  /// - [yamlValue]: The YAML value to convert. It can be of type [YamlList], [YamlMap],
  ///   or any other dynamic value.
  ///
  /// Returns:
  /// A Dart representation of the YAML value, with lists as [List<dynamic>] and
  /// maps as [Map<String, dynamic>].
  dynamic _convertYamlValue(dynamic yamlValue) {
    if (yamlValue is YamlList) {
      // Convert a YamlList to a List<dynamic>.
      return yamlValue.map((item) => _convertYamlValue(item)).toList();
    } else if (yamlValue is YamlMap) {
      // Convert a YamlMap to a Map<String, dynamic>.
      return yamlValue.map((key, value) => MapEntry(key.toString(), _convertYamlValue(value)));
    }
    // Return the value as-is if it is not a list or map.
    return yamlValue;
  }
}
