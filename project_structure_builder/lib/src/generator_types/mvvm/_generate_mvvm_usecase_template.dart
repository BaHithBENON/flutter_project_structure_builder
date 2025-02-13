import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

/// Generates an MVVM use case class that takes a [NoParams] and returns a [Stream] or [Future].
///
/// The generated class is a valid implementation of [${CommonFunctions.instance.capitalize(feature)}UseCase]
/// and can be used as a starting point for implementing the usecase for the feature.
String generateMvvmUseCaseTemplate({
  required String usecase, required UseCaseType usecaseType, required String feature,
}) {
  // Determine if the use case is a stream type
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
  /// The method takes a [NoParams] as a parameter and returns a [Stream] or [Future] depending on the use case type.
  @override
  $returnType<Model${CommonFunctions.instance.capitalize(feature)}?> call(NoParams params) ${isStream ? "" : "async"} {
    // Call the repository method and return the result
    return ${isStream ? "" : "await"} repository.${CommonFunctions.instance.camelCase(usecase)}();
  }
}

''';
}

/// Generates an MVVM use case class with attributes for the feature [feature].
///
/// The generated class is a valid implementation of [${CommonFunctions.instance.capitalize(feature)}UseCase]
/// and can be used as a starting point for implementing the usecase for the feature.
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
  /// The method takes a [$paramsClassName] as a parameter and returns a [Stream] or [Future] depending on the use case type.
  @override
  $returnType<Model${CommonFunctions.instance.capitalize(feature)}?> call($paramsClassName params) ${isStream ? "" : "async"} {
    // Call the repository method and return the result
    return ${isStream ? "" : "await"} repository.${CommonFunctions.instance.camelCase(usecase)}(${attributes.map((attr) => "${attr.name}: params.${attr.name}").join(", ")});
  }
}

/// A class that contains the attributes for the use case.
///
/// The class is used as a parameter for the [${CommonFunctions.instance.generateUseCaseClassName(usecase)}.call] method.
/// 
/// The class can be created using the [$paramsClassName] constructor.
class $paramsClassName {
$paramsFields
$paramsConstructor
}
''';
}
