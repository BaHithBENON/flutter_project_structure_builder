import '../../custom_types.dart';
import '../../enums.dart';
import '../../functions.dart';

/// Generates the binding template for the application.
///
/// The generated file contains the imports for the repositories, datasources,
/// usecases and controllers.
///
/// The generated file is used as a part of the app bindings.
String generateBindingTemplate({
  required List<FeaturesBlocsType> featuresBlocs,
  required FeaturesStrategy featuresStrategy,
  required String projectName,
  required ArchitectureTypes architecture,
}) {
  String controllersImports = '';
  String repositoriesImports = '';
  String datasourcesImports = '';
  String usecasesImports = '';

  for (var element in featuresBlocs) {
    // Controllers ($5)
    if (architecture == ArchitectureTypes.cleanArchitecture) {
      controllersImports += featuresStrategy == FeaturesStrategy.independantModules ?  '''
import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/adapters/${CommonFunctions.instance.snakeCase(element.$1)}_controller.dart';
''': '''
import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/presentation/adapters/${CommonFunctions.instance.snakeCase(element.$1)}_controller.dart';
''';
    } else if (architecture == ArchitectureTypes.mvcArchitecture) {
      controllersImports += featuresStrategy == FeaturesStrategy.independantModules ?  '''
import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/adapters/${CommonFunctions.instance.snakeCase(element.$1)}_controller.dart';
''': '''
import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/controllers/${CommonFunctions.instance.snakeCase(element.$1)}_controller.dart';
''';
    } else {
      controllersImports += featuresStrategy == FeaturesStrategy.independantModules ?  '''
import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/adapters/${CommonFunctions.instance.snakeCase(element.$1)}_controller.dart';
''': '''
import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/viewmodels/${CommonFunctions.instance.snakeCase(element.$1)}_viewmodel.dart';
''';
    }

    // Repositories ($2)
    if (architecture == ArchitectureTypes.cleanArchitecture) {
      repositoriesImports += featuresStrategy == FeaturesStrategy.independantModules ?  '''
import 'package:${CommonFunctions.instance.snakeCase(element.$1)}/domain/repositories/${CommonFunctions.instance.snakeCase(element.$1)}_repository.dart';
import 'package:${CommonFunctions.instance.snakeCase(element.$1)}/data/repositories_impl/${CommonFunctions.instance.snakeCase(element.$1)}_repository_impl.dart';
''' : '''
import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/domain/repositories/${CommonFunctions.instance.snakeCase(element.$1)}_repository.dart';
import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/data/repositories_impl/${CommonFunctions.instance.snakeCase(element.$1)}_repository_impl.dart';
''';
    } else {
      repositoriesImports += featuresStrategy == FeaturesStrategy.independantModules ?  '''
import 'package:${CommonFunctions.instance.snakeCase(element.$1)}/domain/repositories/${CommonFunctions.instance.snakeCase(element.$1)}_repository.dart';
import 'package:${CommonFunctions.instance.snakeCase(element.$1)}/data/repositories_impl/${CommonFunctions.instance.snakeCase(element.$1)}_repository_impl.dart';
''' : '''
import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/repositories/${CommonFunctions.instance.snakeCase(element.$1)}_repository.dart';
import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/repositories/${CommonFunctions.instance.snakeCase(element.$1)}_repository_impl.dart';
''';
    }

    // Datasources ($3)
    if (architecture == ArchitectureTypes.cleanArchitecture) {
      datasourcesImports += featuresStrategy == FeaturesStrategy.independantModules ?  '''
  import 'package:${CommonFunctions.instance.snakeCase(element.$1)}/data/data_sources/${CommonFunctions.instance.snakeCase(element.$1)}_data_source.dart';
  import 'package:${CommonFunctions.instance.snakeCase(element.$1)}/data/data_sources/${CommonFunctions.instance.snakeCase(element.$1)}_data_source_impl.dart';
  ''' : '''
  import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/data/data_sources/${CommonFunctions.instance.snakeCase(element.$1)}_data_source.dart';
  import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/data/data_sources/${CommonFunctions.instance.snakeCase(element.$1)}_data_source_impl.dart';
  ''';
    }

    // UseCases ($4)
    if (architecture == ArchitectureTypes.cleanArchitecture) {
      for (var usecase in element.$4) {
        usecasesImports += featuresStrategy == FeaturesStrategy.independantModules ?  '''
  import 'package:${CommonFunctions.instance.snakeCase(element.$1)}/domain/usecases/${
          CommonFunctions.instance.snakeCase(CommonFunctions.instance.removeSuffix(text: usecase, suffix: "UseCase"))
        }_usecase.dart';
  ''' : '''
  import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/domain/usecases/${
          CommonFunctions.instance.snakeCase(CommonFunctions.instance.removeSuffix(text: usecase, suffix: "UseCase"))
        }_usecase.dart';
  ''';
      }
    } else {
      for (var usecase in element.$4) {
        usecasesImports += featuresStrategy == FeaturesStrategy.independantModules ?  '''
import 'package:${CommonFunctions.instance.snakeCase(element.$1)}/domain/usecases/${
          CommonFunctions.instance.snakeCase(CommonFunctions.instance.removeSuffix(text: usecase, suffix: "UseCase"))
        }_usecase.dart';
''' : '''
import '../src/features/${CommonFunctions.instance.snakeCase(element.$1)}/usecases/${
          CommonFunctions.instance.snakeCase(CommonFunctions.instance.removeSuffix(text: usecase, suffix: "UseCase"))
        }_usecase.dart';
''';
      }
    }
  }

  return '''
import 'package:get/get.dart'

// UseCases
$usecasesImports

// Repositories
$repositoriesImports

// Datasources
$datasourcesImports

// Controllers
$controllersImports

part 'app_bindings.main.dart';
 ''';
}

