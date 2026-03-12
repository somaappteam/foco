import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/theme.dart';
import '../core/languages.dart';
import '../providers/user_provider.dart';

// Selection states
final sourceLanguageProvider = StateProvider<AppLanguage>((ref) => AppLanguages.all.firstWhere((l) => l.code == 'en-US'));
final targetLanguageProvider = StateProvider<AppLanguage>((ref) => AppLanguages.all.firstWhere((l) => l.code == 'rw'));

class LanguageSelectionScreen extends ConsumerStatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  ConsumerState<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends ConsumerState<LanguageSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSelectingSource = false; // Toggle between source and target

  List<AppLanguage> get _filteredLanguages {
    if (_searchQuery.isEmpty) return AppLanguages.all;
    return AppLanguages.all.where((l) => 
      l.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      l.code.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final sourceLang = ref.watch(sourceLanguageProvider);
    final targetLang = ref.watch(targetLanguageProvider);

    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'LANGUAGE\nSTRATEGY',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40),
              ),
              const SizedBox(height: 12),
              Text(
                'Learn any language from any language.\nThe concept remains, the shadow shifts.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 40),
              
              // Pair Selector Toggle
              Row(
                children: [
                  Expanded(
                    child: _SelectionCard(
                      label: 'I SPEAK',
                      language: sourceLang,
                      isActive: _isSelectingSource,
                      onTap: () => setState(() => _isSelectingSource = true),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(Icons.arrow_forward_rounded, color: Colors.white24),
                  ),
                  Expanded(
                    child: _SelectionCard(
                      label: 'LEARNING',
                      language: targetLang,
                      isActive: !_isSelectingSource,
                      onTap: () => setState(() => _isSelectingSource = false),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              
              // Search Bar
              TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search 185 languages...',
                  hintStyle: const TextStyle(color: Colors.white24),
                  prefixIcon: const Icon(Icons.search, color: Colors.white24),
                  filled: true,
                  fillColor: AppTheme.shadowGray,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),

              const SizedBox(height: 20),
              
              // Language List
              Expanded(
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent],
                      stops: [0.0, 0.05, 0.95, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: ListView.separated(
                    itemCount: _filteredLanguages.length,
                    separatorBuilder: (_, __) => const Divider(color: Colors.white10, height: 1),
                    itemBuilder: (context, index) {
                      final lang = _filteredLanguages[index];
                      final isSelected = _isSelectingSource 
                          ? lang == sourceLang 
                          : lang == targetLang;

                      return ListTile(
                        leading: Text(lang.flag, style: const TextStyle(fontSize: 24)),
                        onTap: () {
                          if (_isSelectingSource) {
                            ref.read(sourceLanguageProvider.notifier).state = lang;
                          } else {
                            ref.read(targetLanguageProvider.notifier).state = lang;
                          }
                          // Proactively switch to other slot if selecting source
                          if (_isSelectingSource) {
                             setState(() => _isSelectingSource = false);
                          }
                        },
                        title: Text(
                          lang.name.toUpperCase(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white60,
                            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1.5,
                          ),
                        ),
                        subtitle: Text(
                          lang.code,
                          style: const TextStyle(color: Colors.white24, fontSize: 10),
                        ),
                        trailing: isSelected 
                            ? const Icon(Icons.check_circle, color: AppTheme.flashlightCore)
                            : null,
                      );
                    },
                  ),
                ),
              ),

              // Finalize Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final source = ref.read(sourceLanguageProvider);
                      final target = ref.read(targetLanguageProvider);
                      
                      await ref.read(userProgressProvider.notifier).updateLanguagePair(source.code, target.code);
                      
                      if (context.mounted) {
                        context.go('/game');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('INITIALIZE STRATEGY', style: TextStyle(fontWeight: FontWeight.w900)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  final String label;
  final AppLanguage language;
  final bool isActive;
  final VoidCallback onTap;

  const _SelectionCard({
    required this.label,
    required this.language,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withValues(alpha: 0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? Colors.white : Colors.white10,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(language.flag, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    language.name,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
