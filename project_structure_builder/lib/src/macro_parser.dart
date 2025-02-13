import 'dart:io';

class MacroParser {
  final String projectPath;

  const MacroParser({required this.projectPath});

  void updateFiles() {
    print("🔄 Mise à jour des fichiers avec les macros...");

    _updateMainDart();
  }

  void _updateMainDart() {
    final mainFilePath = "$projectPath/lib/main.dart";
    final file = File(mainFilePath);

    if (!file.existsSync()) {
      print("⚠️ main.dart introuvable !");
      return;
    }

    String content = file.readAsStringSync();
    print("📄 Chargement du fichier main.dart...");

    // Vérifier si les macros sont présentes
    if (!content.contains("// 🔹 MACRO:IMPORTS")) {
      print("⚠️ La macro IMPORTS n'est pas présente dans main.dart !");
    }
    if (!content.contains("// 🔹 MACRO:FEATURES")) {
      print("⚠️ La macro FEATURES n'est pas présente dans main.dart !");
    }

    // Remplacement des macros
    String newContent = _replaceMacro(content, 'IMPORTS', _generateImports());
    newContent = _replaceMacro(newContent, 'FEATURES', _generateFeatureList());

    if (newContent != content) {
      file.writeAsStringSync(newContent);
      print("✅ main.dart mis à jour !");
    } else {
      print("⚠️ Aucune modification rencontrée.");
    }
  }


  String _replaceMacro(String content, String macro, String replacement) {
    final pattern = RegExp(r'// 🔹 MACRO:' + macro + r'\n([\s\S]*?)// 🔹 END_' + macro, multiLine: true);
    
    if (!pattern.hasMatch(content)) {
      print("⚠️ Aucune macro trouvée pour $macro !");
      return content;
    }

    return content.replaceAllMapped(pattern, (match) {
      return "// 🔹 MACRO:$macro\n$replacement\n// 🔹 END_$macro";
    });
  }


  String _generateImports() {
    final featuresDir = Directory("$projectPath/lib/features");
    if (!featuresDir.existsSync()) return "";

    final featureImports = featuresDir.listSync().whereType<Directory>().map((dir) {
      final featureName = dir.path.split('/').last;
      return "import 'features/$featureName/${featureName}_module.dart';";
    }).join("\n");

    return featureImports;
  }

  String _generateFeatureList() {
    final featuresDir = Directory("$projectPath/lib/features");
    if (!featuresDir.existsSync()) return "";

    final featureInstances = featuresDir.listSync().whereType<Directory>().map((dir) {
      final featureName = dir.path.split('/').last;
      final className = "${featureName[0].toUpperCase()}${featureName.substring(1)}Module";
      return "$className().init();";
    }).join("\n");

    return featureInstances;
  }
}
