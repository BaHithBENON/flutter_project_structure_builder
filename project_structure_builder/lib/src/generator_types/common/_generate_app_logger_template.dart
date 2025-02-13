String generateAppLoggerTemplate() {
  return '''
import 'package:logger/logger.dart';
import 'dart:io' as io;

class AppLogger extends Logger {
  final logger = Logger(
    printer: PrettyPrinter(
      colors: io.stdout.supportsAnsiEscapes,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  // ignore: non_constant_identifier_names
  static final AppLogger INSTANCE = AppLogger._internal();
  AppLogger._internal();
}


''';
}