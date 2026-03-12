import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../core/supabase_config.dart';
import '../models/subscription_tier.dart';
import 'storage_service.dart';
import '../models/word_model.dart';
import 'auth_service.dart';

class SupabaseSyncService {
  final _supabase = SupabaseConfig.client;
  final StorageService _localStorage;
  final AuthService _auth;
  final _uuid = const Uuid();
  
  // Sync state
  final _syncQueue = <SyncOperation>[];
  bool _isSyncing = false;
  Timer? _syncTimer;
  StreamSubscription? _connectivitySub;
  StreamSubscription? _realtimeSub;
  
  // Real-time ghost trails (multiplayer)
  final _ghostTrailController = StreamController<GhostTrail>.broadcast();
  Stream<GhostTrail> get ghostTrails => _ghostTrailController.stream;

  SupabaseSyncService(this._localStorage, this._auth) {
    _initialize();
  }

  void _initialize() {
    // Auto-sync every 30 seconds when online
    _syncTimer = Timer.periodic(const Duration(seconds: 30), (_) => sync());
    
    // Listen for connectivity changes
    _connectivitySub = Connectivity().onConnectivityChanged.listen((result) {
      if (!result.contains(ConnectivityResult.none)) {
        _processSyncQueue();
      }
    });
  }

  // ==================== AUTH ====================
  
