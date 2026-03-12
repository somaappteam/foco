import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/subscription_provider.dart';
import '../providers/auth_provider.dart';
import '../services/auth_service.dart';
import '../core/theme.dart';
import 'auth_screen.dart';

class EquipmentScreen extends ConsumerWidget {
  const EquipmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subState = ref.watch(subscriptionProvider);
    final authState = ref.watch(authStateProvider);
    final isAuthenticated = authState == AuthState.authenticated;

    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flashlight_on,
                        color: subState.currentTier.tierId == 'illuminator' 
                          ? AppTheme.foodGold 
                          : Colors.white30,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'FIELD EQUIPMENT',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          letterSpacing: 4,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Show auth status prominently if guest
                  if (!isAuthenticated) ...[
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.account_circle_outlined, 
                               color: Colors.white54, size: 48),
                          const SizedBox(height: 16),
                          Text(
                            'Guest Mode Active',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Create an account to upgrade your flashlight '
                            'and preserve your discoveries forever.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white60),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => _showAuthGate(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.foodGold,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            ),
                            child: const Text('ENABLE UPGRADES'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Current Loadout
                  _EquipmentCard(
                    title: 'CURRENT: ${subState.currentTier.name.toUpperCase()}',
                    specs: [
                      'Battery Capacity: ${subState.currentTier.maxBattery}%',
                      'Daily Missions: ${subState.currentTier.dailyScenes == 999 ? "Unlimited" : subState.currentTier.dailyScenes}',
                      'Discovery Range: ${subState.currentTier.beamRadius.toInt()}px',
                      'Word Capacity: ${subState.currentTier.wordsPerScene} per scene',
                      if (subState.currentTier.cloudSync) 'Cloud Backup: Enabled',
                      if (subState.currentTier.exclusiveScenes) 'Legendary Access: Granted',
                    ],
                    isActive: true,
                    color: isAuthenticated 
                      ? (subState.currentTier.tierId == 'illuminator' 
                         ? AppTheme.foodGold 
                         : Colors.white30)
                      : Colors.white24,
                    isDisabled: !isAuthenticated && subState.currentTier.tierId == 'illuminator',
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Upgrade Option (if not premium)
                  if (subState.currentTier.tierId == 'scout') ...[
                    Text(
                      'AVAILABLE UPGRADE',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.foodGold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _EquipmentCard(
                      title: 'MASTER ILLUMINATOR',
                      specs: [
                        'Extended Battery (200%)',
                        'Unlimited Daily Access',
                        'Wide Beam (150px radius)',
                        'Full Scene Completion (5+ words)',
                        'Legendary Dark Rooms',
                        'Cloud Memory Preservation',
                        if (!isAuthenticated) '⚠️ Requires Account Creation',
                      ],
                      isActive: false,
                      color: isAuthenticated ? AppTheme.foodGold : Colors.white30,
                      isDisabled: !isAuthenticated,
                      button: !isAuthenticated
                        ? OutlinedButton(
                            onPressed: () => _showAuthGate(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.foodGold,
                              side: const BorderSide(color: AppTheme.foodGold),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('CREATE ACCOUNT TO UPGRADE'),
                          )
                        : subState.isLoading
                          ? const CircularProgressIndicator(color: AppTheme.foodGold)
                          : ElevatedButton(
                              onPressed: () => ref.read(subscriptionProvider.notifier)
                                  .purchasePremium(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.foodGold,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text('UPGRADE - \$4.99/MO'),
                            ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Equipment upgrades help you explore deeper into the darkness and preserve your discoveries forever.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white38,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ] else ...[
                    // Already premium - show status
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppTheme.foodGold.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.foodGold.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.check_circle, color: AppTheme.foodGold, size: 48),
                          const SizedBox(height: 16),
                          Text(
                            'Your flashlight never dies. Explore freely.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  
                  const SizedBox(height: 40),
                  
                  // Restoration
                  if (!subState.isLoading)
                    TextButton.icon(
                      onPressed: () => ref.read(subscriptionProvider.notifier).restorePurchases(),
                      icon: const Icon(Icons.restore, color: Colors.white38),
                      label: const Text(
                        'RESTORE PURCHASES',
                        style: TextStyle(color: Colors.white38),
                      ),
                    ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAuthGate(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: AppTheme.pureBlack,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: const AuthGateScreen(),
      ),
    );
  }
}

class _EquipmentCard extends StatelessWidget {
  final String title;
  final List<String> specs;
  final bool isActive;
  final Color color;
  final Widget? button;
  final bool isDisabled;

  const _EquipmentCard({
    required this.title,
    required this.specs,
    required this.isActive,
    required this.color,
    this.button,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDisabled 
          ? Colors.white.withValues(alpha: 0.03)
          : color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDisabled ? Colors.white10 : color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isDisabled ? Colors.white38 : color,
            ),
          ),
          const SizedBox(height: 16),
          ...specs.map((spec) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: isDisabled ? Colors.white10 : color.withValues(alpha: 0.7),
                  size: 16,
                ),
                const SizedBox(width: 12),
                Text(
                  spec,
                  style: TextStyle(
                    color: isDisabled ? Colors.white24 : Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          )),
          if (button != null) ...[
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: button!),
          ],
        ],
      ),
    );
  }
}

