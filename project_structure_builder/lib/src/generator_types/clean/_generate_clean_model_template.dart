import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

/// This function generates a clean model template
/// 
/// This template is made up of a class that extends [Entity] and overrides the [toJson] and [copyWith] methods
/// 
/// The [toJson] method returns a map of the attributes of the model
/// 
/// The [copyWith] method returns a new instance of the model with the given attributes
/// 
/// The model also has a [fromJson] method that creates a new instance of the model from a map
/// 
/// The model also has a [fromEntity] method that creates a new instance of the model from an [Entity]
/// 
/// The model also has a [toEntity] method that returns a new instance of [Entity] from the model
/// 
/// The model also has a [toJsonWithoutId] method that returns a map of the attributes of the model without the id
String generateCleanModelTemplate({required String feature, List<AttributeFormat> attributes = const [], required FeaturesStrategy featuresStrategy,}) {
  final className = "Model${CommonFunctions.instance.capitalize(feature)}";
  final entityName = "Entity${CommonFunctions.instance.capitalize(feature)}";
  
  // Super params constructor
  final superParams = attributes.map((attr) => "super.${attr.name}").join(", ");

  // Génération of the `fromJson` method
  final fromJsonParams = attributes.map((attr) {
    final key = attr.name;
    final value = "json[DatabaseAttributesResources.${attr.name}]";
    return "$key: $value,";
  }).join("\n      ");

  // Génération of the `toJson` method
  final toJsonParams = attributes.map((attr) {
    return "DatabaseAttributesResources.${attr.name}: ${attr.name},";
  }).join("\n      ");

  // Génération of the `copyWith` method
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

/// A class that extends [Entity] and overrides the [toJson] and [copyWith] methods
class $className extends $entityName {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const $className(${superParams.isEmpty ? "" : "{ $superParams }" });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory $className.fromJson(Map<String, dynamic> json) {
    return $className(
      $fromJsonParams
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      $toJsonParams
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      ${toJsonParams.replaceAll("DatabaseAttributesResources.id:", "// DatabaseAttributesResources.id:")}
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory $className.fromEntity($entityName entity) {
    return $className(
      ${attributes.map((attr) => "${attr.name}: entity.${attr.name},").join("\n      ")}
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  $entityName toEntity() {
    return $entityName(
      ${attributes.map((attr) => "${attr.name}: ${attr.name},").join("\n      ")}
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
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