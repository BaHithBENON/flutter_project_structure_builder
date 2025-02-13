import '../../attribute_format.dart';

/// Generates a Dart class containing static constants for database attributes.
///
/// This function takes a list of [AttributeFormat] objects and generates a 
/// class named `DatabaseAttributesResources`. Each attribute is represented 
/// as a static constant string within the class.
///
/// [attributes] is the list of attributes used to generate the static constants.
String generateDatabaseAttributesResources({required List<AttributeFormat> attributes}) {
  // Create a map of unique attribute names to their raw names
  final uniqueAttributes = {
    for (var attr in attributes) attr.name: attr.rawName
  };

  // Generate the Dart class with static constants for each attribute
  return """
class DatabaseAttributesResources {
  // Attributes
  ${uniqueAttributes.entries.map((e) => 'static const String ${e.key} = "${e.value}";').join("\n  ")}
}
""";
}
