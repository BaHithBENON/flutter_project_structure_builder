  import '../../attribute_format.dart';
import '../../enums.dart';
import '../../functions.dart';

String generateCleanEntityTemplate({required String feature, List<AttributeFormat> attributes = const []}) {
    final className = "Entity${CommonFunctions.instance.capitalize(feature)}";
    
    // Génération des attributs
    final fields = attributes.map((attr) => "  final ${attr.type.value}${attr.type == DartDataType.dynamicType ? "" : "?"} ${attr.name};").join("\n");
    
    // Génération du constructeur avec paramètres optionnels
    final constructorParams = attributes.map((attr) => "this.${attr.name}").join(", ");
    
    // Génération de la liste `props` pour Equatable
    final propsList = attributes.map((attr) => attr.name).join(",\n    ");

    return '''
import 'package:equatable/equatable.dart';

class $className extends Equatable {

$fields

  const $className(${ constructorParams.isEmpty ? "" : "{ $constructorParams }"});

  @override
  List<Object?> get props => [
    $propsList
  ];
}
''';
}