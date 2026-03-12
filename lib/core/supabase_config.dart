import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class SupabaseConfig {
  // Replace with your Supabase credentials
  static const String supabaseUrl = 'https://uyqwukuuwokdemmraxqk.supabase.co';
  static const String supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV5cXd1a3V1d29rZGVtbXJheHFrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMyNzAyMDEsImV4cCI6MjA4ODg0NjIwMX0.GfZFVzWzvMrtFfQtKlJ04oBAuAdIB1IKYA3a98VhFh0';
  
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
      debug: kDebugMode,
    );
  }
  
  static SupabaseClient get client => Supabase.instance.client;
}
