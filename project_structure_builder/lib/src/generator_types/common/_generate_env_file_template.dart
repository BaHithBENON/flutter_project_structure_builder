import '../../enums.dart';
import '../../functions.dart';

String generateEnvFileTemplate({required List<String> envVariables}) {

  return '''
${envVariables.map((e) => "$e=").join("\n")}
''';
}

String generateEnvTargetFileTemplate({required List<String> envsList}) {
  return '''
ENV=${envsList.first}  # Change cette valeur en (${envsList.join(", ")}) selon le besoin
''';
}

String generateEnvDatasTemplate({required FeaturesStrategy featuresStrategy, required List<String> envsList, required List<String> envVariables}) {

  return '''
class EnvDatas {

  ${envsList.map((env) => "static const String ${CommonFunctions.instance.camelCase(env)} = \"$env\";").join("\n\t")}
  static const String all = "all";
  static const String defaultEnv = "${envsList.first}";
  static const String envsFolder = "envs";

  static List<String> values = [${envsList.join(", ")}];

  ${envVariables.map((env) => "static const String ${CommonFunctions.instance.camelCase(env)} = \"$env\";").join("\n\t")}

  static const String exceptionEnvMissing = "Missing required environment variables. Please check your .env file.";
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

class EnvObject {
  EnvObject._internal();
  static final EnvObject _instance = EnvObject._internal();
  factory EnvObject() => _instance;

  static bool _isLoaded = false;

  ${envVariables.map((env) => "static late String ${CommonFunctions.instance.camelCase(env)};").join("\n\t")}

  static bool checkRequiredVariables(List<String> variables) {
    return dotenv.isEveryDefined(variables);
  }

  static Future<void> load({required Map<String, String> envVars}) async {

    AppLogger.INSTANCE.logger.i("🔹 INIT ENV OBJECT");
    if (_isLoaded) return;
    _isLoaded = true;

    // Récupérer les valeurs
    ${envVariables.map((env) => "${CommonFunctions.instance.camelCase(env)} = envVars[EnvDatas.${CommonFunctions.instance.camelCase(env)}] ?? '';").join("\n\t\t")}

    AppLogger.INSTANCE.logger.i("🔹 ENV Loaded (VARS) => \$envVars");
    _isLoaded = false;
  }
}

''';
}