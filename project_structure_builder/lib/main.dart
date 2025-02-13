import 'project_structure_builder.dart';

/// This file contains the main class of the project structure builder.
/// The project structure builder is a command line tool that generates
/// the project structure for a Flutter project based on the configuration
/// in the "project_structure_builder.yml" file.
///
/// The builder can be run from the command line using the following
/// command:
///
/// `dart run project_structure_builder <command> [arguments]`
///
/// The `command` argument can be either "update" to update the project
/// structure, or "help" to print the help message.
///
/// The `arguments` argument is a list of command line arguments that
/// can be passed to the `UpdateCommand` class. The arguments are
/// described in the [UpdateCommand] class.
///
/// The `ProjectStructureBuilder` class is the main class of the project
/// structure builder. It contains the `run` method which is called
/// when the builder is run from the command line. The `run` method
/// checks the command line arguments and runs the [UpdateCommand] if
/// the command is "update". If the command is "help", it prints the
/// help message. Otherwise, it prints an error message.
///
/// The `run` method also prints the initialization message.

class ProjectStructureBuilder {

  /// Runs the project structure builder.
  ///
  /// This method checks the command line arguments and runs the
  /// [UpdateCommand] if the command is "update". If the command is
  /// "help", it prints the help message. Otherwise, it prints an
  /// error message.
  ///
  /// The method also prints the initialization message.
  void run(List<String> arguments) {
    try {
      print(
        "PROJECT STRUCTURE BUILDER - Flutter Project Structure Generator\n"
        "Initialization... \n"
        "Usage: dart run project_structure_builder <command> $arguments"
      );

      if (arguments.isEmpty) {
        print("No command specified. Use ''update'' to update the project.");
        return;
      }

      final command = UpdateCommand();

      if (arguments.isNotEmpty && arguments[0] == 'update') {
        command.run(arguments);
      } else if (arguments.isNotEmpty && (arguments[0] == 'h' || arguments[0] == 'help')) {
        command.help();
      } else {
        print("Unknown command.");
      }
    } on Exception catch (e) {
      print(": $e");
    }
  }
}

