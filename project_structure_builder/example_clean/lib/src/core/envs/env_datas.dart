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
  static const String development = "development";
	static const String staging = "staging";
	static const String production = "production";
  static const List<String> values = [development, staging, production];
  static const String all = "all";
  /// The default environment.
  ///
  /// This constant contains the default environment name.
  static const String defaultEnv = "development";

  /// The folder name containing the environment files.
  ///
  /// This constant contains the folder name containing the environment files.
  static const String envsFolder = "envs";

  /// The environment variables which are expected to be present in the environment files.
  ///
  /// These constants contain the environment variables which are expected to
  /// be present in the environment files.
  /// The ENV1 variable.
	/// The ENV2 variable.
  static const String eNV1 = "ENV1";
	static const String eNV2 = "ENV2";
}
