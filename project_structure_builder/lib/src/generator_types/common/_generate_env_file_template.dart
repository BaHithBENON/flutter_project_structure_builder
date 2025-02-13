import '../../enums.dart';
import '../../functions.dart';

/// Generates the contents of an environment file.
///
/// The generated file will contain key/value pairs, one per line. Each key is
/// one of the values specified in [envVariables], and each value is an empty
/// string.
///
/// If you want to generate a file that can be used to load environment variables
/// with the [dotenv] package, then you should use this function.
///
/// For example, if you call:
///
///     generateEnvFileTemplate(["FOO", "BAR"])
///
/// Then the generated file will contain:
///
///     FOO=
///     BAR=
String generateEnvFileTemplate({required List<String> envVariables}) {

  return '''
${envVariables.map((e) => "$e=").join("\n")}
''';
}

/// Generates the contents of an environment target file.
///
/// The generated file will specify an environment using the 'ENV' key.
/// The first environment from [envsList] is set as the default, but it can be
/// modified to any value from the list as needed.
///
/// For example, if you call:
///
///     generateEnvTargetFileTemplate(["development", "production"])
///
/// Then the generated file will contain:
///
///     ENV=development  # Change this value to (development, production) as needed
///
/// [envsList] A list of environment names.
///
/// Returns a string representing the contents of the environment target file.
String generateEnvTargetFileTemplate({required List<String> envsList}) {
  return '''
ENV=${envsList.first}  # Change this value to (${envsList.join(", ")}) as needed
''';
}

/// Generates the contents of an environment data file.
///
/// The generated file will contain a class named `EnvDatas` which contains
/// constants for the environment names, the default environment, and the
/// folder name containing the environment files.
///
/// It also contains a list named `values` which contains all the environment
/// names.
///
/// Finally, it contains constants for the environment variables which are
/// expected to be present in the environment files.
///
/// The generated file will contain comments and docstrings to explain the
/// purpose of the constants and the class.
String generateEnvDatasTemplate({required FeaturesStrategy featuresStrategy, required List<String> envsList, required List<String> envVariables}) {

  return '''
/// This class contains the environment data.
///
/// It contains constants for the environment names, the default environment,
/// and the folder name containing the environment files.
///
/// It also contains a list named `values` which contains all the environment
/// names.
///
/// Finally, it contains constants for the environment variables which are
/// expected to be present in the environment files.
class EnvDatas {

  /// The names of the environments.
  ///
  /// This list contains all the environment names.
  ${envsList.map((env) => "static const String ${CommonFunctions.instance.camelCase(env)} = \"$env\";").join("\n\t")}
  static const List<String> values = [${envsList.join(", ")}];
  static const String all = "all";
  /// The default environment.
  ///
  /// This constant contains the default environment name.
  static const String defaultEnv = "${envsList.first}";

  /// The folder name containing the environment files.
  ///
  /// This constant contains the folder name containing the environment files.
  static const String envsFolder = "envs";

  /// The environment variables which are expected to be present in the environment files.
  ///
  /// These constants contain the environment variables which are expected to
  /// be present in the environment files.
  ${envVariables.map((env) => "/// The $env variable.").join("\n\t")}
  ${envVariables.map((env) => "static const String ${CommonFunctions.instance.camelCase(env)} = \"$env\";").join("\n\t")}
}
''';

}

String generateEnvLoaderTemplate({required FeaturesStrategy featuresStrategy}) {

  String imports = '';
  if (featuresStrategy == FeaturesStrategy.independantModules) {
    imports = '''
import 'package:core/core/logs/custom_logger.dart';
''';
  } else {
    imports = '''
import '../logs/custom_logger.dart';
''';
  }

  return '''
$imports
import 'package:flutter_dotenv/flutter_dotenv.dart' as dtv;

import 'env_datas.dart';

class EnvLoader {
  static Future<Map<String, String>> load({required dtv.DotEnv dotEnv}) async {
    AppLogger.INSTANCE.logger.i("🔹 INIT ENV LOADER");
    //
    await dotEnv.load(fileName: "\${EnvDatas.envsFolder}/.env.\${EnvDatas.all}");
    AppLogger.INSTANCE.logger.i("🔹 ENV ALL => \${dotEnv.env['ENV']}");
    String env = dotEnv.env['ENV'] ?? EnvDatas.defaultEnv; // Defaut Env
    AppLogger.INSTANCE.logger.i("🔹 ENV => \$env");
    //
    await dotEnv.load(fileName: "\${EnvDatas.envsFolder}/.env.\$env");
    AppLogger.INSTANCE.logger.i("🔹 ENV LOADED => \$env");
    return dotEnv.env;
  }
}
''';
}

/// Generates the EnvObject class
///
/// The EnvObject class is responsible for loading and providing the environment
/// variables to the app.
///
/// The generated EnvObject class is based on the features strategy and the
/// environment variables.
///
/// The EnvObject class contains properties for each environment variable.
/// The properties are named in camel case.
///
/// The EnvObject class also contains a method to check if all the required
/// environment variables are defined.
///
/// The EnvObject class is a singleton.
String generateEnvObjectTemplate({required FeaturesStrategy featuresStrategy, required List<String> envVariables}) {

  String imports = '';
  if (featuresStrategy == FeaturesStrategy.independantModules) {
    imports = '''
import 'package:core/core/logs/custom_logger.dart';
''';
  } else {
    imports = '''
import '../logs/custom_logger.dart';
''';
  }

  return '''
$imports
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'env_datas.dart';

/// The EnvObject class is responsible for loading and providing the environment
/// variables to the app.
///
/// The generated EnvObject class is based on the features strategy and the
/// environment variables.
///
/// The EnvObject class contains properties for each environment variable.
/// The properties are named in camel case.
///
/// The EnvObject class also contains a method to check if all the required
/// environment variables are defined.
///
/// The EnvObject class is a singleton.
class EnvObject {
  EnvObject._internal();
  static final EnvObject _instance = EnvObject._internal();
  factory EnvObject() => _instance;

  /// Whether the EnvObject has been loaded
  static bool _isLoaded = false;

  /// The environment variables
  ///
  /// The properties are named in camel case.
  ///
  /// The properties are loaded from the environment variables using the
  /// [dotenv] package.
  ${envVariables.map((env) => "/// The environment variable $env\nstatic late String ${CommonFunctions.instance.camelCase(env)};").join("\n\t")}

  /// Checks if all the required environment variables are defined
  ///
  /// Returns true if all the required environment variables are defined.
  /// Returns false otherwise.
  static bool checkRequiredVariables(List<String> variables) {
    return dotenv.isEveryDefined(variables);
  }

  /// Loads the environment variables
  ///
  /// The environment variables are loaded from the environment variables using
  /// the [dotenv] package.
  ///
  /// The method is asynchronous and returns a Future.
  ///
  /// The method is idempotent.
  static Future<void> load({required Map<String, String> envVars}) async {

    AppLogger.INSTANCE.logger.i("🔹 INIT ENV OBJECT");
    if (_isLoaded) return;
    _isLoaded = true;

    // Get values
    ${envVariables.map((env) => "${CommonFunctions.instance.camelCase(env)} = envVars[EnvDatas.${CommonFunctions.instance.camelCase(env)}] ?? '';").join("\n\t\t")}

    AppLogger.INSTANCE.logger.i("🔹 ENV Loaded (VARS) => \$envVars");
    _isLoaded = false;
  }
}

''';
}
