import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

String generateMvcModelTemplate({required String feature, List<AttributeFormat> attributes = const []}) {
  final className = "Model${CommonFunctions.instance.capitalize(feature)}";

  // Génération des attributs
  final fields = attributes.map((attr) => "  final ${attr.type.value}? ${attr.name};").join("\n");
  
  // Génération du constructeur avec paramètres optionnels
  final constructorParams = attributes.map((attr) => "this.${attr.name}").join(", ");

  // Génération de la liste `props` pour Equatable
  final propsList = attributes.map((attr) => attr.name).join(",\n    ");

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
import 'package:equatable/equatable.dart';
${attributes.isEmpty ? "" : "import '../../../core/resources/database_attributes_resources.dart';"}

class $className extends Equatable  {

$fields

  const $className(${ constructorParams.isEmpty ? "" : "{ $constructorParams }"});

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
