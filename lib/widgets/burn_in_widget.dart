import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme.dart';

class IlluminationProgress extends StatelessWidget {
  final double progress;
  final String word;
  final String category;
  final bool isPremiumWord;

  const IlluminationProgress({
    super.key,
    required this.progress,
    required this.word,
    required this.category,
    this.isPremiumWord = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor(category);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Outer ring with gradient sweep
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background track
              CircularProgressIndicator(
                value: 1,
                strokeWidth: 2,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                valueColor: const AlwaysStoppedAnimation(Colors.transparent),
              ),
              // Active progress
              CircularProgressIndicator(
                value: progress,
                strokeWidth: 3,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
              // Pulsing center
              Center(
                child: Container(
                  width: 60 + (progress * 20),
                  height: 60 + (progress * 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withValues(alpha: 0.2 + (progress * 0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: progress * 0.8),
                        blurRadius: 20 + (progress * 30),
                        spreadRadius: 2 + (progress * 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Opacity(
                      opacity: progress > 0.5 ? 1 : 0,
                      child: Text(
                        word.substring(0, (word.length * progress).ceil().clamp(1, word.length)),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          shadows: [
                            Shadow(
                              color: color,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Word preview text
        if (progress > 0.8)
          Text(
            'REVEALING...',
            style: TextStyle(
              color: color,
              fontSize: 10,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn().shimmer(duration: 500.ms),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'survival': return AppTheme.survivalRed;
      case 'food': return AppTheme.foodGold;
      case 'people': return AppTheme.peopleAmber;
      case 'nature': return AppTheme.natureEmerald;
      case 'abstract': return AppTheme.abstractViolet;
      case 'water': return AppTheme.waterCyan;
      default: return AppTheme.flashlightCore;
    }
  }
}
