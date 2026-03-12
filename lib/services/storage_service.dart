import 'package:hive/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scene_model.dart';
import '../models/word_model.dart';
import '../models/user_progress_model.dart';

final storageServiceProvider = Provider<StorageService>((ref) => StorageService());

class StorageService {
  Box<Scene> get _scenesBox => Hive.box<Scene>('scenes');
  Box<Word> get _wordsBox => Hive.box<Word>('discovered_words');
  Box<UserProgress> get _progressBox => Hive.box<UserProgress>('user_progress');
  Box<IlluminationRecord> get _illuminationsBox => Hive.box<IlluminationRecord>('illuminations');

  // Scene Management
  Future<void> cacheScenes(List<Scene> scenes) async {
    await _scenesBox.clear();
    final map = {for (var s in scenes) s.id: s};
    await _scenesBox.putAll(map);
  }

  List<Scene> getAvailableScenes(String targetLangCode, String tierId) {
    final all = _scenesBox.values.where((s) => s.languageCode == targetLangCode).toList();
    
    if (tierId == 'scout') {
      // Free users: Only non-premium scenes, limited to first 10
      return all.where((s) => !s.isPremium).take(10).toList();
    }
    return all; // Premium: All scenes
  }

  Scene? getScene(String id) => _scenesBox.get(id);

  Future<void> completeScene(String sceneId) async {
    final scene = _scenesBox.get(sceneId);
    if (scene != null) {
      await _scenesBox.put(sceneId, scene.copyWith(
        isCompleted: true, 
        completedAt: DateTime.now(),
      ));
    }
  }

  // Word & Decay System
  Future<void> saveDiscoveredWord(Word word) async {
    await _wordsBox.put(word.id, word);
  }

  Word? getWord(String id) => _wordsBox.get(id);

  List<Word> getAllDiscoveredWords() => _wordsBox.values.toList();
  
  List<IlluminationRecord> getAllIlluminationRecords() => _illuminationsBox.values.toList();

  List<Word> getFadingWords(String targetLangCode) {
    final now = DateTime.now();
    return _wordsBox.values.where((w) {
      if (w.languageCode != targetLangCode) return false;
      if (w.discoveredAt == null) return false;
      final daysOld = now.difference(w.discoveredAt!).inDays;
      return daysOld >= 3 && daysOld < 7; // Fading but not dead
    }).toList();
  }

  List<Word> getDeadWords(String targetLangCode) {
    final now = DateTime.now();
    return _wordsBox.values.where((w) {
      if (w.languageCode != targetLangCode) return false;
      if (w.discoveredAt == null) return false;
      return now.difference(w.discoveredAt!).inDays >= 7; // Permadeath
    }).toList();
  }

  // Progress
  Future<UserProgress> getProgress(String userId) async {
    return _progressBox.get(userId) ?? UserProgress(userId: userId);
  }

  Future<void> updateProgress(UserProgress progress) async {
    await _progressBox.put(progress.userId, progress);
  }
}