/// Generates the main binding template for the application.
///
/// This method takes a list of [featuresBlocs] and the [architecture] type to generate
/// the appropriate dependency injections using GetX.
///
/// Depending on the architecture type, it sets up the necessary controllers,
/// repositories, data sources, and use cases for each feature block provided.
String generateBindingMainTemplate({
  required List<FeaturesBlocsType> featuresBlocs, required ArchitectureTypes architecture
}) {
  
  // List to hold the generated binding strings for each feature
  List<String> featureBindings = [];

  for (var element in featuresBlocs) {

    // Constructing the comment for the controller
    String content =  '''
    /*
      * ${CommonFunctions.instance.capitalize(element.$1)} Controller
    */
''';

    // Lazy loading the repository implementation
    content += '''
    Get.lazyPut<${element.$2}>(() => ${element.$2}Impl(Get.find()));
''';
    
    // Conditional data source injection for clean architecture
    if (architecture == ArchitectureTypes.cleanArchitecture) {
      content += '''
      Get.lazyPut<${element.$3}>(() => ${element.$3}Impl());
  ''';
    }

    // Lazy loading each usecase for the feature
    for (var usecase in element.$4) {
      content += '''
    Get.lazyPut<$usecase>(() => $usecase(repository: Get.find(),));
''';
    }

    // Putting the controller with its dependencies
    content += '''
    Get.put(${element.$5}(
      ${element.$4.map((u) => "${CommonFunctions.instance.camelCase(u)}: Get.find<$u>(),").join("\n      ")}
    ));
''';

    // Adding the constructed content to the feature bindings list
    featureBindings.add(content);
  }

  // Returning the complete binding class as a string
  return '''
part of 'app_bindings.dart';

/// AppBinding class which extends GetX Bindings
///
/// This class specifies the dependencies required by the app,
/// and uses the list of feature bindings generated above.
class AppBinding extends Bindings {

  /// Overrides the dependencies method to register all dependencies
  @override
  void dependencies() {

    ${featureBindings.join("\n\n")}

  }

}
''';
}
