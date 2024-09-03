import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiUrl {
    return dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000/api';
  }
}
