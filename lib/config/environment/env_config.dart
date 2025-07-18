import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }

  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'dev';
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'https://api.dev.example.com';
}