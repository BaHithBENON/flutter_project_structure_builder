import '../../attribute_format.dart';

String generateDatabaseAttributesResources({required List<AttributeFormat> attributes}) {

  final uniqueAttributes = {
    for (var attr in attributes) attr.name: attr.rawName
  };

  return """
class DatabaseAttributesResources {
  // Attributes
  ${uniqueAttributes.entries.map((e) => 'static const String ${e.key} = "${e.value}";').join("\n  ")}
}
""";
}