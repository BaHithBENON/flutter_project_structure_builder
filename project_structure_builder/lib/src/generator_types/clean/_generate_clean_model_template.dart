import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

String generateCleanModelTemplate({required String feature, List<AttributeFormat> attributes = const [], required FeaturesStrategy featuresStrategy,}) {
  final className = "Model${CommonFunctions.instance.capitalize(feature)}";
  final entityName = "Entity${CommonFunctions.instance.capitalize(feature)}";
  
  // Génération des super paramètres dans le constructeur
  final superParams = attributes.map((attr) => "super.${attr.name}").join(", ");

  // Génération du `fromJson` method
  final fromJsonParams = attributes.map((attr) {
    final key = attr.name;
    final value = "json[DatabaseAttributesResources.${attr.name}]";
    return "$key: $value,";
  }).join("\n      ");

  // Génération du `toJson` method
  final toJsonParams = attributes.map((attr) {
    return "DatabaseAttributesResources.${attr.name}: ${attr.name},";
  }).join("\n      ");

  // Génération du `copyWith` method
  final copyWithParams = attributes.map((attr) => "${attr.type.value}${attr.type == DartDataType.dynamicType ? "" : "?"} ${attr.name}").join(", ");
  final copyWithAssignments = attributes.map((attr) => "${attr.name}: ${attr.name} ?? this.${attr.name},").join("\n      ");

  return '''
${attributes.isEmpty ? "" : 
featuresStrategy == FeaturesStrategy.independantModules ? '''
import 'package:core/core/resources/database_attributes_resources.dart';
''' : '''
import '../../../../core/resources/database_attributes_resources.dart';
'''
}
import '../../domain/entities/entity_$feature.dart';

class $className extends $entityName {

  const $className(${superParams.isEmpty ? "" : "{ $superParams }" });

  factory $className.fromJson(Map<String, dynamic> json) {
    return $className(
      $fromJsonParams
    );
  }

  Map<String, dynamic> toJson() {
    return {
      $toJsonParams
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      ${toJsonParams.replaceAll("DatabaseAttributesResources.id:", "// DatabaseAttributesResources.id:")}
    };
  }

  factory $className.fromEntity($entityName entity) {
    return $className(
      ${attributes.map((attr) => "${attr.name}: entity.${attr.name},").join("\n      ")}
    );
  }

  $entityName toEntity() {
    return $entityName(
      ${attributes.map((attr) => "${attr.name}: ${attr.name},").join("\n      ")}
    );
  }

  $className copyWith(
    ${ copyWithParams.isEmpty ? "" : "{ $copyWithParams }" }
  ) {
    return $className(
      $copyWithAssignments
    );
  }
}
''';
}
