/// An enumeration of the different types of errors that can occur in the app.
enum ErrorTypes {
  /// A custom error that can be used to represent any type of error.
  customError("Une erreur est survenue", 0, 400),
  ;

  /// A string describing the error.
  final String message;

  /// An integer representing the code of the error.
  final int code;

  /// An integer representing the status code of the error.
  final int statusCode;
  /// A constant constructor that takes a string, an int and an int as
  /// parameters. The constructor will use the parameters to set the [message],
  /// [code] and [statusCode] properties of the class.
  const ErrorTypes(this.message, this.code, this.statusCode);

  /// A method that returns a string containing the value of the [message],
  /// [code] and [statusCode] properties.
  @override
  String toString() {
    return "{ error: $message => code: $code => statusCode: $statusCode }";
  }
}
