import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

String generateCleanDataSourceImplTemplate({
  required String feature,
  required List<String> usecases,
  required Map<String, UseCaseType> usecaseTypes,
  required Map<String, List<AttributeFormat>> usecaseAttributes,
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
import '${CommonFunctions.instance.snakeCase(feature)}_data_source.dart';
import '../models/model_${CommonFunctions.instance.snakeCase(feature)}.dart';

class ${CommonFunctions.instance.capitalize(feature)}DataSourceImpl implements ${CommonFunctions.instance.capitalize(feature)}DataSource {

${methods.join("\n\n")}

}
''';
}
