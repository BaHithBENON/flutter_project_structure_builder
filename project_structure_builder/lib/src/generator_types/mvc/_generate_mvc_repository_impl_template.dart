import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

/// Generates a class that implements [${CommonFunctions.instance.capitalize(feature)}Repository].
///
/// The class is named [${CommonFunctions.instance.capitalize(feature)}RepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The body of each method is empty and should be implemented by the user.
///
/// The generated class is a valid implementation of [${CommonFunctions.instance.capitalize(feature)}Repository]
/// and can be used as a starting point for implementing the repository for the feature.
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
  /// Implements [${CommonFunctions.instance.capitalize(feature)}Repository.${CommonFunctions.instance.camelCase(usecase)}].
  ///
  /// The method takes as arguments the attributes of the usecase and returns
  /// a [Future] or [Stream] depending on the value of [usecaseTypes[usecase]].
  ///
  /// The method is marked as [override] and should be implemented by the user.
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

/// A class that implements [${CommonFunctions.instance.capitalize(feature)}Repository].
///
/// This class is a valid implementation of [${CommonFunctions.instance.capitalize(feature)}Repository]
/// and can be used as a starting point for implementing the repository for the feature.
class ${CommonFunctions.instance.capitalize(feature)}RepositoryImpl implements ${CommonFunctions.instance.capitalize(feature)}Repository {

${methods.join("\n")}
}
''';
}
