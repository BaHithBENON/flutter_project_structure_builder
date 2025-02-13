import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

String generateMvvmUseCaseTemplate({
  required String usecase, required UseCaseType usecaseType, required String feature,
}) {
  final isStream = usecaseType == UseCaseType.stream || usecaseType == UseCaseType.simpleStream;
  final useCaseTypeTarget = isStream ? UseCaseType.simpleStream : UseCaseType.simpleFuture;
  final returnType = isStream ? "Stream" : "Future";

  return '''
import '../../../core/usecases_types/${isStream ? "stream_style_use_case_types" : "future_style_use_case_types"}.dart';
import '../repositories/${feature}_repository.dart';
import '../../../core/resources/params.dart';
import '../models/model_${CommonFunctions.instance.snakeCase(feature)}.dart'; 

class ${CommonFunctions.instance.generateUseCaseClassName(usecase)} implements ${useCaseTypeTarget.target}<Model${CommonFunctions.instance.capitalize(feature)}?, NoParams> {

  final ${CommonFunctions.instance.capitalize(feature)}Repository repository;
  const ${CommonFunctions.instance.generateUseCaseClassName(usecase)}({required this.repository});

  @override
  $returnType<Model${CommonFunctions.instance.capitalize(feature)}?> call(NoParams params) ${isStream ? "" : "async"} {
    return ${isStream ? "" : "await"} repository.${CommonFunctions.instance.camelCase(usecase)}();
  }
}

''';
}

String generateMvvmUseCaseTemplateWithAttributes({
  required String usecase, required UseCaseType usecaseType, required List<AttributeFormat> attributes, required String feature,
}) {
  final paramsClassName = "${CommonFunctions.instance.capitalize(usecase)}UseCaseParams";
  final paramsFields = attributes.map((attr) => "  final ${attr.type.target} ${attr.name};").join("\n");
  final paramsConstructor = "  const $paramsClassName({ ${attributes.map((attr) => "required this.${attr.name}").join(", ")} });";

  final isStream = usecaseType == UseCaseType.stream || usecaseType == UseCaseType.simpleStream;
  final useCaseTypeTarget = isStream ? UseCaseType.simpleStream : UseCaseType.simpleFuture;
  final returnType = isStream ? "Stream" : "Future";

  return '''
import '../models/model_${CommonFunctions.instance.snakeCase(feature)}.dart'; 
import '../../../core/usecases_types/${usecaseType == UseCaseType.stream ? "stream_style_use_case_types" : "future_style_use_case_types"}.dart';
import '../repositories/${feature}_repository.dart';

class ${CommonFunctions.instance.generateUseCaseClassName(usecase)} implements ${useCaseTypeTarget.target}<Model${CommonFunctions.instance.capitalize(feature)}?, $paramsClassName> {

  final ${CommonFunctions.instance.capitalize(feature)}Repository repository;
  const ${CommonFunctions.instance.generateUseCaseClassName(usecase)}({required this.repository});

  @override
  $returnType<Model${CommonFunctions.instance.capitalize(feature)}?> call($paramsClassName params) ${isStream ? "" : "async"} {
    return ${isStream ? "" : "await"} repository.${CommonFunctions.instance.camelCase(usecase)}(${attributes.map((attr) => "${attr.name}: params.${attr.name}").join(", ")});
  }
}

class $paramsClassName {
$paramsFields
$paramsConstructor
}
''';
}