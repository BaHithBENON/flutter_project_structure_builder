import '../../enums.dart';

/// Generates the template for the init dependencies file.
///
/// This function generates the template for the init dependencies file based on the
/// state management type and the features strategy.
///
/// If the state management type is [StateManagementTypes.getX], it will import
/// the get_it package.
///
/// If the features strategy is [FeaturesStrategy.independantModules], it will
/// import the custom logger from the core module. Otherwise, it will import it
/// from the src/core/logs folder.
///
/// This function returns a string which is the template for the init dependencies
/// file.
String generateInitDependenciesTemplate({required StateManagementTypes stateManagement, required FeaturesStrategy featuresStrategy}) {
  return '''
${stateManagement.isGetX ? '''
import 'package:get_it/get_it.dart';
''' : ''
}

${featuresStrategy == FeaturesStrategy.independantModules ? '''
import 'package:core/core/logs/custom_logger.dart';
''' : '''
import 'src/core/logs/custom_logger.dart';
'''
}

import 'init_env.dart';
part 'init_dependencies.main.dart';
''';
}

/// Generates the main template for initializing dependencies.
///
/// This function generates the main template for initializing dependencies
/// based on the state management type. If the state management type is [GetX],
/// it initializes the service locator using the `GetIt` package.
String generateInitDependenciesMainTemplate({required StateManagementTypes stateManagement}) {
  return '''
part of 'init_dependencies.dart';

// Initialize service locator if using GetX for state management
${stateManagement.isGetX ? '''
final serviceLocator = GetIt.instance;
''' : ''}

/// Asynchronously initializes core dependencies including environment variables.
Future<void> initDependencies() async {
  try {
    // Environment initialization
    await InitEnv.initEnv();

    // Initialize other dependencies here

  } catch (e) {
    // Log any errors during initialization
    AppLogger.INSTANCE.logger.e(e.toString(), error: e);
  }
}
''';
}
