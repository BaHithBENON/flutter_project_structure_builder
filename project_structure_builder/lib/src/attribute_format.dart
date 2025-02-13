import 'enums.dart';
import 'functions.dart';

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