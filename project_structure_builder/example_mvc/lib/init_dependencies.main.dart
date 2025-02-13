part of 'init_dependencies.dart';

// Initialize service locator if using GetX for state management
final serviceLocator = GetIt.instance;


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
