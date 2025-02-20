import 'package:logger/logger.dart';
import 'dart:io' as io;

/// The singleton logger instance for the application.
///
/// This logger uses the `PrettyPrinter` from the `logger` package, configured
/// to print pretty and colored logs to the console. It automatically checks
/// whether the console supports ANSI escape codes for colored output.
class AppLogger extends Logger {
  /// The underlying logger instance.
  final logger = Logger(
    printer: PrettyPrinter(
      colors: io.stdout.supportsAnsiEscapes, // Enable colors if supported.
      printEmojis: true, // Print emojis in log output.
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart, // Format for datetime in logs.
    ),
  );

  /// The singleton instance of [AppLogger].
  ///
  /// This ensures that only one instance of [AppLogger] is created throughout
  /// the application.
  static final AppLogger INSTANCE = AppLogger._internal();

  /// Private constructor for the singleton pattern.
  AppLogger._internal();
}
