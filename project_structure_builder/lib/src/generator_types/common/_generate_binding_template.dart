import '../../custom_types.dart';
import '../../enums.dart';
import '../../functions.dart';

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

String generateBindingMainTemplate({
  required List<FeaturesBlocsType> featuresBlocs, required ArchitectureTypes architecture
}) {
  
  List<String> fetaureBindings = [];

  for (var element in featuresBlocs) {

    // Comment 
    String content =  '''
    /*
      * ${CommonFunctions.instance.capitalize(element.$1)} Controller
    */
''';

    // Repository
    content += '''
    Get.lazyPut<${element.$2}>(() => ${element.$2}Impl(Get.find()));
''';
    
    if (architecture == ArchitectureTypes.cleanArchitecture) {
      // DataSource
      content += '''
      Get.lazyPut<${element.$3}>(() => ${element.$3}Impl());
  ''';
    }

    // UseCases
    for (var usecase in element.$4) {
      content += '''
    Get.lazyPut<$usecase>(() => $usecase(repository: Get.find(),));
''';
    }

    // Controller
    content += '''
    Get.put(${element.$5}(
      ${element.$4.map((u) => "${CommonFunctions.instance.camelCase(u)}: Get.find<$u>(),").join("\n      ")}
    ));
''';

    // Bindings
    fetaureBindings.add(content);
  }

  return '''
part of 'app_bindings.dart';

class AppBinding extends Bindings {

  @override
  void dependencies() {

    ${fetaureBindings.join("\n\n")}

  }

}
''';
}