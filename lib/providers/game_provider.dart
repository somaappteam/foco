import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import '../models/scene_model.dart';
import '../models/word_model.dart';
import '../models/subscription_tier.dart';
import '../services/storage_service.dart';
import 'subscription_provider.dart';
import 'user_provider.dart';
import '../models/user_progress_model.dart';
import '../services/notification_service.dart';
import 'sync_provider.dart';

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier(
    ref.watch(storageServiceProvider),
    ref,
    ref.watch(subscriptionProvider).currentTier,
  );
});

class GameState {
  final Scene? currentScene;
  final Offset? flashlightPosition; // Normalized 0.0-1.0
  final Set<String> foundWordIds;
  final Word? currentlyIlluminating;
  final double illuminationProgress; // 0.0 to 1.0
  final bool isSceneComplete;
  final double batteryLevel; // Current battery
  final bool isBatteryCritical;
  final bool isBatteryDead;
  final DateTime? sessionStart;
  final bool showPremiumGate; // When hitting free limits

  GameState({
    this.currentScene,
    this.flashlightPosition,
    this.foundWordIds = const {},
    this.currentlyIlluminating,
    this.illuminationProgress = 0.0,
    this.isSceneComplete = false,
    this.batteryLevel = 100.0,
    this.isBatteryCritical = false,
    this.isBatteryDead = false,
    this.sessionStart,
    this.showPremiumGate = false,
  });

  GameState copyWith({
    Scene? currentScene,
    Offset? flashlightPosition,
    Set<String>? foundWordIds,
    Word? currentlyIlluminating,
    double? illuminationProgress,
    bool? isSceneComplete,
    double? batteryLevel,
    bool? isBatteryCritical,
    bool? isBatteryDead,
    DateTime? sessionStart,
    bool? showPremiumGate,
  }) {
    return GameState(
      currentScene: currentScene ?? this.currentScene,
      flashlightPosition: flashlightPosition ?? this.flashlightPosition,
      foundWordIds: foundWordIds ?? this.foundWordIds,
      currentlyIlluminating: currentlyIlluminating ?? this.currentlyIlluminating,
      illuminationProgress: illuminationProgress ?? this.illuminationProgress,
      isSceneComplete: isSceneComplete ?? this.isSceneComplete,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      isBatteryCritical: isBatteryCritical ?? this.isBatteryCritical,
      isBatteryDead: isBatteryDead ?? this.isBatteryDead,
      sessionStart: sessionStart ?? this.sessionStart,
      showPremiumGate: showPremiumGate ?? this.showPremiumGate,
    );
  }
}

class GameNotifier extends StateNotifier<GameState> {
  final StorageService _storage;
  final Ref _ref;
  final SubscriptionTier _tier;
  Timer? _batteryDrainTimer;
  Timer? _illuminationTimer;
  Timer? _ambientPulseTimer;
  
  // Configuration based on subscription
  double get _maxBattery => _tier.maxBattery.toDouble();
  double get _drainRate => _tier.tierId == 'scout' ? 0.8 : 0.3; // Free drains faster!
  double get _beamRadius => _tier.beamRadius;

  GameNotifier(this._storage, this._ref, this._tier) 
      : super(GameState(batteryLevel: _tier.maxBattery.toDouble())) {
    _startBatterySystem();
  }

  Future<void> loadScene(String sceneId) async {
    final scene = _storage.getScene(sceneId);
    if (scene == null) return;
    
    // Filter words based on subscription
    final visibleWords = _tier.tierId == 'scout' 
      ? scene.words.take(3).toList() // Free users only see 3 words
      : scene.words;

    final filteredScene = scene.copyWith(words: visibleWords);
    
    state = state.copyWith(
      currentScene: filteredScene,
      foundWordIds: {},
      isSceneComplete: false,
      batteryLevel: _maxBattery, // Fresh battery per scene
      sessionStart: DateTime.now(),
      showPremiumGate: false,
    );
    
    _startAmbientHaptics();
  }

  void updateFlashlightPosition(Offset normalizedPosition, Size screenSize) {
    if (state.isBatteryDead) return;
    
    state = state.copyWith(flashlightPosition: normalizedPosition);
    _checkWordProximity(screenSize);
  }

  void _checkWordProximity(Size screenSize) {
    if (state.currentScene == null || state.flashlightPosition == null) return;

    Word? targetWord;
    double closestDistance = double.infinity;

    for (final word in state.currentScene!.words) {
      if (state.foundWordIds.contains(word.id)) continue;

      final wordPos = Offset(word.positionX, word.positionY);
      final distance = (state.flashlightPosition! - wordPos).distance;
      
      // Convert normalized distance to pixels roughly
      final pixelDistance = distance * screenSize.shortestSide;

      if (pixelDistance < _beamRadius && pixelDistance < closestDistance) {
        closestDistance = pixelDistance;
        targetWord = word;
      }
    }

    if (targetWord != null && targetWord.id != state.currentlyIlluminating?.id) {
      _startIllumination(targetWord);
    } else if (targetWord == null && state.currentlyIlluminating != null) {
      _cancelIllumination();
    }
  }

