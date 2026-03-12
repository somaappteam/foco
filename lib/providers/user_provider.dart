import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_progress_model.dart';
import '../services/storage_service.dart';

import '../services/auth_service.dart';
import 'auth_provider.dart';

final userProgressProvider = StateNotifierProvider<UserProgressNotifier, AsyncValue<UserProgress>>((ref) {
  final auth = ref.watch(authServiceProvider);
  return UserProgressNotifier(ref.watch(storageServiceProvider), auth);
});

class UserProgressNotifier extends StateNotifier<AsyncValue<UserProgress>> {
  final StorageService _storage;
  final AuthService _auth;

  UserProgressNotifier(this._storage, this._auth) : super(const AsyncValue.loading()) {
    _loadProgress();
    _auth.addListener(_loadProgress); // Reload if user changes (migration)
  }

  Future<void> _loadProgress() async {
    try {
      final progress = await _storage.getProgress(_auth.effectiveUserId);
      state = AsyncValue.data(progress);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateLanguagePair(String sourceCode, String targetCode) async {
    if (state.asData == null) return;
    
    final updated = state.asData!.value.copyWith(
      sourceLanguageCode: sourceCode,
      targetLanguageCode: targetCode,
    );
    
    await _storage.updateProgress(updated);
    state = AsyncValue.data(updated);
  }

  Future<void> updateBattery(double level) async {
    if (state.asData == null) return;
    final updated = state.asData!.value.copyWith(currentBattery: level);
    await _storage.updateProgress(updated);
    state = AsyncValue.data(updated);
  }
}
