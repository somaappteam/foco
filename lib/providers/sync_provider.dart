import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_service.dart';
import '../services/supabase_sync_service.dart';
import 'auth_provider.dart';

final syncServiceProvider = Provider<SupabaseSyncService>((ref) {
  final auth = ref.watch(authServiceProvider);
  return SupabaseSyncService(ref.watch(storageServiceProvider), auth);
});

final syncStatusProvider = StateNotifierProvider<SyncNotifier, SyncStatus>((ref) {
  return SyncNotifier(ref.watch(syncServiceProvider));
});

class SyncStatus {
  final bool isOnline;
  final bool isSyncing;
  final int pendingOperations;
  final DateTime? lastSync;

  SyncStatus({
    this.isOnline = false,
    this.isSyncing = false,
    this.pendingOperations = 0,
    this.lastSync,
  });

  SyncStatus copyWith({
    bool? isOnline,
    bool? isSyncing,
    int? pendingOperations,
    DateTime? lastSync,
  }) {
    return SyncStatus(
      isOnline: isOnline ?? this.isOnline,
      isSyncing: isSyncing ?? this.isSyncing,
      pendingOperations: pendingOperations ?? this.pendingOperations,
      lastSync: lastSync ?? this.lastSync,
    );
  }
}

class SyncNotifier extends StateNotifier<SyncStatus> {
  final SupabaseSyncService _sync;
  
  SyncNotifier(this._sync) : super(SyncStatus()) {
    _initialize();
  }

  void _initialize() {
    // Check initial connection
    _checkConnection();
    
    // Listen to ghost trails if in competition
    _sync.ghostTrails.listen((trail) {
      // Update game UI with ghost positions
      // This would be piped to the game provider
    });
  }

  Future<void> _checkConnection() async {
    // Implementation to check and update isOnline status
  }

  Future<void> manualSync() async {
    state = state.copyWith(isSyncing: true);
    await _sync.sync();
    state = state.copyWith(
      isSyncing: false,
      lastSync: DateTime.now(),
      pendingOperations: 0,
    );
  }

  void updatePosition(String sceneId, double x, double y) {
    _sync.updatePosition(sceneId, x, y);
  }
}
