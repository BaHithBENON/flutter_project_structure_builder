import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

/// Generates a model template for the given [feature].
///
/// The generated class extends [Equatable] and overrides the [toJson] and [copyWith] methods.
///
/// The [toJson] method returns a map of the attributes of the model.
///
/// The [copyWith] method returns a new instance of the model with the given attributes.
///
/// The model also has a [toJsonWithoutId] method that returns a map of the attributes of the model without the id.
String generateMvcModelTemplate({required String feature, List<AttributeFormat> attributes = const []}) {
  final className = "Model${CommonFunctions.instance.capitalize(feature)}";

  /// Génération of the fields
  final fields = attributes.map((attr) => "  final ${attr.type.value}${attr.type == DartDataType.dynamicType ? "" : "?"} ${attr.name};").join("\n");
  
  /// Génération of the constructor
  final constructorParams = attributes.map((attr) => "this.${attr.name}").join(", ");

  /// Génération of the `props` method
  final propsList = attributes.map((attr) => attr.name).join(",\n    ");

  /// Génération of the `fromJson` method
  final fromJsonParams = attributes.map((attr) {
    final key = attr.name;
    final value = "json[DatabaseAttributesResources.${attr.name}]";
    return "$key: $value,";
  }).join("\n      ");

  /// Génération of the `toJson` method
  final toJsonParams = attributes.map((attr) {
    return "DatabaseAttributesResources.${attr.name}: ${attr.name},";
  }).join("\n      ");

  /// Génération of the `copyWith` method
  final copyWithParams = attributes.map((attr) => "${attr.type.value}${attr.type == DartDataType.dynamicType ? "" : "?"} ${attr.name}").join(", ");
  final copyWithAssignments = attributes.map((attr) => "${attr.name}: ${attr.name} ?? this.${attr.name},").join("\n      ");

  return '''
import 'package:equatable/equatable.dart';
${attributes.isEmpty ? "" : "import '../../../core/resources/database_attributes_resources.dart';"}

/// A model for the feature [feature].
class $className extends Equatable  {

$fields

  /// Constructor for the model.
  const $className(${ constructorParams.isEmpty ? "" : "{ $constructorParams }"});

  /// Factory constructor for the model from a json map.
  factory $className.fromJson(Map<String, dynamic> json) {
    return $className(
      $fromJsonParams
    );
  }

  /// Converts the model to a json map.
  Map<String, dynamic> toJson() {
    return {
      $toJsonParams
    };
  }

  /// Converts the model to a json map without the id.
  Map<String, dynamic> toJsonWithoutId() {
    return {
      ${toJsonParams.replaceAll("DatabaseAttributesResources.id:", "// DatabaseAttributesResources.id:")}
    };
  }

  /// Creates a new instance of the model with the given attributes.
  $className copyWith(${
    copyWithParams.isEmpty ? "" : "{ $copyWithParams }"
  }) {
    return $className(
      $copyWithAssignments
    );
  }

  /// List of props for the [Equatable] class.
  @override
  List<Object?> get props => [
    $propsList
  ];
}
''';
}
