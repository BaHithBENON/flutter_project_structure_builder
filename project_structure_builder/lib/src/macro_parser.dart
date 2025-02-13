import 'dart:io';

class MacroParser {
  final String projectPath;

  const MacroParser({required this.projectPath});

  void updateFiles() {
    print("🔄 Updating files with macros...");
    _updateMainDart();
  }

  void _updateMainDart() {
    final mainFilePath = "$projectPath/lib/main.dart";
    final file = File(mainFilePath);

    if (!file.existsSync()) {
      print("⚠️ main.dart not found!");
      return;
    }

    String content = file.readAsStringSync();
    print("📄 Loading the main.dart file...");

    // Check if macros are present
    if (!content.contains("// 🔹 MACRO:IMPORTS")) {
      print("⚠️ The IMPORTS macro is not present in main.dart!");
    }
    if (!content.contains("// 🔹 MACRO:FEATURES")) {
      print("⚠️ The FEATURES macro is not present in main.dart!");
    }

    // Replacing macros
    String newContent = _replaceMacro(content, 'IMPORTS', _generateImports());
    newContent = _replaceMacro(newContent, 'FEATURES', _generateFeatureList());

    if (newContent != content) {
      file.writeAsStringSync(newContent);
      print("✅ main.dart updated!");
    } else {
      print("⚠️ No changes found.");
    }
  }


  String _replaceMacro(String content, String macro, String replacement) {
    final pattern = RegExp(r'// 🔹 MACRO:' + macro + r'\n([\s\S]*?)// 🔹 END_' + macro, multiLine: true);
    
    if (!pattern.hasMatch(content)) {
      print("⚠️ No macro found for $macro!");
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
