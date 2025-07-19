import '../../config/environment/env_config.dart';

class ApiConstants {
  static String get baseUrl => EnvConfig.apiBaseUrl;
  static const int connectTimeout = 30000; // milliseconds
  static const int receiveTimeout = 30000; // milliseconds
}
