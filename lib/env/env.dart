import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get supabaseUrl => _get('SUPABASE_URL');
  static String get supabaseAnonKey => _get('SUPABASE_ANON_KEY');

  static String _get(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw Exception('Environment variable $key is not defined in .env file');
    }
    return value;
  }

  static Future<void> init() async {
    await dotenv.load(fileName: ".env");
  }
}
