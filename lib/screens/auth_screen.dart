import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/theme.dart';
import '../providers/auth_provider.dart';
import '../services/auth_service.dart';

/// Compact auth sheet that slides up when guest tries to subscribe
class AuthGateScreen extends ConsumerStatefulWidget {
  final VoidCallback? onSuccess; // Called after successful auth
  
  const AuthGateScreen({super.key, this.onSuccess});

  @override
  ConsumerState<AuthGateScreen> createState() => _AuthGateScreenState();
}

class _AuthGateScreenState extends ConsumerState<AuthGateScreen> {
  bool _isSignUp = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'SECURE YOUR PROGRESS',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
            letterSpacing: 2,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                _isSignUp 
                  ? 'Create Account to Continue' 
                  : 'Welcome Back, Hunter',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Authentication is required for Master Illuminator equipment. '
                'Your guest progress will be preserved.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 32),

              // Form
              _buildTextField(
                controller: _emailController,
                hint: 'Email Address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              
              _buildTextField(
                controller: _passwordController,
                hint: 'Password',
                icon: Icons.lock_outline,
                isPassword: true,
              ),
              
              if (_error != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.survivalRed.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.survivalRed.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: AppTheme.survivalRed, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _error!,
                          style: const TextStyle(color: AppTheme.survivalRed, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Primary Action
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.foodGold,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      )
                    : Text(
                        _isSignUp ? 'CREATE ACCOUNT' : 'SIGN IN',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                ),
              ),

              const SizedBox(height: 16),

              // Toggle
              Center(
                child: TextButton(
                  onPressed: () => setState(() => _isSignUp = !_isSignUp),
                  child: Text(
                    _isSignUp 
                      ? 'Already have an account? Sign In' 
                      : 'New here? Create Account',
                    style: const TextStyle(color: Colors.white60),
                  ),
                ),
              ),

              const Spacer(),

              // Divider
              const Row(
                children: [
                  Expanded(child: Divider(color: Colors.white10)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: TextStyle(color: Colors.white30, fontSize: 12),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white10)),
                ],
              ),

              const SizedBox(height: 24),

              // Social Auth
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _signInWithGoogle,
                  icon: const Icon(Icons.g_mobiledata, color: Colors.white),
                  label: const Text('Continue with Google'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white30),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Guest fallback
              Center(
                child: TextButton(
                  onPressed: () => context.pop(),
                  child: const Text(
                    'Stay in Guest Mode (No Subscription)',
                    style: TextStyle(
                      color: Colors.white30,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          prefixIcon: Icon(icon, color: Colors.white38),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    HapticFeedback.mediumImpact();
    setState(() => _isLoading = true);
    
    try {
      if (_isSignUp) {
        await ref.read(authStateProvider.notifier).signUp(
          _emailController.text.trim(),
          _passwordController.text,
        );
      } else {
        await ref.read(authStateProvider.notifier).signIn(
          _emailController.text.trim(),
          _passwordController.text,
        );
      }
      
      // Success
      if (widget.onSuccess != null) {
        widget.onSuccess!();
      } else {
        if (mounted) context.pop();
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authStateProvider.notifier).signInWithGoogle();
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}

// ==================== MINIMAL AUTH BUTTON FOR SETTINGS ====================

class AccountStatusTile extends ConsumerWidget {
  final VoidCallback onAuthRequired;

  const AccountStatusTile({super.key, required this.onAuthRequired});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authService = ref.watch(authServiceProvider);

    String title;
    String subtitle;
    IconData icon;
    Color color;

    switch (authState) {
      case AuthState.guest:
        title = 'Guest Explorer';
        subtitle = 'Sign in to unlock Master Illuminator';
        icon = Icons.account_circle_outlined;
        color = Colors.white54;
        break;
      case AuthState.authenticating:
        title = 'Connecting...';
        subtitle = 'Please wait';
        icon = Icons.sync;
        color = Colors.white30;
        break;
      case AuthState.authenticated:
        title = authService.user?.email ?? 'Authenticated';
        subtitle = 'Master Illuminator Eligible';
        icon = Icons.verified_user;
        color = AppTheme.batteryFull;
        break;
      case AuthState.error:
        title = 'Connection Error';
        subtitle = 'Tap to retry';
        icon = Icons.error_outline;
        color = AppTheme.survivalRed;
        break;
    }

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white54, fontSize: 12),
      ),
      trailing: authState == AuthState.guest
        ? TextButton(
            onPressed: onAuthRequired,
            child: const Text('SIGN IN', style: TextStyle(color: AppTheme.foodGold)),
          )
        : authState == AuthState.authenticated
          ? TextButton(
              onPressed: () => _confirmSignOut(context, ref),
              child: const Text('SIGN OUT', style: TextStyle(color: Colors.white38)),
            )
          : null,
    );
  }

  void _confirmSignOut(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.shadowGray,
        title: const Text('Sign Out?', style: TextStyle(color: Colors.white)),
        content: const Text(
          'You will return to Guest mode. Your progress is saved.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              ref.read(authStateProvider.notifier).signOut();
              Navigator.pop(context);
            },
            child: const Text('Sign Out', style: TextStyle(color: AppTheme.survivalRed)),
          ),
        ],
      ),
    );
  }
}
