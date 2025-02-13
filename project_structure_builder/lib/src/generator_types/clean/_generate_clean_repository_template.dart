import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

String generateCleanRepositoryTemplate({
  required List<String> usecases,
  required Map<String, UseCaseType> usecaseTypes,
  required Map<String, List<AttributeFormat>> usecaseAttributes,
  required String feature,
  required FeaturesStrategy featuresStrategy,
}) {

  final List<String> methods = usecases.map((usecase) {

    final usecaseType = usecaseTypes[usecase] ?? UseCaseType.future;
    final attributes = usecaseAttributes[usecase] ?? [];

    final String returnType = "${usecaseType.value}<(Failure?, Entity${CommonFunctions.instance.capitalize(feature)}?)>";

    final String params = attributes.isNotEmpty
        ? "{ ${attributes.map((attr) => "required ${attr.type.target} ${attr.name}").join(", ")} }"
        : "";

    return "  $returnType ${CommonFunctions.instance.camelCase(usecase)}($params);";
  }).toList();

  return '''
${featuresStrategy == FeaturesStrategy.independantModules ? '''
import 'package:core/core/errors/failure.dart';
''' : '''
import '../../../../core/errors/failure.dart';
'''}

import '../entities/entity_$feature.dart';

abstract class ${CommonFunctions.instance.capitalize(feature)}Repository {

${methods.join("\n")}

}
''';
}
