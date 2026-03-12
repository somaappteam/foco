import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_service.dart';

final imagePreloaderProvider = Provider<ImagePreloader>((ref) {
  return ImagePreloader(ref.watch(storageServiceProvider));
});

class ImagePreloader {
  final StorageService _storage;
  final Map<String, ImageProvider> _cache = {};

  ImagePreloader(this._storage);

  Future<void> preloadScenes(BuildContext context) async {
    final scenes = _storage.getAvailableScenes('en', 'scout');
    
    for (final scene in scenes.take(3)) { // Preload first 3 only (memory)
      if (scene.imageAsset.startsWith('assets/')) {
        final provider = AssetImage(scene.imageAsset);
        _cache[scene.id] = provider;
        
        // Precache
        await precacheImage(provider, context);
      }
    }
  }

  ImageProvider? getSceneImage(String sceneId) {
    return _cache[sceneId];
  }

  void clearCache() {
    _cache.clear();
  }
}
