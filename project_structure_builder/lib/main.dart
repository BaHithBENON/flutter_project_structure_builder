import 'project_structure_builder.dart';

class ProjectStructureBuilder {
  void run(List<String> arguments) {
    try {
      print(
        "📦 PROJECT STRUCTURE BUILDER - Générateur de structure de projet Flutter\n"
        "🔹 Initialisation... \n"
        "🔹 Utilisation : dart run project_structure_builder <command> $arguments"
        ,
      );

      if (arguments.isEmpty) {
        print("⚠️ Aucune commande spécifiée. Utilisez ''update'' pour mettre à jour le projet.");
        return;
      }

      final command = UpdateCommand();

      if (arguments.isNotEmpty && arguments[0] == 'update') {
        command.run(arguments);
      } else {
        print("❌ Commande inconnue.");
      }
    } catch (e) {
      print("❌ : $e");
    }
  }
}
