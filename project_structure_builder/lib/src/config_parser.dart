import 'dart:io';
import 'package:yaml/yaml.dart';

class ConfigParser {
  
  final String configPath;
  const ConfigParser({this.configPath = "project_structure_builder.yml"});

  Map<String, dynamic> parseConfig() {
    final file = File(configPath);
    if (!file.existsSync()) {
      throw Exception("❌ Fichier de configuration '$configPath' introuvable.");
    }

    final yamlString = file.readAsStringSync();
    final yamlMap = loadYaml(yamlString) as Map;

    // Conversion en Map<String, dynamic>
    return yamlMap.map((key, value) => MapEntry(key.toString(), _convertYamlValue(value)));
  }

  dynamic _convertYamlValue(dynamic value) {
    if (value is YamlList) {
      return List<dynamic>.from(value);
    } else if (value is YamlMap) {
      return value.map((k, v) => MapEntry(k.toString(), _convertYamlValue(v)));
    }
    return value;
  }
}
