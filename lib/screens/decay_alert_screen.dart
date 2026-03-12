import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/theme.dart';
import '../providers/game_provider.dart';
import '../providers/subscription_provider.dart';
import '../services/storage_service.dart';

class DecayAlertScreen extends ConsumerStatefulWidget {
  const DecayAlertScreen({super.key});

  @override
  ConsumerState<DecayAlertScreen> createState() => _DecayAlertScreenState();
}

class _DecayAlertScreenState extends ConsumerState<DecayAlertScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  List<dynamic> _fadingWords = [];
  bool _isRecharging = false;
  int _selectedCount = 0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    _loadFadingWords();
    
    // Urgent haptic pattern on entry
    _urgentHaptic();
  }

  Future<void> _urgentHaptic() async {
    for (int i = 0; i < 3; i++) {
      HapticFeedback.heavyImpact();
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  void _loadFadingWords() {
    final storage = ref.read(storageServiceProvider);
    // Get current language from user progress
    const lang = 'en'; // Replace with actual current language
    setState(() {
      _fadingWords = storage.getFadingWords(lang);
    });
  }

  Future<void> _reviewWord(dynamic word) async {
    HapticFeedback.lightImpact();
    
    setState(() => _isRecharging = true);
    
    // Simulate review mini-game
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Restore word illumination
    final storage = ref.read(storageServiceProvider);
    final updatedWord = word.copyWith(
      discoveredAt: DateTime.now(), // Reset the clock
      illuminationStrength: 100,
    );
    await storage.saveDiscoveredWord(updatedWord);
    
    setState(() {
      _selectedCount++;
      _isRecharging = false;
    });
    
    // Check if we've reviewed enough to recharge
    if (_selectedCount >= 3) {
      _completeRecharge();
    } else {
      _loadFadingWords(); // Refresh list
    }
  }

  Future<void> _completeRecharge() async {
    // Recharge battery
    ref.read(gameProvider.notifier).rechargeBattery();
    
    // Success haptic
    HapticFeedback.vibrate();
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (mounted) {
      context.pop(); // Return to game
    }
  }

  void _upgradeToInfinite() {
    HapticFeedback.mediumImpact();
    context.push('/equipment');
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subState = ref.watch(subscriptionProvider);
    final isPremium = subState.currentTier.tierId == 'illuminator';
    
    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Red emergency glow at edges (battery critical aesthetic)
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      AppTheme.batteryCritical.withValues(
                        alpha: 0.1 * _pulseAnimation.value,
                      ),
                    ],
                    stops: const [0.0, 0.7, 1.0],
                  ),
                ),
              );
            },
          ),
          
          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: Critical Warning
                  Row(
                    children: [
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          return Icon(
                            Icons.warning_rounded,
                            color: AppTheme.batteryCritical.withValues(
                              alpha: 0.5 + (0.5 * _pulseAnimation.value),
                            ),
                            size: 32,
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FLASHLIGHT DEPLETED',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppTheme.batteryCritical,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'The darkness is reclaiming your memories...',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Stats
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.batteryCritical.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.batteryCritical.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const _StatColumn(
                          label: 'BATTERY',
                          value: '0%',
                          color: AppTheme.batteryCritical,
                        ),
                        Container(width: 1, height: 40, color: Colors.white10),
                        _StatColumn(
                          label: 'FADING',
                          value: '${_fadingWords.length}',
                          color: Colors.orange,
                        ),
                        Container(width: 1, height: 40, color: Colors.white10),
                        _StatColumn(
                          label: 'LOST',
                          value: '${ref.read(storageServiceProvider).getDeadWords('en').length}',
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Rescue Options
                  if (!isPremium) ...[
                    Text(
                      'RECHARGE OPTIONS',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white38,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Option 1: Rescue Memories (Free)
                    _RescueOptionCard(
                      title: 'Rescue Fading Memories',
                      subtitle: 'Review 3 words to generate 30% power',
                      icon: Icons.restore,
                      color: AppTheme.foodGold,
                      onTap: _fadingWords.isEmpty ? null : () => _showRescueSheet(),
                      isAvailable: _fadingWords.isNotEmpty,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Option 2: Upgrade (Premium)
                    _RescueOptionCard(
                      title: 'Install Infinite Battery',
                      subtitle: 'Master Illuminator Protocol • Never drain again',
                      icon: Icons.bolt,
                      color: AppTheme.batteryFull,
                      onTap: _upgradeToInfinite,
                      isPremium: true,
                      isAvailable: true,
                    ),
                  ] else ...[
                    // Premium user view - just show status
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppTheme.batteryFull.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.batteryFull),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppTheme.batteryFull,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'INFINITE BATTERY PROTOCOL ACTIVE',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.batteryFull,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your flashlight cannot die. Return to exploration.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white60,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => context.pop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.batteryFull,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32, 
                                vertical: 16,
                              ),
                            ),
                            child: const Text('RESUME EXPLORATION'),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  const Spacer(),
                  
                  // Bottom: Lost words cemetery (visual only)
                  if (ref.read(storageServiceProvider).getDeadWords('en').isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.broken_image,
                            color: Colors.white.withValues(alpha: 0.3),
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${ref.read(storageServiceProvider).getDeadWords('en').length} memories lost to darkness forever',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.4),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // Recharging overlay (when reviewing)
          if (_isRecharging)
            Container(
              color: Colors.black.withValues(alpha: 0.9),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: AppTheme.foodGold,
                      strokeWidth: 3,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Re-illuminating memory...',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showRescueSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.shadowGray,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'SELECT MEMORIES TO RESCUE',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white54,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Review $_selectedCount/3 to recharge',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.foodGold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: _fadingWords.length,
                      itemBuilder: (context, index) {
                        final word = _fadingWords[index];
                        return _RescueListTile(
                          word: word,
                          onRescue: () => _reviewWord(word),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatColumn({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 10,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _RescueOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final bool isPremium;
  final bool isAvailable;

  const _RescueOptionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
    this.isPremium = false,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isAvailable 
            ? color.withValues(alpha: 0.1) 
            : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isAvailable 
              ? color.withValues(alpha: 0.5) 
              : Colors.white10,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isAvailable 
                  ? color.withValues(alpha: 0.2) 
                  : Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isAvailable ? color : Colors.white30,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: isAvailable ? Colors.white : Colors.white38,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (isPremium) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8, 
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'PREMIUM',
                            style: TextStyle(
                              color: color,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: isAvailable 
                        ? Colors.white.withValues(alpha: 0.6) 
                        : Colors.white24,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isAvailable ? color : Colors.white10,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class _RescueListTile extends StatelessWidget {
  final dynamic word;
  final VoidCallback onRescue;

  const _RescueListTile({
    required this.word,
    required this.onRescue,
  });

  @override
  Widget build(BuildContext context) {
    final daysLeft = 7 - DateTime.now().difference(word.discoveredAt).inDays;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          // Fading word preview
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _getCategoryColor(word.category).withValues(alpha: 0.3),
              ),
            ),
            child: Center(
              child: Text(
                word.text,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  word.translation,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fades in $daysLeft days',
                  style: TextStyle(
                    color: daysLeft < 3 
                      ? AppTheme.batteryCritical 
                      : Colors.orange,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onRescue,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.foodGold,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text(
              'RESCUE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'survival': return AppTheme.survivalRed;
      case 'food': return AppTheme.foodGold;
      case 'people': return AppTheme.peopleAmber;
      case 'nature': return AppTheme.natureEmerald;
      default: return AppTheme.flashlightCore;
    }
  }
}