  void _startIllumination(Word word) {
    _illuminationTimer?.cancel();
    
    // Haptic "discovery" pulse
    Haptics.vibrate(HapticsType.light);
    
    state = state.copyWith(
      currentlyIlluminating: word,
      illuminationProgress: 0.0,
    );

    // Illumination takes 2 seconds (standard) or 1.5s (premium - faster discovery)
    final duration = _tier.tierId == 'illuminator' ? 1500 : 2000;
    
    _illuminationTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      final newProgress = state.illuminationProgress + (50 / duration);
      
      if (newProgress >= 1.0) {
        _completeDiscovery(word);
        timer.cancel();
      } else {
        // Increasing haptic intensity as we get closer
        if ((newProgress * 10).floor() > (state.illuminationProgress * 10).floor()) {
          Haptics.vibrate(HapticsType.selection);
        }
        state = state.copyWith(illuminationProgress: newProgress);
      }
    });
  }

  void _cancelIllumination() {
    _illuminationTimer?.cancel();
    state = state.copyWith(
      currentlyIlluminating: null,
      illuminationProgress: 0.0,
    );
  }

  Future<void> _completeDiscovery(Word word) async {
    // Heavy haptic reward
    Haptics.vibrate(HapticsType.heavy);
    await Future.delayed(const Duration(milliseconds: 100));
    Haptics.vibrate(HapticsType.success);

    final updatedWord = word.copyWith(
      isDiscovered: true,
      discoveredAt: DateTime.now(),
    );

    final newFoundIds = {...state.foundWordIds, word.id};
    
    // Save to storage
    await _storage.saveDiscoveredWord(updatedWord);

    state = state.copyWith(
      foundWordIds: newFoundIds,
      currentlyIlluminating: null,
      illuminationProgress: 0.0,
    );

    // Check if scene complete
    if (newFoundIds.length >= state.currentScene!.words.length) {
      await _completeScene();
    } else {
      // Schedule decay warning (7 days from now, warning at 6.5 days)
      final fadeDate = DateTime.now().add(const Duration(days: 7));
      NotificationService().scheduleDecayWarning(word.id, word.text, fadeDate);
    }
  }

  Future<void> _completeScene() async {
    Haptics.vibrate(HapticsType.success);
    await Future.delayed(const Duration(milliseconds: 500));
    
    await _storage.completeScene(state.currentScene!.id);
    state = state.copyWith(isSceneComplete: true);
    
    // Trigger sync immediately on completion
    _ref.read(syncStatusProvider.notifier).manualSync();
  }

  void _startBatterySystem() {
    _batteryDrainTimer?.cancel();
    
    // Drain battery every second
    _batteryDrainTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.currentlyIlluminating != null) {
        // Drain faster when illuminating (using the light intensely)
        final newLevel = state.batteryLevel - (_drainRate * 1.5);
        _updateBattery(newLevel);
      } else {
        // Idle drain
        final newLevel = state.batteryLevel - _drainRate;
        _updateBattery(newLevel);
      }
    });
  }

  void _updateBattery(double newLevel) {
    final clamped = newLevel.clamp(0.0, _maxBattery);
    final isCritical = clamped < (_maxBattery * 0.2);
    final isDead = clamped <= 0;

    state = state.copyWith(
      batteryLevel: clamped,
      isBatteryCritical: isCritical,
      isBatteryDead: isDead,
    );

    if (isDead) {
      _batteryDrainTimer?.cancel();
      _illuminationTimer?.cancel();
      // Show premium gate if free user
      if (_tier.tierId == 'scout') {
        state = state.copyWith(showPremiumGate: true);
      }
    }
  }

  void _startAmbientHaptics() {
    // Subtle heartbeat when near undiscovered words
    _ambientPulseTimer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (state.currentlyIlluminating != null && state.illuminationProgress > 0.3) {
        // Don't vibrate, handled in illumination timer
      }
    });
  }

  Future<void> rechargeBattery() async {
    // Called when user watches ad or reviews words
    state = state.copyWith(batteryLevel: _maxBattery * 0.3); // 30% recharge
    _startBatterySystem();
  }

  void dismissPremiumGate() {
    state = state.copyWith(showPremiumGate: false);
  }

  void pauseGame() {
    _batteryDrainTimer?.cancel();
    _illuminationTimer?.cancel();
    _ambientPulseTimer?.cancel();
  }

  void resumeGame() {
    if (!state.isBatteryDead) {
      _startBatterySystem();
      _startAmbientHaptics();
    }
  }

  Future<void> checkDecayedWords() async {
    final fading = _storage.getFadingWords(_tier.tierId); // Simplified lang check
    final dead = _storage.getDeadWords(_tier.tierId);
    
    if (fading.isNotEmpty || dead.isNotEmpty) {
      debugPrint('Found ${fading.length} fading and ${dead.length} dead words.');
      // In a real app, we might trigger a UI alert or update state
    }
  }

  Future<void> emergencySave() async {
    // Save current state immediately
    if (state.currentScene != null) {
      final progress = _ref.read(userProgressProvider).asData?.value;
      await _storage.updateProgress(progress?.copyWith(
        currentBattery: state.batteryLevel,
        lastSessionDate: DateTime.now(),
      ) ?? UserProgress(
        userId: 'temp',
        sourceLanguageCode: 'en',
        targetLanguageCode: 'en',
        currentBattery: state.batteryLevel,
        lastSessionDate: DateTime.now(),
      ));
    }
  }

  @override
  void dispose() {
    _batteryDrainTimer?.cancel();
    _illuminationTimer?.cancel();
    _ambientPulseTimer?.cancel();
    super.dispose();
  }
}
