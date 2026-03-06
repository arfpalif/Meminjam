import 'package:supabase_flutter/supabase_flutter.dart';

class SplashRepository {
  Session? getSession() {
    return Supabase.instance.client.auth.currentSession;
  }
}
