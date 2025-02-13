import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

/// Generates an abstract class that represents a repository for the feature [feature].
///
/// The class is named [${CommonFunctions.instance.capitalize(feature)}Repository] and contains one
/// abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [${CommonFunctions.instance.capitalize(feature)}Repository] and can be used as a
/// starting point for implementing the repository for the feature.
String generateMvcRepositoryTemplate({
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

    return "  $returnType ${CommonFunctions.instance.camelCase(usecase)}($params);";
  }).toList();

  return '''
import '../models/model_${CommonFunctions.instance.snakeCase(feature)}.dart';
/// An abstract class that represents a repository for the feature [${CommonFunctions.instance.capitalize(feature)}].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [${CommonFunctions.instance.capitalize(feature)}Repository] and can be used as a
/// starting point for implementing the repository for the feature.
abstract class ${CommonFunctions.instance.capitalize(feature)}Repository {

${methods.join("\n")}

}
''';
}
