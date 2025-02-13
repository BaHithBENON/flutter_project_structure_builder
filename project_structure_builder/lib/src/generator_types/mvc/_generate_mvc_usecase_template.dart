import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

/// Generates a use case class that takes a [NoParams] and returns a [Stream] or a [Future].
///
/// The generated class is a valid implementation of [${CommonFunctions.instance.capitalize(feature)}UseCase]
/// and can be used as a starting point for implementing the usecase for the feature.
String generateMvcUseCaseTemplate({
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

/// A concrete implementation of [${CommonFunctions.instance.capitalize(feature)}UseCase].
///
/// This class requires a [${CommonFunctions.instance.capitalize(feature)}Repository] to function.
/// It calls the repository method with no parameters.
class ${CommonFunctions.instance.generateUseCaseClassName(usecase)} implements ${useCaseTypeTarget.target}<Model${CommonFunctions.instance.capitalize(feature)}?, NoParams> {

  /// Repository to interact with data layer.
  final ${CommonFunctions.instance.capitalize(feature)}Repository repository;

  /// Constructor for the use case, requiring a [${CommonFunctions.instance.capitalize(feature)}Repository].
  const ${CommonFunctions.instance.generateUseCaseClassName(usecase)}({required this.repository});

  /// Implements [${CommonFunctions.instance.capitalize(feature)}UseCase.call].
  ///
  /// The method takes a [NoParams] as a parameter and returns a [Stream] or a [Future] depending on the value of [usecaseTypes[usecase]].
  @override
  $returnType<Model${CommonFunctions.instance.capitalize(feature)}?> call(NoParams params) ${isStream ? "" : "async"} {
    return ${isStream ? "" : "await"} repository.${CommonFunctions.instance.camelCase(usecase)}();
  }
}

''';
}

/// Generates a MVC use case class with attributes for the feature [feature].
///
/// The generated class implements a use case for the specified [usecase] and
/// takes a parameter class with attributes defined by [attributes].
///
/// The return type of the method is [Future] or [Stream] based on [usecaseType].
String generateMvcUseCaseTemplateWithAttributes({
  required String usecase, 
  required UseCaseType usecaseType, 
  required List<AttributeFormat> attributes, 
  required String feature,
}) {
  final paramsClassName = "${CommonFunctions.instance.capitalize(usecase)}UseCaseParams";
  final paramsFields = attributes.map((attr) => "  final ${attr.type.target} ${attr.name};").join("\n");
  final paramsConstructor = "  const $paramsClassName({ ${attributes.map((attr) => "required this.${attr.name}").join(", ")} });";

  final isStream = usecaseType == UseCaseType.stream || usecaseType == UseCaseType.simpleStream;
  final useCaseTypeTarget = isStream ? UseCaseType.simpleStream : UseCaseType.simpleFuture;
  final returnType = isStream ? "Stream" : "Future";

  return '''
import '../models/model_${CommonFunctions.instance.snakeCase(feature)}.dart'; 
import '../../../core/usecases_types/${isStream ? "stream_style_use_case_types" : "future_style_use_case_types"}.dart';
import '../repositories/${feature}_repository.dart';

/// A concrete implementation of [${CommonFunctions.instance.capitalize(feature)}UseCase] with parameters.
///
/// This class requires a [${CommonFunctions.instance.capitalize(feature)}Repository] to function.
/// It calls the repository method with the given parameters.
class ${CommonFunctions.instance.generateUseCaseClassName(usecase)} implements ${useCaseTypeTarget.target}<Model${CommonFunctions.instance.capitalize(feature)}?, $paramsClassName> {

  /// Repository to interact with data layer.
  final ${CommonFunctions.instance.capitalize(feature)}Repository repository;

  /// Constructor for the use case, requiring a [${CommonFunctions.instance.capitalize(feature)}Repository].
  const ${CommonFunctions.instance.generateUseCaseClassName(usecase)}({required this.repository});

  /// Implements [${CommonFunctions.instance.capitalize(feature)}UseCase.call].
  ///
  /// The method takes a [$paramsClassName] as a parameter and returns a [Stream] or [Future]
  /// depending on the value of [usecaseType].
  @override
  $returnType<Model${CommonFunctions.instance.capitalize(feature)}?> call($paramsClassName params) ${isStream ? "" : "async"} {
    return ${isStream ? "" : "await"} repository.${CommonFunctions.instance.camelCase(usecase)}(${attributes.map((attr) => "${attr.name}: params.${attr.name}").join(", ")});
  }
}

/// Parameter class for [${CommonFunctions.instance.capitalize(usecase)}UseCase].
///
/// This class holds the attributes required by the use case method.
class $paramsClassName {
$paramsFields

  /// Constructor for [$paramsClassName].
$paramsConstructor
}
''';
}
