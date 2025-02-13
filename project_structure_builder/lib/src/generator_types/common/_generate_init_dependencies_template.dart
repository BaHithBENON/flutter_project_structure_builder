import '../../enums.dart';

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

String generateInitDependenciesMainTemplate({required StateManagementTypes stateManagement}) {
  return '''
part of 'init_dependencies.dart';

${stateManagement.isGetX ? '''
final serviceLocator = GetIt.instance;
''' : ''}

Future<void> initDependencies() async {
  try {
    // Env initialisation
    await InitEnv.initEnv();

    // Others dependencies
    
  } catch (e) {
    AppLogger.INSTANCE.logger.e(e.toString(), error: e);
  }
}
''';
}