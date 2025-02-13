import 'dart:io';
import 'package:xml/xml.dart';

/// A class used to write the configuration of a project to an XML file.
///
/// The configuration is provided as a [config] map containing keys for
/// 'project_name' and 'features'. The resulting XML is stored in 'config.xml'.
class ConfigWriter {

  final String projectPath;
  const ConfigWriter({required this.projectPath});

  /// Writes the configuration to an XML file at the specified project path.
  ///
  /// The configuration is provided as a [config] map containing keys for
  /// 'project_name' and 'features'. The resulting XML is stored in 'config.xml'.
  /// 
  /// - [config]: A map containing the configuration details.
  void writeConfig(Map<String, dynamic> config) {
    // Define the path for the configuration file
    final configFile = File('$projectPath/config.xml');

    // Initialize an XML builder
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');

    // Build the XML structure
    builder.element('project', nest: () {
      builder.element('name', nest: config['project_name']); // Add project name
      builder.element('features', nest: () {
        for (var feature in config['features']) {
          builder.element('feature', nest: feature); // Add each feature
        }
      });
    });

    // Convert the builder to an XML document
    final document = builder.buildDocument();

    // Write the XML document to a file
    configFile.writeAsStringSync(document.toXmlString(pretty: true));

    // Log success message
    print('✅ Fichier de configuration XML mis à jour !');
  }
}
