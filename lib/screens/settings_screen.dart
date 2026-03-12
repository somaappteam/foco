import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import 'auth_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          children: [
            // Header
            Text(
              'EQUIPMENT SETTINGS',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white38,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 24),

            // Account Status
            _SettingsCard(
              child: AccountStatusTile(
                onAuthRequired: () => _showAuthSheet(context),
              ),
            ),

            const SizedBox(height: 32),

            // Audio & Haptics
            Text(
              'SENSORY',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white38,
              ),
            ),
            const SizedBox(height: 16),
            _SettingsCard(
              child: Column(
                children: [
                  _ToggleTile(
                    icon: Icons.volume_up,
                    title: 'Ambient Audio',
                    subtitle: 'Background atmosphere sounds',
                    value: true,
                    onChanged: (v) {},
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  _ToggleTile(
                    icon: Icons.vibration,
                    title: 'Haptic Feedback',
                    subtitle: 'Vibration patterns for discovery',
                    value: true,
                    onChanged: (v) {},
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  _ToggleTile(
                    icon: Icons.music_note,
                    title: 'Discovery Sounds',
                    subtitle: 'Audio cues when illuminating words',
                    value: true,
                    onChanged: (v) {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Display
            Text(
              'DISPLAY',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white38,
              ),
            ),
            const SizedBox(height: 16),
            _SettingsCard(
              child: Column(
                children: [
                  _ActionTile(
                    icon: Icons.brightness_2,
                    title: 'Flashlight Intensity',
                    subtitle: 'Adjust beam brightness',
                    trailing: const Text(
                      'Standard',
                      style: TextStyle(color: Colors.white54),
                    ),
                    onTap: () {},
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  _ToggleTile(
                    icon: Icons.battery_saver,
                    title: 'Battery Saver Mode',
                    subtitle: 'Reduce drain by 50%, dimmer beam',
                    value: false,
                    onChanged: (v) {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Data & Sync
            Text(
              'MEMORY ARCHIVE',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white38,
              ),
            ),
            const SizedBox(height: 16),
            _SettingsCard(
              child: Column(
                children: [
                  _ActionTile(
                    icon: Icons.cloud_upload,
                    title: 'Sync Progress',
                    subtitle: 'Last sync: Just now',
                    onTap: () {},
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  _ActionTile(
                    icon: Icons.delete_forever,
                    title: 'Clear Local Data',
                    subtitle: 'Reset all discoveries (dangerous)',
                    textColor: AppTheme.survivalRed,
                    onTap: () => _showClearDataDialog(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // About
            Center(
              child: Column(
                children: [
                  const Text(
                    'FOCO',
                    style: TextStyle(
                      color: Colors.white24,
                      fontSize: 24,
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Version 1.0.0 (Build 2024)',
                    style: TextStyle(
                      color: Colors.white12,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Privacy Policy • Terms of Service',
                      style: TextStyle(
                        color: Colors.white30,
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
    );
  }

  void _showAuthSheet(BuildContext context) {
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

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.shadowGray,
        title: const Text(
          'ERASE ALL MEMORY?',
          style: TextStyle(color: AppTheme.survivalRed),
        ),
        content: const Text(
          'This will permanently delete all illuminated words and scene progress. '
          'This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () {
              // Clear hive boxes
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.survivalRed,
              foregroundColor: Colors.white,
            ),
            child: const Text('ERASE'),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;

  const _SettingsCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.shadowGray,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: child,
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 12,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppTheme.flashlightYellow,
        activeTrackColor: AppTheme.flashlightYellow.withValues(alpha: 0.3),
        inactiveTrackColor: Colors.white10,
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback onTap;
  final Color? textColor;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: textColor ?? Colors.white70),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 12,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.white30),
      onTap: onTap,
    );
  }
}
