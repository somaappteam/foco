import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme.dart';

class GalleryScreen extends ConsumerStatefulWidget {
  const GalleryScreen({super.key});

  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    // Mock data - connect to real provider in production
    final words = <dynamic>[];
    final fadingWords = <dynamic>[];
    final deadWords = <dynamic>[];

    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'MEMORY ARCHIVE',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  letterSpacing: 3,
                  color: Colors.white54,
                ),
              ),
              centerTitle: true,
              background: Center(
                child: Icon(
                  Icons.photo_album,
                  color: Colors.white.withValues(alpha: 0.1),
                  size: 80,
                ),
              ),
            ),
          ),
          
          // Warning Section (Fading Words)
          if (fadingWords.isNotEmpty)
            SliverToBoxAdapter(
              child: _DecayWarningSection(words: fadingWords),
            ),

          // Main Grid
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index < words.length) {
                    return _IlluminatedPolaroid(word: words[index]);
                  } else if (index < words.length + deadWords.length) {
                    return _DeadPolaroid(word: deadWords[index - words.length]);
                  }
                  return _EmptySlot();
                },
                childCount: words.length + deadWords.length + 4, // Empty slots for mystery
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IlluminatedPolaroid extends StatelessWidget {
  final dynamic word;

  const _IlluminatedPolaroid({required this.word});

  @override
  Widget build(BuildContext context) {
    final age = DateTime.now().difference(word.discoveredAt ?? DateTime.now()).inDays;
    final isFading = age > 3;
    
    return Transform.rotate(
      angle: (word.hashCode % 10 - 5) * 0.03,
      child: Container(
        decoration: BoxDecoration(
          color: isFading ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: isFading ? Colors.black : _getColor(word.category).withValues(alpha: 0.3),
              blurRadius: isFading ? 5 : 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isFading ? Colors.black87 : Colors.black,
                  borderRadius: BorderRadius.circular(2),
                  border: isFading ? Border.all(color: Colors.white10) : null,
                ),
                child: Center(
                  child: Text(
                    word.text,
                    style: TextStyle(
                      color: isFading ? Colors.white24 : _getColor(word.category),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      shadows: isFading ? [] : [
                        Shadow(
                          color: _getColor(word.category),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    word.translation,
                    style: TextStyle(
                      color: isFading ? Colors.grey[700] : Colors.black87,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (isFading) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.batteryCritical.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'FADING',
                        style: TextStyle(
                          color: AppTheme.batteryCritical,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, curve: Curves.easeOut),
    );
  }

  Color _getColor(String category) {
    switch (category) {
      case 'survival': return AppTheme.survivalRed;
      case 'food': return AppTheme.foodGold;
      case 'people': return AppTheme.peopleAmber;
      case 'nature': return AppTheme.natureEmerald;
      default: return AppTheme.flashlightCore;
    }
  }
}

class _DeadPolaroid extends StatelessWidget {
  final dynamic word;
  const _DeadPolaroid({required this.word});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Icon(Icons.broken_image, color: Colors.white.withValues(alpha: 0.2), size: 32),
            const SizedBox(height: 8),
            Text(
              'LOST TO DARKNESS',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptySlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1), style: BorderStyle.solid),
      ),
      child: Center(
        child: Icon(
          Icons.question_mark,
          color: Colors.white.withValues(alpha: 0.1),
          size: 24,
        ),
      ),
    );
  }
}

class _DecayWarningSection extends StatelessWidget {
  final List<dynamic> words;

  const _DecayWarningSection({required this.words});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.batteryCritical.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.batteryCritical.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: AppTheme.batteryCritical,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${words.length} MEMORIES FADING',
                  style: const TextStyle(
                    color: AppTheme.batteryCritical,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Re-illuminate them before they are lost forever.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().shake(duration: 500.ms);
  }
}
