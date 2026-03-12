import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../core/supabase_config.dart';
import '../models/user_progress_model.dart';

enum AuthState {
  guest,           // Playing anonymously, device ID only
  authenticating,  // In progress
  authenticated, // Full user account
  error,
}

class AuthUser {
  final String id;
  final String? email;
  final bool isAnonymous;
  final DateTime createdAt;

  AuthUser({
    required this.id,
    this.email,
    required this.isAnonymous,
    required this.createdAt,
  });
}

class AuthService extends ChangeNotifier {
  final _supabase = SupabaseConfig.client;
  final _uuid = const Uuid();
  
  AuthState _state = AuthState.guest;
  AuthState get state => _state;
  
  AuthUser? _user;
  AuthUser? get user => _user;
  
  String? _deviceId;
  String? get deviceId => _deviceId;

  AuthService() {
    _initialize();
  }

  Future<void> _initialize() async {
    // Check if we have a stored device ID (guest mode)
    final box = await Hive.openBox('auth');
    _deviceId = box.get('device_id') as String?;
    
    // Check if we have a real Supabase session
    final session = _supabase.auth.currentSession;
    if (session != null) {
      _user = AuthUser(
        id: session.user.id,
        email: session.user.email,
        isAnonymous: false,
        createdAt: DateTime.now(), // Get from metadata if needed
      );
      _state = AuthState.authenticated;
      notifyListeners();
      return;
    }
    
    // No session = guest mode
    if (_deviceId == null) {
      _deviceId = _uuid.v4();
      await box.put('device_id', _deviceId);
    }
    
    _state = AuthState.guest;
    notifyListeners();
  }

  // ==================== GUEST MODE (DEFAULT) ====================
  
  /// Get the effective user ID for data storage (device ID for guests, user ID for auth)
  String get effectiveUserId {
    return _user?.id ?? _deviceId!;
  }
  
  bool get isAuthenticated => _state == AuthState.authenticated;

  // ==================== EMAIL/PASSWORD AUTH ====================
  
  Future<void> signUpWithEmail(String email, String password) async {
    _state = AuthState.authenticating;
    notifyListeners();
    
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'device_id': _deviceId, // Link to guest data for migration
          'guest_progress': true,
        },
      );
      
      if (response.user != null) {
        _user = AuthUser(
          id: response.user!.id,
          email: response.user!.email,
          isAnonymous: false,
          createdAt: DateTime.now(),
        );
        _state = AuthState.authenticated;
        
        // Migrate guest data to permanent account
        await _migrateGuestDataToUser(response.user!.id);
      }
    } catch (e) {
      _state = AuthState.error;
      debugPrint('Auth error: $e');
      rethrow;
    }
    notifyListeners();
  }

  Future<void> signInWithEmail(String email, String password) async {
    _state = AuthState.authenticating;
    notifyListeners();
    
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        _user = AuthUser(
          id: response.user!.id,
          email: response.user!.email,
          isAnonymous: false,
          createdAt: DateTime.now(),
        );
        _state = AuthState.authenticated;
      }
    } catch (e) {
      _state = AuthState.error;
      debugPrint('Sign in error: $e');
      rethrow;
    }
    notifyListeners();
  }

  // ==================== OAUTH (GOOGLE/APPLE) ====================
  
  Future<void> signInWithGoogle() async {
    _state = AuthState.authenticating;
    notifyListeners();
    
    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.foco://callback',
      );
      
      // Note: OAuth flow completes in callback, session will be picked up by listener
    } catch (e) {
      _state = AuthState.guest; // Revert to guest on error
      notifyListeners();
      rethrow;
    }
  }

  // ==================== GUEST UPGRADE ====================
  
  /// Called after OAuth redirect or when we detect a new session
  Future<void> handleAuthCallback() async {
    final session = _supabase.auth.currentSession;
    if (session != null && _state == AuthState.guest) {
      // We were guest, now we're authenticated - migrate data
      await _migrateGuestDataToUser(session.user.id);
      
      _user = AuthUser(
        id: session.user.id,
        email: session.user.email,
        isAnonymous: false,
        createdAt: DateTime.now(),
      );
      _state = AuthState.authenticated;
      notifyListeners();
    }
  }

  Future<void> _migrateGuestDataToUser(String userId) async {
    final box = await Hive.openBox('auth');
    final oldDeviceId = _deviceId;
    
    if (oldDeviceId == null) return;
    
    // Migrate Hive data from device ID to user ID
    final progressBox = Hive.box<UserProgress>('user_progress');
    final oldProgress = progressBox.get(oldDeviceId);
    
    if (oldProgress != null) {
      // Save under new user ID
      final newProgress = oldProgress.copyWith(userId: userId);
      await progressBox.put(userId, newProgress);
      await progressBox.delete(oldDeviceId);
    }
    
    // Mark migration complete
    await box.put('migrated_from', oldDeviceId);
    await box.put('migrated_to', userId);
    
    // Trigger server-side migration via RPC (optional)
    try {
      await _supabase.rpc('migrate_guest_data', params: {
        'old_device_id': oldDeviceId,
        'new_user_id': userId,
      });
    } catch (e) {
      debugPrint('Server migration skipped: $e');
    }
  }

  // ==================== SIGN OUT ====================
  
  Future<void> signOut() async {
    await _supabase.auth.signOut();
    
    // Reset to guest mode with new device ID
    final box = await Hive.openBox('auth');
    _deviceId = _uuid.v4();
    await box.put('device_id', _deviceId);
    
    _user = null;
    _state = AuthState.guest;
    notifyListeners();
  }

  // ==================== PASSWORD RESET ====================
  
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }
}
