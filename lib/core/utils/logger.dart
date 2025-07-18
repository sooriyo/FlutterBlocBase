import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger();

  static void logInfo(String message) => _logger.i(message);
  static void logError(String message, [dynamic error]) => _logger.e(message, error: error);
}
