import '../../enums.dart';

String generateInitEnvTemplate({required FeaturesStrategy featuresStrategy}) {

  String imports = '';
  if (featuresStrategy == FeaturesStrategy.independantModules) {
    imports = '''
import 'package:core/core/logs/custom_logger.dart';
import 'package:core/core/envs/env.dart';
import 'package:core/core/envs/env_loader.dart';
''';
  } else {
    imports = '''
import 'src/core/logs/custom_logger.dart';
import 'src/core/envs/env.dart';
import 'src/core/envs/env_loader.dart';
''';
  }

  return '''
$imports
import 'package:flutter_dotenv/flutter_dotenv.dart';

class InitEnv {
  InitEnv._internal();
  static final InitEnv _instance = InitEnv._internal();
  factory InitEnv() => _instance;
  
  static Future<void> initEnv() async {
    try {
      AppLogger.INSTANCE.logger.i("🔹 INIT ENV");
      Map<String, String> envVars = await EnvLoader.load(dotEnv: dotenv);
      AppLogger.INSTANCE.logger.i("🔹 ENV VARS => \$envVars");
      await EnvObject.load(envVars: envVars);
      AppLogger.INSTANCE.logger.i("🔹 INIT ENV DONE");
    } catch (e) {
      AppLogger.INSTANCE.logger.e(e.toString(), error: e);
    }
  }
}
''';
}