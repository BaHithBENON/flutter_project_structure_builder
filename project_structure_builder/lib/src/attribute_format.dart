import 'enums.dart';
import 'functions.dart';

/// Represents an attribute in the database or class or entity.
/// 
/// Contains the attribute name, its raw name (i.e. the name as it is in the
/// database or class or entity) and its type.
class AttributeFormat {
  final String name;
  final String rawName;
  final DartDataType type;
  AttributeFormat(this.rawName, this.type) 
    : name = CommonFunctions.instance.toCamelCaseWithoutUnderscore(rawName);

  @override
  String toString() {
    return 'AttributeFormat(name: $name, type: ${type.value})';
  }
}
