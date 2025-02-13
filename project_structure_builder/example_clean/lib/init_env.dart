import 'src/core/logs/custom_logger.dart';
import 'src/core/envs/env.dart';
import 'src/core/envs/env_loader.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

/// The InitEnv class is responsible for initializing the environment
/// variables.
///
/// The generated class is based on the features strategy.
class InitEnv {
  InitEnv._internal();
  static final InitEnv _instance = InitEnv._internal();
  factory InitEnv() => _instance;

  /// Initializes the environment variables.
  ///
  /// This method loads the environment variables from the .env file and loads
  /// them into the EnvObject.
  /// If there is an error during the initialization, it logs the error.
  static Future<void> initEnv() async {
    try {
      AppLogger.INSTANCE.logger.i("  INIT ENV");
      Map<String, String> envVars = await EnvLoader.load(dotEnv: dotenv);
      AppLogger.INSTANCE.logger.i("  ENV VARS => $envVars");
      await EnvObject.load(envVars: envVars);
      AppLogger.INSTANCE.logger.i("  INIT ENV DONE");
    } catch (e) {
      AppLogger.INSTANCE.logger.e(e.toString(), error: e);
    }
  }
}
