import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../services/audio_service.dart';

class LifecycleObserver extends WidgetsBindingObserver {
  final Ref _ref;
  DateTime? _pausedAt;

  LifecycleObserver(this._ref);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final gameNotifier = _ref.read(gameProvider.notifier);
    final audioService = AudioService();

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        // Pause battery drain and audio when app backgrounded
        gameNotifier.pauseGame();
        audioService.pauseAmbient();
        _pausedAt = DateTime.now();
        
        // Haptic feedback to indicate pause
        HapticFeedback.lightImpact();
        break;
        
      case AppLifecycleState.resumed:
        // Check if we were gone long enough for words to decay
        if (_pausedAt != null) {
          final awayDuration = DateTime.now().difference(_pausedAt!);
          
          // If away > 3 hours, show decay alert immediately
          if (awayDuration.inHours >= 3) {
            _ref.read(gameProvider.notifier).checkDecayedWords();
          }
        }
        
        gameNotifier.resumeGame();
        audioService.resumeAmbient();
        _pausedAt = null;
        break;
        
      case AppLifecycleState.detached:
        // App killed - save state
        gameNotifier.emergencySave();
        break;
        
      default:
        break;
    }
  }
}

final lifecycleObserverProvider = Provider<LifecycleObserver>((ref) {
  final observer = LifecycleObserver(ref);
  WidgetsBinding.instance.addObserver(observer);
  return observer;
});
