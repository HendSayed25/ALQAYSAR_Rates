import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientProvider {
  static const String SUPABASE_URL = "https://skvflslnqzgxihhocwrs.supabase.co";
  static const String SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNrdmZsc2xucXpneGloaG9jd3JzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY4ODIwNTksImV4cCI6MjA1MjQ1ODA1OX0.jTMgx7aSNOK_yVdH0ZQY_1WM9pAh2C42yv1m5Xq3Nfc";

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: SUPABASE_URL,
      anonKey: SUPABASE_ANON_KEY,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
