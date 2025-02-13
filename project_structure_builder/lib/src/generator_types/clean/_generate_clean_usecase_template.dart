import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

/// Generates a class that implements [${CommonFunctions.instance.capitalize(feature)}UseCase].
///
/// The class is named [${CommonFunctions.instance.generateUseCaseClassName(usecase)}] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The body of each method is empty and should be implemented by the user.
///
/// The generated class is a valid implementation of [${CommonFunctions.instance.capitalize(feature)}UseCase]
/// and can be used as a starting point for implementing the usecase for the feature.
String generateCleanUseCaseTemplate({
  required String usecase, required UseCaseType usecaseType, required String feature, required FeaturesStrategy featuresStrategy,
}) {

  final isStream = usecaseType == UseCaseType.stream || usecaseType == UseCaseType.simpleStream;
  final useCaseTypeTarget = isStream ? UseCaseType.stream : UseCaseType.future;
  final returnType = isStream ? UseCaseType.stream.value : UseCaseType.future.value;

  return '''
import '../entities/entity_$feature.dart';
import '../repositories/${feature}_repository.dart';
${featuresStrategy == FeaturesStrategy.independantModules ? '''
import 'package:core/core/errors/failure.dart';
import 'package:core/core/resources/params.dart';
import 'package:core/core/usecases_types/${usecaseType == UseCaseType.stream ? "stream_style_use_case_types" : "future_style_use_case_types"}.dart';
''' : '''
import '../../../../core/resources/params.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/${usecaseType == UseCaseType.stream ? "stream_style_use_case_types" : "future_style_use_case_types"}.dart';
'''
}

/// A concrete implementation of [${CommonFunctions.instance.capitalize(feature)}UseCase].
///
/// The constructor takes a [${CommonFunctions.instance.capitalize(feature)}Repository] as a parameter.
/// The method [call] takes a [NoParams] as a parameter and returns a [Future] or [Stream]
/// depending on the value of [usecaseTypes[usecase]].
class ${CommonFunctions.instance.generateUseCaseClassName(usecase)} implements ${useCaseTypeTarget.target}<Entity${CommonFunctions.instance.capitalize(feature)}, NoParams> {

  /// The constructor takes a [${CommonFunctions.instance.capitalize(feature)}Repository] as a parameter.
  final ${CommonFunctions.instance.capitalize(feature)}Repository repository;
  const ${CommonFunctions.instance.generateUseCaseClassName(usecase)}({required this.repository});

  /// The method takes a [NoParams] as a parameter and returns a [Future] or [Stream]
  /// depending on the value of [usecaseTypes[usecase]].
  @override
  $returnType<(Failure?, Entity${CommonFunctions.instance.capitalize(feature)}?)> call(NoParams params) ${isStream ? "" : "async"} {
    return ${isStream ? "" : "await"} repository.${CommonFunctions.instance.camelCase(usecase)}();
  }
}

''';
}

/// Generates a use case class with attributes for the feature [feature].
///
/// The generated class implements [${CommonFunctions.instance.capitalize(feature)}UseCase]
/// and contains one method that takes a parameter class with attributes.
///
/// The return type of the method is [Future] or [Stream] based on [usecaseType].
String generateCleanUseCaseTemplateWithAttributes({
  required String usecase,
  required UseCaseType usecaseType,
  required List<AttributeFormat> attributes,
  required String feature,
  required FeaturesStrategy featuresStrategy,
}) {
  final isStream = usecaseType == UseCaseType.stream || usecaseType == UseCaseType.simpleStream;
  final useCaseTypeTarget = isStream ? UseCaseType.stream : UseCaseType.future;
  final returnType = isStream ? UseCaseType.stream.value : UseCaseType.future.value;

  final paramsClassName = "${CommonFunctions.instance.capitalize(usecase)}UseCaseParams";
  final paramsFields = attributes.map((attr) => "  final ${attr.type.target} ${attr.name};").join("\n");
  final paramsConstructor =
      "  const $paramsClassName({ ${attributes.map((attr) => "required this.${attr.name}").join(", ")} });";

  return '''
import '../entities/entity_$feature.dart';

${featuresStrategy == FeaturesStrategy.independantModules ? '''
import 'package:core/core/errors/failure.dart';
import 'package:core/core/usecases_types/${isStream ? "stream_style_use_case_types" : "future_style_use_case_types"}.dart';
''' : '''
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/${isStream ? "stream_style_use_case_types" : "future_style_use_case_types"}.dart';
'''
}

import '../repositories/${feature}_repository.dart';

/// A concrete implementation of [${CommonFunctions.instance.capitalize(feature)}UseCase] with parameters.
///
/// This class requires a [${CommonFunctions.instance.capitalize(feature)}Repository] to function.
/// It calls the repository method with the given parameters.
class ${CommonFunctions.instance.generateUseCaseClassName(usecase)} implements ${useCaseTypeTarget.target}<Entity${CommonFunctions.instance.capitalize(feature)}, $paramsClassName> {

  /// Repository to interact with data layer.
  final ${CommonFunctions.instance.capitalize(feature)}Repository repository;

  /// Constructor for the use case, requiring a [repository].
  const ${CommonFunctions.instance.generateUseCaseClassName(usecase)}({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  $returnType<(Failure?, Entity${CommonFunctions.instance.capitalize(feature)}?)> call($paramsClassName params) ${isStream ? "" : "async"} {
    return ${isStream ? "" : "await"} repository.${CommonFunctions.instance.camelCase(usecase)}(${attributes.map((attr) => "${attr.name}: params.${attr.name}").join(", ")});
  }
}

/// Parameter class for [${CommonFunctions.instance.generateUseCaseClassName(usecase)}].
///
/// Contains all the attributes required for the use case.
class $paramsClassName {
$paramsFields

  /// Creates an instance of [$paramsClassName].
  $paramsConstructor
}
''';
}
