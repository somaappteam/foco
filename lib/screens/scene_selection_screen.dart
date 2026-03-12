import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/theme.dart';
import '../providers/subscription_provider.dart';
import '../services/storage_service.dart';
import '../models/scene_model.dart';
import '../models/subscription_tier.dart';

class SceneSelectionScreen extends ConsumerStatefulWidget {
  const SceneSelectionScreen({super.key});

  @override
  ConsumerState<SceneSelectionScreen> createState() => _SceneSelectionScreenState();
}

class _SceneSelectionScreenState extends ConsumerState<SceneSelectionScreen> {
  String _selectedCategory = 'all';
  bool _showLockedOnly = false;

  @override
  Widget build(BuildContext context) {
    final subState = ref.watch(subscriptionProvider);
    final storage = ref.watch(storageServiceProvider);
    final scenes = storage.getAvailableScenes('en', subState.currentTier.tierId);

    final filteredScenes = scenes.where((scene) {
      if (_selectedCategory != 'all' && scene.category != _selectedCategory) return false;
      if (_showLockedOnly && !scene.isPremium) return false;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      body: CustomScrollView(
        slivers: [
          // App Bar with Battery Status
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 140,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'DARK ROOMS',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white38,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select your expedition',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _BatteryStatusChip(tier: subState.currentTier),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Filter Chips
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      isSelected: _selectedCategory == 'all',
                      onTap: () => setState(() => _selectedCategory = 'all'),
                    ),
                    _FilterChip(
                      label: 'Survival',
                      isSelected: _selectedCategory == 'survival',
                      color: AppTheme.survivalRed,
                      onTap: () => setState(() => _selectedCategory = 'survival'),
                    ),
                    _FilterChip(
                      label: 'Nature',
                      isSelected: _selectedCategory == 'nature',
                      color: AppTheme.natureEmerald,
                      onTap: () => setState(() => _selectedCategory = 'nature'),
                    ),
                    _FilterChip(
                      label: 'People',
                      isSelected: _selectedCategory == 'people',
                      color: AppTheme.peopleAmber,
                      onTap: () => setState(() => _selectedCategory = 'people'),
                    ),
                    if (subState.currentTier.tierId == 'illuminator')
                      _FilterChip(
                        label: 'Legendary',
                        isSelected: _showLockedOnly,
                        color: AppTheme.foodGold,
                        onTap: () => setState(() => _showLockedOnly = !_showLockedOnly),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Stats Summary
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(
                    value: '${scenes.where((s) => s.isCompleted).length}',
                    label: 'Explored',
                    color: AppTheme.batteryFull,
                  ),
                  _StatItem(
                    value: '${scenes.where((s) => !s.isCompleted).length}',
                    label: 'Uncharted',
                    color: AppTheme.flashlightYellow,
                  ),
                  _StatItem(
                    value: '${subState.currentTier.dailyScenes == 999 ? "∞" : subState.currentTier.dailyScenes}',
                    label: 'Today Left',
                    color: subState.currentTier.dailyScenes > 0 
                      ? AppTheme.flashlightCore 
                      : AppTheme.batteryCritical,
                  ),
                ],
              ),
            ),
          ),

          // Scene Grid
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= filteredScenes.length) return null;
                  return _SceneCard(
                    scene: filteredScenes[index],
                    tier: subState.currentTier,
                    onTap: () => _enterScene(filteredScenes[index]),
                  );
                },
                childCount: filteredScenes.length,
              ),
            ),
          ),

          // Bottom spacing
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }

  void _enterScene(Scene scene) {
    final subState = ref.read(subscriptionProvider);
    
    // Check daily limit for free users
    if (subState.currentTier.tierId == 'scout' && subState.currentTier.dailyScenes <= 0) {
      context.push('/recharge');
      return;
    }

    // Check premium access
    if (scene.isPremium && subState.currentTier.tierId != 'illuminator') {
      _showPremiumLock(scene);
      return;
    }

    HapticFeedback.mediumImpact();
    context.go('/game', extra: scene.id);
  }

  void _showPremiumLock(Scene scene) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.shadowGray,
        title: const Text(
          'LEGENDARY SECTOR',
          style: TextStyle(
            color: AppTheme.foodGold,
            fontSize: 18,
            letterSpacing: 2,
          ),
        ),
        content: const Text(
          'This area requires Master Illuminator equipment. Your current flashlight cannot penetrate this depth of darkness.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.push('/equipment');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.foodGold,
              foregroundColor: Colors.black,
            ),
            child: const Text('UPGRADE'),
          ),
        ],
      ),
    );
  }
}

class _SceneCard extends StatelessWidget {
  final Scene scene;
  final SubscriptionTier tier;
  final VoidCallback onTap;

  const _SceneCard({
    required this.scene,
    required this.tier,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLocked = scene.isPremium && tier.tierId != 'illuminator';
    final double progress = scene.discoveredCount / scene.totalWords;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppTheme.shadowGray,
          border: Border.all(
            color: isLocked 
              ? AppTheme.foodGold.withValues(alpha: 0.3) 
              : Colors.white10,
          ),
          boxShadow: scene.isCompleted
            ? [
                BoxShadow(
                  color: _getCategoryColor(scene.category).withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Thumbnail (heavily darkened if not completed)
              Image.asset(
                scene.thumbnailAsset,
                fit: BoxFit.cover,
                color: Colors.black.withValues(alpha: scene.isCompleted ? 0.3 : 0.7),
                colorBlendMode: BlendMode.darken,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.black,
                  child: const Center(child: Icon(Icons.image_not_supported, color: Colors.white24)),
                ),
              ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isLocked)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.foodGold.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock, color: AppTheme.foodGold, size: 12),
                            SizedBox(width: 4),
                            Text(
                              'PREMIUM',
                              style: TextStyle(
                                color: AppTheme.foodGold,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    else if (scene.isCompleted)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.batteryFull.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'EXPLORED',
                          style: TextStyle(
                            color: AppTheme.batteryFull,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      scene.title,
                      style: TextStyle(
                        color: isLocked ? Colors.white38 : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    Text(
                      '${scene.discoveredCount}/${scene.totalWords} secrets',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: isLocked ? 0.3 : 0.6),
                        fontSize: 12,
                      ),
                    ),

                    // Progress bar
                    if (!isLocked && !scene.isCompleted)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.white10,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getCategoryColor(scene.category),
                          ),
                          minHeight: 2,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color? color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
            ? (color ?? Colors.white).withValues(alpha: 0.2) 
            : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
              ? (color ?? Colors.white).withValues(alpha: 0.5) 
              : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected 
              ? (color ?? Colors.white) 
              : Colors.white54,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
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
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 11,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _BatteryStatusChip extends StatelessWidget {
  final SubscriptionTier tier;

  const _BatteryStatusChip({required this.tier});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: tier.tierId == 'illuminator' 
          ? AppTheme.foodGold.withValues(alpha: 0.2) 
          : Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: tier.tierId == 'illuminator' 
            ? AppTheme.foodGold.withValues(alpha: 0.5) 
            : Colors.white10,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            tier.tierId == 'illuminator' ? Icons.bolt : Icons.battery_std,
            color: tier.tierId == 'illuminator' ? AppTheme.foodGold : Colors.white70,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            tier.tierId == 'illuminator' ? '∞' : '${tier.dailyScenes}',
            style: TextStyle(
              color: tier.tierId == 'illuminator' ? AppTheme.foodGold : Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
