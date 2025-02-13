import 'package:logger/logger.dart';
import 'dart:io' as io;

class AppLogger extends Logger {
  final logger = Logger(
    printer: PrettyPrinter(
      colors: io.stdout.supportsAnsiEscapes,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: Level.all,
  );

  static final AppLogger instance = AppLogger._internal();
  AppLogger._internal();
}


