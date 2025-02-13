  import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

/// Generates a Dart class template for a clean architecture entity.
///
/// This function creates an entity class with specified attributes that
/// extends `Equatable` for equality comparison.
///
/// [feature] is the name of the feature for which the entity is created.
/// [attributes] is a list of attributes that define the fields of the entity.
String generateCleanEntityTemplate({
  required String feature,
  List<AttributeFormat> attributes = const [],
}) {
  // Capitalize the feature name to create the entity class name.
  final entityName = 'Entity${CommonFunctions.instance.capitalize(feature)}';

  // Generate the fields for the entity based on the attributes provided.
  final fields = attributes
      .map((attribute) => '  final ${attribute.type.value}${attribute.type == DartDataType.dynamicType ? '' : '?'} ${attribute.name};')
      .join('\n');

  // Generate the constructor parameters for the entity.
  final constructorParams = attributes.map((attribute) => 'this.${attribute.name}').join(', ');

  // Generate the list of properties for the Equatable's props method.
  final propsList = attributes.map((attribute) => attribute.name).join(',\n    ');

  // Return the full entity class template as a string.
  return '''
import 'package:equatable/equatable.dart';

class $entityName extends Equatable {
$fields

  // Const constructor allowing optional named parameters.
  const $entityName(${constructorParams.isEmpty ? '' : '{ $constructorParams }'});

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    $propsList
  ];
}
''';
}
