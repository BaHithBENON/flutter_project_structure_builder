import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

/// Generates a MVVM model template for the given [feature].
///
/// The generated class is called [Model<feature>] and extends [Equatable].
/// It has a constructor with optional parameters and implements the [toJson],
/// [fromJson], and [copyWith] methods.
///
/// If [attributes] is not empty, it is used to generate the fields of the model.
/// Otherwise, an empty model is generated.
String generateMvvmModelTemplate({required String feature, List<AttributeFormat> attributes = const []}) {
  final className = "Model${CommonFunctions.instance.capitalize(feature)}";

  // Generates the fields
  final fields = attributes.map((attr) => "  final ${attr.type.value}${attr.type == DartDataType.dynamicType ? "" : "?"} ${attr.name};").join("\n");
  
  // Generates the constructor parameters
  final constructorParams = attributes.map((attr) => "this.${attr.name}").join(", ");

  // Generates the `props` method
  final propsList = attributes.map((attr) => attr.name).join(",\n    ");

  //  Generates the `fronJson` method
  final fromJsonParams = attributes.map((attr) {
    final key = attr.name;
    final value = "json[DatabaseAttributesResources.${attr.name}]";
    return "$key: $value,";
  }).join("\n      ");

  // Generates the `toJson` method
  final toJsonParams = attributes.map((attr) {
    return "DatabaseAttributesResources.${attr.name}: ${attr.name},";
  }).join("\n      ");

  // Generates the `copyWith` method
  final copyWithParams = attributes.map((attr) => "${attr.type.value}${attr.type == DartDataType.dynamicType ? "" : "?"} ${attr.name}").join(", ");
  final copyWithAssignments = attributes.map((attr) => "${attr.name}: ${attr.name} ?? this.${attr.name},").join("\n      ");

  return '''
${attributes.isEmpty ? "" : "import '../../../core/resources/database_attributes_resources.dart';"}
/// A model class for the feature [$feature].
///
/// This class is a view model for the feature [$feature].
/// It has a constructor with optional parameters and implements the [toJson],
/// [fromJson], and [copyWith] methods.
class $className extends Equatable  {

/// The fields of the model.
$fields

/// The constructor of the model.
/// 
/// The constructor takes a map of attributes as a parameter and returns an instance of the model.
  const $className(${ constructorParams.isEmpty ? "" : "{ $constructorParams }"});

/// Creates a new instance of the model from a map.
/// 
/// The map must contain the following keys: [attributes].
/// 
/// Returns a new instance of the model.
  factory $className.fromJson(Map<String, dynamic> json) {
    return $className(
      $fromJsonParams
    );
  }

/// Converts the model to a map.
/// 
/// The map contains the fields of the model.
/// 
/// Returns a map of the fields of the model.
  Map<String, dynamic> toJson() {
    return {
      $toJsonParams
    };
  }

/// Converts the model to a map without the id.
/// 
/// The map contains the fields of the model without the id.
/// 
/// Returns a map of the fields of the model without the id.
  Map<String, dynamic> toJsonWithoutId() {
    return {
      ${toJsonParams.replaceAll("DatabaseAttributesResources.id:", "// DatabaseAttributesResources.id:")}
    };
  }

/// Creates a new instance of the model with the given attributes.
/// 
/// The attributes are optional.
/// 
/// Returns a new instance of the model with the given attributes.
  $className copyWith(${
    copyWithParams.isEmpty ? "" : "{ $copyWithParams }"
  }) {
    return $className(
      $copyWithAssignments
    );
  }

  @override
  List<Object?> get props => [
    $propsList
  ];
}
''';
}
