import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

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

class ${CommonFunctions.instance.capitalize(feature)}RepositoryImpl implements ${CommonFunctions.instance.capitalize(feature)}Repository {

  final ${CommonFunctions.instance.capitalize(feature)}DataSource dataSource;
  const ${CommonFunctions.instance.capitalize(feature)}RepositoryImpl(this.dataSource);

${methods.join("\n")}

}
''';
}
