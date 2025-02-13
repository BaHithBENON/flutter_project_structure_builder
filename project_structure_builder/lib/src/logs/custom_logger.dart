import 'package:logger/logger.dart';
import 'dart:io' as io;

/// A custom logger class.
///
/// This class provides a custom logger that will print pretty and colored logs
/// to the console. It uses the [PrettyPrinter] from the [logger] package to
/// format the logs.
///
/// The logger is always at the highest level, so it will print all logs
/// regardless of the level.
///
/// The logger is also always in the same instance, so it can be accessed from
/// anywhere in the code.
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