  Future<String?> getOrCreateUserId() async {
    // Try to get existing session
    final session = _supabase.auth.currentSession;
    if (session != null) return session.user.id;
    
    // Check local storage for anonymous ID
    final box = await Hive.openBox('auth');
    var deviceId = box.get('device_id') as String?;
    
    if (deviceId == null) {
      // Create new anonymous user
      deviceId = _uuid.v4();
      await box.put('device_id', deviceId);
      
      // Sign up anonymously with device ID
      final response = await _supabase.auth.signUp(
        email: 'anon_$deviceId@foco.app',
        password: _hashDeviceId(deviceId),
      );
      
      return response.user?.id;
    }
    
    // Sign in existing anonymous user
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: 'anon_$deviceId@foco.app',
        password: _hashDeviceId(deviceId),
      );
      return response.user?.id;
    } catch (e) {
      // If sign in fails, create new account
      final response = await _supabase.auth.signUp(
        email: 'anon_$deviceId@foco.app',
        password: _hashDeviceId(deviceId),
      );
      return response.user?.id;
    }
  }

  String _hashDeviceId(String deviceId) {
    final bytes = utf8.encode(deviceId);
    final digest = sha256.convert(bytes);
    return digest.toString().substring(0, 32); // Use as password
  }

  Future<void> upgradeToEmailAuth(String email, String password) async {
    // Link anonymous account to real email
    await _supabase.auth.updateUser(
      UserAttributes(email: email, password: password),
    );
  }

  // ==================== SYNC OPERATIONS ====================
  
  Future<void> sync() async {
    if (_isSyncing) return;
    final result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.none)) return; 
    
    _isSyncing = true;
    final userId = _auth.effectiveUserId;

    try {
      await _syncUserProgress(userId);
      await _syncDiscoveredWords(userId);
      await _syncIlluminationRecords(userId);
      await _pullRemoteChanges(userId);
    } catch (e) {
      debugPrint('Sync error: $e');
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _syncUserProgress(String userId) async {
    final local = await _localStorage.getProgress(userId); // Fix getProgress access
    
    // Upsert to Supabase
    await _supabase.from('user_progress').upsert({
      'user_id': userId,
      'source_language': local.sourceLanguageCode,
      'target_language': local.targetLanguageCode,
      'current_battery': local.currentBattery,
      'current_streak': local.currentStreak,
      'total_words_illuminated': local.totalWordsIlluminated,
      'total_scenes_completed': local.totalScenesCompleted,
      'last_session_date': local.lastSessionDate?.toIso8601String(),
      'subscription_tier': local.subscription?.tierId ?? 'scout',
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'user_id');
  }

  Future<void> _syncDiscoveredWords(String userId) async {
    final words = _localStorage.getAllDiscoveredWords();
    
    for (final word in words) {
      if (word.discoveredAt == null) continue;
      
      await _supabase.from('discovered_words').upsert({
        'user_id': userId,
        'word_id': word.id,
        'language_code': word.languageCode,
        'discovered_at': word.discoveredAt!.toIso8601String(),
        'illumination_strength': word.illuminationStrength,
        'synced_at': DateTime.now().toIso8601String(),
      }, onConflict: 'user_id,word_id');
    }
  }

  Future<void> _syncIlluminationRecords(String userId) async {
    final records = _localStorage.getAllIlluminationRecords();
    
    for (final record in records) {
      await _supabase.from('illumination_records').upsert({
        'user_id': userId,
        'word_id': record.wordId,
        'scene_id': record.sceneId,
        'illuminated_at': record.illuminatedAt.toIso8601String(),
        'time_to_find_seconds': record.timeToFindSeconds,
      }, onConflict: 'user_id,word_id,illuminated_at');
    }
  }

  Future<void> _pullRemoteChanges(String userId) async {
    // Get remote progress
    final remoteProgress = await _supabase
        .from('user_progress')
        .select()
        .eq('user_id', userId)
        .maybeSingle(); // Use maybeSingle to prevent exceptions if zero rows
    
    if (remoteProgress != null) {
      // Conflict resolution: Keep higher streak and total words
      final local = await _localStorage.getProgress(userId); 
      
      final merged = local.copyWith(
        currentStreak: remoteProgress['current_streak'] > local.currentStreak
            ? remoteProgress['current_streak']
            : local.currentStreak,
        totalWordsIlluminated: remoteProgress['total_words_illuminated'] > local.totalWordsIlluminated
            ? remoteProgress['total_words_illuminated']
            : local.totalWordsIlluminated,
        // Restore subscription status from cloud (prevents downgrade)
        subscription: remoteProgress['subscription_tier'] == 'illuminator'
            ? SubscriptionTier.premium()
            : local.subscription,
      );
      
      await _localStorage.updateProgress(merged);
    }
    
    // Get remote words (for restoration on new device)
    final remoteWords = await _supabase
        .from('discovered_words')
        .select()
        .eq('user_id', userId);
    
    // Merge remote words into local (last-write-wins)
    for (final rw in remoteWords) {
      final existing = _localStorage.getWord(rw['word_id']);
      if (existing == null || existing.discoveredAt == null) {
        // Create word from remote
        final word = Word(
          id: rw['word_id'],
          text: rw['word_text'] ?? 'Unknown', // You'll need to store text or fetch from scene
          transliteration: rw['transliteration'] ?? '',
          translation: rw['translation'] ?? '',
          languageCode: rw['language_code'],
          positionX: 0, // Restore from scene data
          positionY: 0,
          category: 'unknown',
          isDiscovered: true,
          discoveredAt: DateTime.parse(rw['discovered_at']),
          illuminationStrength: rw['illumination_strength'] ?? 100,
        );
        await _localStorage.saveDiscoveredWord(word);
      }
    }
  }

  // ==================== REAL-TIME GHOST TRAILS ====================
  
  void subscribeToScene(String sceneId) {
    // Unsubscribe previous
    _realtimeSub?.cancel();
    
    // Subscribe to presence/track for ghost trails
    final channel = _supabase.channel('scene:$sceneId');
    
    channel
      .onPresenceSync((payload) {
        final presenceState = channel.presenceState();
        
        for (final p in presenceState) {
          final data = (p as dynamic).payload;
          if (data['user_id'] != _supabase.auth.currentUser?.id) {
            _ghostTrailController.add(GhostTrail(
              userId: data['user_id'].toString(),
              positionX: (data['position_x'] as num).toDouble(),
              positionY: (data['position_y'] as num).toDouble(),
              timestamp: DateTime.now(),
            ));
          }
        }
      })
      .subscribe();
    
    // Send own position every 100ms while in scene
    _realtimeSub = Stream.periodic(const Duration(milliseconds: 100)).listen((_) {
      // This would be triggered by game provider sending position updates
    });
  }

  Future<void> updatePosition(String sceneId, double x, double y) async {
    final channel = _supabase.channel('scene:$sceneId');
    await channel.track({
      'user_id': _supabase.auth.currentUser?.id,
      'position_x': x,
      'position_y': y,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void unsubscribeFromScene() {
    _realtimeSub?.cancel();
    _supabase.removeAllChannels();
  }

  // ==================== OFFLINE QUEUE ====================
  
  void queueOperation(SyncOperation operation) {
    _syncQueue.add(operation);
    _persistQueue();
    
    // Try immediate sync if online
    Connectivity().checkConnectivity().then((result) {
      if (!result.contains(ConnectivityResult.none)) {
        _processSyncQueue();
      }
    });
  }

  Future<void> _processSyncQueue() async {
    if (_syncQueue.isEmpty) return;
    
    final userId = await getOrCreateUserId();
    if (userId == null) return;
    
    while (_syncQueue.isNotEmpty) {
      final op = _syncQueue.first;
      try {
        switch (op.type) {
          case SyncType.wordDiscovery:
            await _supabase.from('discovered_words').insert(op.data);
            break;
          case SyncType.progressUpdate:
            await _supabase.from('user_progress').upsert(op.data);
            break;
          case SyncType.illuminationRecord:
            await _supabase.from('illumination_records').insert(op.data);
            break;
        }
        _syncQueue.removeAt(0);
      } catch (e) {
        break; // Stop processing on error, retry later
      }
    }
    
    _persistQueue();
  }

  void _persistQueue() {
    // Save queue to Hive for persistence across app restarts
    final box = Hive.box('sync_queue');
    box.put('operations', _syncQueue.map((e) => e.toJson()).toList());
  }

  // ==================== LEADERBOARD & COMPETITION ====================
  
  Future<List<CompetitionResult>> getLeaderboard(String sceneId) async {
    final results = await _supabase
        .from('competition_results')
        .select()
        .eq('scene_id', sceneId)
        .order('time_seconds', ascending: true)
        .limit(10);
    
    return results.map((r) => CompetitionResult(
      username: r['username'] ?? 'Anonymous',
      timeSeconds: r['time_seconds'],
      date: DateTime.parse(r['created_at']),
    )).toList();
  }

  Future<void> submitCompetitionResult(String sceneId, int timeSeconds) async {
    final userId = await getOrCreateUserId();
    final username = await _getUsername();
    
    await _supabase.from('competition_results').insert({
      'user_id': userId,
      'scene_id': sceneId,
      'time_seconds': timeSeconds,
      'username': username,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<String> _getUsername() async {
    final box = await Hive.openBox('profile');
    return box.get('username', defaultValue: 'Hunter${_uuid.v4().substring(0, 4)}');
  }

  void dispose() {
    _syncTimer?.cancel();
    _connectivitySub?.cancel();
    _realtimeSub?.cancel();
    _ghostTrailController.close();
    _supabase.removeAllChannels();
  }
}

// ==================== DATA CLASSES ====================

enum SyncType { wordDiscovery, progressUpdate, illuminationRecord }

class SyncOperation {
  final SyncType type;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  SyncOperation({
    required this.type,
    required this.data,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'data': data,
    'timestamp': timestamp.toIso8601String(),
  };
}

class GhostTrail {
  final String userId;
  final double positionX;
  final double positionY;
  final DateTime timestamp;

  GhostTrail({
    required this.userId,
    required this.positionX,
    required this.positionY,
    required this.timestamp,
  });
}

class CompetitionResult {
  final String username;
  final int timeSeconds;
  final DateTime date;

  CompetitionResult({
    required this.username,
    required this.timeSeconds,
    required this.date,
  });
}
