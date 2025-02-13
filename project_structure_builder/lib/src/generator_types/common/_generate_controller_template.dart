import '../../enums.dart';
import '../../functions.dart';

String generateControllerTemplate({
  required String feature, required StateManagementTypes stateManagement, List<String> usecases = const [], required FeaturesStrategy featuresStrategy,
  required ArchitectureTypes architecture,
}) {

  String usecasesString = usecases.isEmpty ? "" : 
    usecases.map((u) => " ${CommonFunctions.instance.generateUseCaseAsAttribute(u)}").join("\n");

  String usecasesImports = '';

  for (var usecase in usecases) {

    usecasesImports += featuresStrategy == FeaturesStrategy.independantModules ?  '''
import 'package:${CommonFunctions.instance.snakeCase(usecase)}/domain/usecases/${
  CommonFunctions.instance.snakeCase(CommonFunctions.instance.removeSuffix(text: usecase, suffix: "UseCase"))
}_usecase.dart';
''' : ''' 
import '${architecture == ArchitectureTypes.cleanArchitecture ? '../../domain/usecases/' : '../usecases/'}${
  CommonFunctions.instance.snakeCase(CommonFunctions.instance.removeSuffix(text: usecase, suffix: "UseCase"))
}_usecase.dart';
''';
      
  }

  if (!stateManagement.isGetX) {
    return '''

// UseCases
$usecasesImports

class ${CommonFunctions.instance.generateControllerClassName(feature: feature, architecture: architecture)} {

$usecasesString

  ${CommonFunctions.instance.generateControllerClassName(feature: feature, architecture: architecture)}(${ usecases.isEmpty ? "" : '''{
    ${usecases.map((u) => " required this.${CommonFunctions.instance.camelCase(u)}UseCase").join(",\n     ")}
  }'''});

}
''';
  }

  return '''
import 'package:get/get.dart';

// UseCases
$usecasesImports

class ${CommonFunctions.instance.generateControllerClassName(feature: feature, architecture: architecture)} extends GetxController {

$usecasesString

  ${CommonFunctions.instance.generateControllerClassName(feature: feature, architecture: architecture)}(${ usecases.isEmpty ? "" : '''{
    ${usecases.map((u) => " required this.${CommonFunctions.instance.camelCase(u)}UseCase").join(",\n     ")}
  }'''});

}
''';
}


String generateControllerProviderTemplate({
  required StateManagementTypes stateManagement, required List<String> features, required String projectName, required FeaturesStrategy featuresStrategy,
  required ArchitectureTypes architecture,
}) {
  
  String imports = "";
  
  for (var feature in features) {
    String pathImport = featuresStrategy == FeaturesStrategy.independantModules ? 
    "import '../features/${CommonFunctions.instance.snakeCase(feature)}/adapters/${CommonFunctions.instance.snakeCase(feature)}_controller.dart';\n" :
    architecture == ArchitectureTypes.cleanArchitecture ?
      "import '../features/${CommonFunctions.instance.snakeCase(feature)}/presentation/adapters/${CommonFunctions.instance.snakeCase(feature)}_controller.dart';\n" 
    : architecture == ArchitectureTypes.mvcArchitecture ?
      "import '../features/${CommonFunctions.instance.snakeCase(feature)}/controllers/${CommonFunctions.instance.snakeCase(feature)}_controller.dart';\n"
    : "import '../features/${CommonFunctions.instance.snakeCase(feature)}/viewmodels/${CommonFunctions.instance.snakeCase(feature)}_viewmodel.dart';\n";
    
    imports += pathImport;
  }
  
  return '''
// ignore_for_file: non_constant_identifier_names

${stateManagement.isGetX ? '''
import 'package:get/get.dart';
''': ''}

$imports

class ${architecture == ArchitectureTypes.mvvmArchitecture ? 'ViewModels' :  "Controllers"}Provider {

${stateManagement.isGetX ? '''${
features.map((feature) => 
"  static final ${CommonFunctions.instance.snakeCase(feature).toUpperCase()}_${architecture == ArchitectureTypes.mvvmArchitecture ? "VIEWMODEL" : "CONTROLLER"} = Get.find<${CommonFunctions.instance.generateControllerClassName(feature: feature, architecture: architecture)}>();").join("\n")
}
''' : '''
'''}
}
''';
}