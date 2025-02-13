
  import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

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

class ${CommonFunctions.instance.generateUseCaseClassName(usecase)} implements ${useCaseTypeTarget.target}<Entity${CommonFunctions.instance.capitalize(feature)}, NoParams> {

  final ${CommonFunctions.instance.capitalize(feature)}Repository repository;
  const ${CommonFunctions.instance.generateUseCaseClassName(usecase)}({required this.repository});

  @override
  $returnType<(Failure?, Entity${CommonFunctions.instance.capitalize(feature)}?)> call(NoParams params) ${isStream ? "" : "async"} {
    return ${isStream ? "" : "await"} repository.${CommonFunctions.instance.camelCase(usecase)}();
  }
}

''';
}

String generateCleanUseCaseTemplateWithAttributes({
  required String usecase, required UseCaseType usecaseType, required List<AttributeFormat> attributes, required String feature,
  required FeaturesStrategy featuresStrategy,
}) {

  final isStream = usecaseType == UseCaseType.stream || usecaseType == UseCaseType.simpleStream;
  final useCaseTypeTarget = isStream ? UseCaseType.stream : UseCaseType.future;
  final returnType = isStream ? UseCaseType.stream.value : UseCaseType.future.value;

  final paramsClassName = "${CommonFunctions.instance.capitalize(usecase)}UseCaseParams";
  final paramsFields = attributes.map((attr) => "  final ${attr.type.target} ${attr.name};").join("\n");
  final paramsConstructor = "  const $paramsClassName({ ${attributes.map((attr) => "required this.${attr.name}").join(", ")} });";

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

class ${CommonFunctions.instance.generateUseCaseClassName(usecase)} implements ${useCaseTypeTarget.target}<Entity${CommonFunctions.instance.capitalize(feature)}, $paramsClassName> {

  final ${CommonFunctions.instance.capitalize(feature)}Repository repository;
  const ${CommonFunctions.instance.generateUseCaseClassName(usecase)}({required this.repository});

  @override
  $returnType<(Failure?, Entity${CommonFunctions.instance.capitalize(feature)}?)> call($paramsClassName params) ${isStream ? "" : "async"} {
    return ${isStream ? "" : "await"} repository.${CommonFunctions.instance.camelCase(usecase)}(${attributes.map((attr) => "${attr.name}: params.${attr.name}").join(", ")});
  }
}

class $paramsClassName {
$paramsFields
$paramsConstructor
}
''';
}