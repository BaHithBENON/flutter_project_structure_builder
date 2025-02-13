import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

String generateMvcRepositoryImplTemplate({
  required List<String> usecases,
  required Map<String, UseCaseType> usecaseTypes,
  required Map<String, List<AttributeFormat>> usecaseAttributes,
  required String feature,
}) {

  final List<String> methods = usecases.map((usecase) {

    final usecaseType = usecaseTypes[usecase] ?? UseCaseType.future;
    final attributes = usecaseAttributes[usecase] ?? [];

    final String returnType = "${usecaseType.value}<Model${CommonFunctions.instance.capitalize(feature)}?>";

    final String params = attributes.isNotEmpty
        ? "{ ${attributes.map((attr) => "required ${attr.type.target} ${attr.name}").join(", ")} }"
        : "";

    return ''' 
  @override
  $returnType ${CommonFunctions.instance.camelCase(usecase)}($params) ${usecaseType == UseCaseType.stream ? "" : "async"} {
    // TODO: implement ${CommonFunctions.instance.camelCase(usecase)}
    throw UnimplementedError();
  }

''';
  }).toList();

return '''
import '../models/model_${CommonFunctions.instance.snakeCase(feature)}.dart';
import '${CommonFunctions.instance.snakeCase(feature)}_repository.dart';

class ${CommonFunctions.instance.capitalize(feature)}RepositoryImpl implements ${CommonFunctions.instance.capitalize(feature)}Repository {

${methods.join("\n")}
}
''';
}
