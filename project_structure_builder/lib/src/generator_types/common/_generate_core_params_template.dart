/// Generates the core parameters template.
///
/// The core parameters template contains the [NoParams] class, which is used to
/// represent no parameters, and the [VoidType] class, which is used to represent
/// a void type.
String generateCoreParamsTemplate() {
  return '''
/// Represents no parameters.
class NoParams {}

/// Represents a void type.
class VoidType {}
''';
}
