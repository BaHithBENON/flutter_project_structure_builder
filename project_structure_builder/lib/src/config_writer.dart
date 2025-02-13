import 'dart:io';
import 'package:xml/xml.dart';

class ConfigWriter {

  final String projectPath;
  const ConfigWriter({required this.projectPath});

  void writeConfig(Map<String, dynamic> config) {
    final configFile = File('$projectPath/config.xml');

    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element('project', nest: () {
      builder.element('name', nest: config['project_name']);
      builder.element('features', nest: () {
        for (var feature in config['features']) {
          builder.element('feature', nest: feature);
        }
      });
    });

    final document = builder.buildDocument();
    configFile.writeAsStringSync(document.toXmlString(pretty: true));
    print('✅ Fichier de configuration XML mis à jour !');
  }
}
