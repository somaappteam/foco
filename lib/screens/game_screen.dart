import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/game_provider.dart';
import '../providers/subscription_provider.dart';
import '../widgets/flashlight_painter.dart';
import '../widgets/burn_in_widget.dart';
import '../core/theme.dart';
import '../models/subscription_tier.dart';
import '../providers/user_provider.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> with TickerProviderStateMixin {
  Size _screenSize = Size.zero;
  late AnimationController _batteryPulseController;

  @override
  void initState() {
    super.initState();
    _batteryPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    
    // Load first scene
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameProvider.notifier).loadScene('market_001');
    });
  }

  @override
  void dispose() {
    _batteryPulseController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final normalized = Offset(
      details.localPosition.dx / _screenSize.width,
      details.localPosition.dy / _screenSize.height,
    );
    
    ref.read(gameProvider.notifier).updateFlashlightPosition(normalized, _screenSize);
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider);
    final subState = ref.watch(subscriptionProvider);
    final scene = gameState.currentScene;

    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      body: LayoutBuilder(
        builder: (context, constraints) {
          _screenSize = Size(constraints.maxWidth, constraints.maxHeight);
          
          return GestureDetector(
            onPanUpdate: _onPanUpdate,
            onTapDown: (details) => _onPanUpdate(DragUpdateDetails(
              localPosition: details.localPosition,
              globalPosition: details.globalPosition,
            )),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Base Scene Image (Heavily Dimmed)
                if (scene != null)
                  Opacity(
                    opacity: 0.15 + (gameState.batteryLevel / 1000), // Almost invisible
                    child: Image.asset(
                      scene.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: AppTheme.voidBlack),
                    ),
                  ),

                // Flashlight Layer
                CustomPaint(
                  size: Size.infinite,
                  painter: RealisticFlashlightPainter(
                    position: gameState.flashlightPosition != null
                      ? Offset(
                          gameState.flashlightPosition!.dx * _screenSize.width,
                          gameState.flashlightPosition!.dy * _screenSize.height,
                        )
                      : null,
                    radius: subState.currentTier.beamRadius,
                    intensity: gameState.batteryLevel / subState.currentTier.maxBattery,
                    isFlickering: gameState.isBatteryCritical,
                  ),
                ),

                // Revealed Words (Only show if found)
                if (scene != null)
                  ...scene.words.where((w) => gameState.foundWordIds.contains(w.id)).map((word) {
                    return Positioned(
                      left: word.positionX * _screenSize.width - 50,
                      top: word.positionY * _screenSize.height - 25,
                      child: _DiscoveredWordCard(word: word),
                    );
                  }),

                // Active Illumination (The 2-second hold)
                if (gameState.currentlyIlluminating != null && gameState.flashlightPosition != null)
                  Positioned(
                    left: (gameState.currentlyIlluminating!.positionX * _screenSize.width) - 50,
                    top: (gameState.currentlyIlluminating!.positionY * _screenSize.height) - 50,
                    child: IlluminationProgress(
                      progress: gameState.illuminationProgress,
                      word: gameState.currentlyIlluminating!.text,
                      category: gameState.currentlyIlluminating!.category,
                      isPremiumWord: gameState.currentlyIlluminating!.isPremiumOnly,
                    ),
                  ),

                // HUD Layer
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Top Bar: Battery & Progress
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Battery
                            _BatteryIndicator(
                              level: gameState.batteryLevel,
                              maxLevel: subState.currentTier.maxBattery.toDouble(),
                              isCritical: gameState.isBatteryCritical,
                              tier: subState.currentTier,
                              pulseController: _batteryPulseController,
                            ),
                            
                            // Language Pair HUD
                            _LanguagePairHUD(),

                            // Progress
                            _ProgressChip(
                              found: gameState.foundWordIds.length,
                              total: scene?.words.length ?? 0,
                            ),
                          ],
                        ),
                        
                        const Spacer(),
                        
                        // Bottom: Context hint (only if premium or found words)
                        if (subState.currentTier.tierId == 'illuminator' || gameState.foundWordIds.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: Text(
                              scene?.description ?? 'Explore the darkness...',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // Premium Gate (When Free User Hits Limit)
                if (gameState.showPremiumGate)
                  _PremiumGateOverlay(onClose: () {
                    ref.read(gameProvider.notifier).dismissPremiumGate();
                  }),

                // Scene Completion Celebration
                if (gameState.isSceneComplete)
                  _SceneCompleteOverlay(sceneTitle: scene?.title ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LanguagePairHUD extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(userProgressProvider);
    return progress.when(
      data: (p) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
             Text(p.sourceLanguageCode.split('-')[0].toUpperCase(), style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
             const Icon(Icons.compare_arrows_rounded, color: Colors.white24, size: 12),
             Text(p.targetLanguageCode.split('-')[0].toUpperCase(), style: const TextStyle(color: AppTheme.flashlightCore, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _ProgressChip extends StatelessWidget {
  final int found;
  final int total;

  const _ProgressChip({required this.found, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$found/$total',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _BatteryIndicator extends StatelessWidget {
  final double level;
  final double maxLevel;
  final bool isCritical;
  final SubscriptionTier tier;
  final AnimationController pulseController;

  const _BatteryIndicator({
    required this.level,
    required this.maxLevel,
    required this.isCritical,
    required this.tier,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (level / maxLevel).clamp(0.0, 1.0);
    Color color;
    if (percentage > 0.5) {
      color = AppTheme.batteryFull;
    } else if (percentage > 0.2) {
      color = AppTheme.batteryMedium;
    } else {
      color = AppTheme.batteryCritical;
    }

    return GestureDetector(
      onTap: () {
        // Show equipment details
        context.push('/equipment');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isCritical ? color.withValues(alpha: 0.5 + (0.5 * pulseController.value)) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isCritical ? Icons.battery_alert : Icons.battery_full,
              color: color,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              '${(percentage * 100).toInt()}%',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            if (tier.tierId == 'illuminator') ...[
              const SizedBox(width: 4),
              const Icon(Icons.bolt, color: AppTheme.foodGold, size: 14),
            ],
          ],
        ),
      ),
    );
  }
}

class _DiscoveredWordCard extends StatelessWidget {
  final dynamic word;

  const _DiscoveredWordCard({required this.word});

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor(word.category);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withValues(alpha: 0.9),
            Colors.black.withValues(alpha: 0.6),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            word.text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              shadows: [
                Shadow(color: color, blurRadius: 8),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            word.translation,
            style: TextStyle(
              color: color.withValues(alpha: 0.9),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack);
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'survival': return AppTheme.survivalRed;
      case 'food': return AppTheme.foodGold;
      case 'people': return AppTheme.peopleAmber;
      case 'nature': return AppTheme.natureEmerald;
      case 'abstract': return AppTheme.abstractViolet;
      default: return AppTheme.flashlightCore;
    }
  }
}

class _PremiumGateOverlay extends StatelessWidget {
  final VoidCallback onClose;

  const _PremiumGateOverlay({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.95),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.battery_alert,
                color: AppTheme.batteryCritical,
                size: 64,
              ),
              const SizedBox(height: 24),
              Text(
                'FLASHLIGHT DEPLETED',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Field Scout batteries drain quickly in the dark.\nUpgrade to Master Illuminator for unlimited exploration.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white60),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  onClose();
                  context.push('/equipment');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.foodGold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text(
                  'UPGRADE EQUIPMENT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: onClose,
                child: const Text('Return to Base', style: TextStyle(color: Colors.white38)),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}

class _SceneCompleteOverlay extends StatelessWidget {
  final String sceneTitle;

  const _SceneCompleteOverlay({required this.sceneTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lightbulb,
              color: AppTheme.flashlightHalo,
              size: 80,
            ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
            const SizedBox(height: 32),
            Text(
              'FULLY ILLUMINATED',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 12),
            Text(
              sceneTitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                // Next scene or return to map
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text('CONTINUE EXPLORATION'),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 1000.ms);
  }
}
