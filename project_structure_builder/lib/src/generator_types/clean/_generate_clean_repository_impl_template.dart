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
String generateCleanRepositoryImplTemplate({
  required List<String> usecases,
  required Map<String, UseCaseType> usecaseTypes,
  required Map<String, List<AttributeFormat>> usecaseAttributes,
  required String feature, required FeaturesStrategy featuresStrategy,
}) {

  final List<String> methods = usecases.map((usecase) {
    final usecaseType = usecaseTypes[usecase] ?? UseCaseType.future;
    final attributes = usecaseAttributes[usecase] ?? [];

    final String returnType = "${usecaseType.value}<(Failure?, Entity${CommonFunctions.instance.capitalize(feature)}?)>";

    final String params = attributes.isNotEmpty
        ? "{ ${attributes.map((attr) => "required ${attr.type.target} ${attr.name}").join(", ")} }"
        : "";

    final String callParams = attributes.isNotEmpty
        ? attributes.map((attr) => "${attr.name}: ${attr.name}").join(", ")
        : "";

    return '''
  /// Implements [${CommonFunctions.instance.capitalize(feature)}Repository.${CommonFunctions.instance.camelCase(usecase)}].
  ///
  /// The method calls [${CommonFunctions.instance.capitalize(feature)}DataSource.${CommonFunctions.instance.camelCase(usecase)}]
  /// and returns the result as a tuple of [Failure] and [Entity${CommonFunctions.instance.capitalize(feature)}].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  $returnType ${CommonFunctions.instance.camelCase(usecase)}($params) ${((usecaseType == UseCaseType.stream) || (usecaseType == UseCaseType.simpleStream)) ? "" : "async"} {
    try {
      ${((usecaseType == UseCaseType.stream) || (usecaseType == UseCaseType.simpleStream)) ? "" : "final result = await dataSource.${CommonFunctions.instance.camelCase(usecase)}($callParams);"}
      ${((usecaseType == UseCaseType.stream) || (usecaseType == UseCaseType.simpleStream)) ? 
'''
return dataSource.${CommonFunctions.instance.camelCase(usecase)}($callParams)
        .map((datas) {
          return (null, datas?.toEntity());
      });
'''
      : "return (null, result?.toEntity());"}
    } catch (e) {
      rethrow;
    }
  }
''';
  }).toList();

  return '''
${featuresStrategy == FeaturesStrategy.independantModules ? '''
import 'package:core/core/errors/failure.dart';
''' : '''
import '../../../../core/errors/failure.dart';
'''
}

import '../../domain/entities/entity_$feature.dart';
import '../../domain/repositories/${feature}_repository.dart';
import '../data_sources/${feature}_data_source.dart';

/// A class that implements [${CommonFunctions.instance.capitalize(feature)}Repository].
///
/// The class is named [${CommonFunctions.instance.capitalize(feature)}RepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class ${CommonFunctions.instance.capitalize(feature)}RepositoryImpl implements ${CommonFunctions.instance.capitalize(feature)}Repository {

  final ${CommonFunctions.instance.capitalize(feature)}DataSource dataSource;
  const ${CommonFunctions.instance.capitalize(feature)}RepositoryImpl(this.dataSource);

${methods.join("\n")}

}
''';
}
