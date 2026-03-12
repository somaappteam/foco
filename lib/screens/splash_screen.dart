import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../core/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  bool _showTapPrompt = false;

  @override
  void initState() {
    super.initState();
    
    // Fade in the spotlight
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    
    // Subtle breathing animation for the light
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);
    
    // Start sequence
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _fadeController.forward();
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) setState(() => _showTapPrompt = true);
        });
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _onTap() {
    // Haptic: The first light turns on
    HapticFeedback.mediumImpact();
    
    // Flash effect
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: SizedBox.shrink(),
        backgroundColor: Colors.white,
        duration: Duration(milliseconds: 100),
      ),
    );
    
    // Navigate with fade
    context.go('/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: AppTheme.pureBlack,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // The Spotlight Logo (off-center as per brand guidelines)
            Positioned(
              left: MediaQuery.of(context).size.width * 0.45,
              top: MediaQuery.of(context).size.height * 0.4,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      width: 100 + (_pulseController.value * 10),
                      height: 100 + (_pulseController.value * 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppTheme.flashlightHalo, // Replaced flashlightYellow which doesn't exist
                            AppTheme.flashlightHalo.withValues(alpha: 0.4),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.flashlightHalo.withValues(
                              alpha: 0.2 + (_pulseController.value * 0.1)
                            ),
                            blurRadius: 60 + (_pulseController.value * 20),
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // "FOCO" text - subtle, appearing late
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'FOCO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 14,
                    letterSpacing: 8,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            
            // Tap instruction
            if (_showTapPrompt)
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: _showTapPrompt ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: const Text(
                    'Tap anywhere to turn on your light',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
