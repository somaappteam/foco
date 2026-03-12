import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> 
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  bool _showInteraction = false;
  late AnimationController _glowController;

  final List<_OnboardingStep> _steps = [
    _OnboardingStep(
      title: "It's dark in here.",
      subtitle: "But words are hiding in the shadows.",
      instruction: "Touch the screen to continue",
    ),
    _OnboardingStep(
      title: "Your finger is the light.",
      subtitle: "Move it to explore the darkness.",
      instruction: "Try moving your finger around",
      showFlashlightDemo: true,
    ),
    _OnboardingStep(
      title: "Hold steady.",
      subtitle: "Keep the light on a word for 2 seconds to reveal it.",
      instruction: "Hold on the glowing orb below",
      showBurnDemo: true,
    ),
    _OnboardingStep(
      title: "Illuminate them all.",
      subtitle: "Find every secret. Build your collection.",
      instruction: "Tap to begin your journey",
      showCompletion: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    // Auto-advance first step after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _currentStep == 0) {
        setState(() => _showInteraction = true);
      }
    });
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  void _nextStep() {
    HapticFeedback.lightImpact();
    
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
        _showInteraction = false;
      });
      
      // Show interaction hint after delay for certain steps
      if (_currentStep == 1 || _currentStep == 2) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _showInteraction = true);
        });
      }
    } else {
      // Complete onboarding
      context.go('/languages'); // Modified to point to language selection
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];
    
    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      body: GestureDetector(
        onTap: _nextStep,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Step 1: Just darkness and text
            if (_currentStep == 0) _buildStepZero(step),
            
            // Step 2: Flashlight demo (follows finger)
            if (_currentStep == 1) _buildFlashlightDemo(step),
            
            // Step 3: Burn-in demo (hold to reveal)
            if (_currentStep == 2) _buildBurnDemo(step),
            
            // Step 4: Completion glow
            if (_currentStep == 3) _buildCompletion(step),
            
            // Progress indicator (subtle dots at bottom)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_steps.length, (index) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentStep 
                        ? AppTheme.flashlightHalo 
                        : Colors.white24,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepZero(_OnboardingStep step) {
    return Center(
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 1000),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              step.title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 36,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              step.subtitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white54,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            if (_showInteraction)
              Text(
                step.instruction,
                style: const TextStyle(
                  color: Colors.white30,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlashlightDemo(_OnboardingStep step) {
    return Stack(
      children: [
        // Instructions at top
        Positioned(
          top: 100,
          left: 40,
          right: 40,
          child: Column(
            children: [
              Text(
                step.title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                step.subtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white60,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        
        // Simulated hidden object (faintly visible)
        Center(
          child: AnimatedBuilder(
            animation: _glowController,
            builder: (context, child) {
              return Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.foodGold.withValues(
                    alpha: 0.1 + (_glowController.value * 0.1)
                  ),
                  border: Border.all(
                    color: AppTheme.foodGold.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.circle,
                    color: AppTheme.foodGold.withValues(alpha: 0.5),
                    size: 40,
                  ),
                ),
              );
            },
          ),
        ),
        
        // Instruction at bottom
        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: Text(
            step.instruction,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 14,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBurnDemo(_OnboardingStep step) {
    return Stack(
      children: [
        Positioned(
          top: 100,
          left: 40,
          right: 40,
          child: Column(
            children: [
              Text(
                step.title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                step.subtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white60,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        
        // Simulated burn-in animation
        Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 2),
            builder: (context, value, child) {
              return SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 3,
                  backgroundColor: Colors.white10,
                  valueColor: const AlwaysStoppedAnimation(AppTheme.foodGold),
                ),
              );
            },
          ),
        ),
        
        // Revealed word (appears after delay)
        Center(
          child: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 2)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.foodGold),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.foodGold.withValues(alpha: 0.3),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: const Text(
                    'Apple',
                    style: TextStyle(
                      color: AppTheme.foodGold,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        
        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: Text(
            step.instruction,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 14,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletion(_OnboardingStep step) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.flashlightHalo.withValues(alpha: 0.2),
              border: Border.all(
                color: AppTheme.flashlightHalo,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.flashlightHalo.withValues(alpha: 0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: const Icon(
              Icons.check,
              color: AppTheme.flashlightHalo,
              size: 48,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            step.title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            step.subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white60,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'BEGIN EXPLORATION',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            step.instruction,
            style: const TextStyle(
              color: Colors.white30,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingStep {
  final String title;
  final String subtitle;
  final String instruction;
  final bool showFlashlightDemo;
  final bool showBurnDemo;
  final bool showCompletion;

  _OnboardingStep({
    required this.title,
    required this.subtitle,
    required this.instruction,
    this.showFlashlightDemo = false,
    this.showBurnDemo = false,
    this.showCompletion = false,
  });
}
