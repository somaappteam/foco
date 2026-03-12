import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/theme.dart';

class CompetitionScreen extends ConsumerStatefulWidget {
  const CompetitionScreen({super.key});

  @override
  ConsumerState<CompetitionScreen> createState() => _CompetitionScreenState();
}

class _CompetitionScreenState extends ConsumerState<CompetitionScreen> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SHADOW HUNTS',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white38,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Compete in the dark',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Race against ghost trails or hunt synchronously',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            TabBar(
              controller: _tabController,
              labelColor: AppTheme.flashlightYellow,
              unselectedLabelColor: Colors.white38,
              indicatorColor: AppTheme.flashlightYellow,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(text: 'ASYNC'),
                Tab(text: 'LIVE'),
                Tab(text: 'RANKINGS'),
              ],
            ),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _AsyncHuntsTab(),
                  _LiveHuntsTab(),
                  _RankingsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AsyncHuntsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _CompetitionCard(
          title: 'The Midnight Market Sprint',
          description: 'Fastest to find all 5 words. Ghost trails enabled.',
          participants: 234,
          timeLimit: 'Best: 45s',
          difficulty: 'Medium',
          color: AppTheme.foodGold,
          onTap: () => _startAsyncHunt(context),
        ),
        _CompetitionCard(
          title: 'Survival Horror',
          description: 'Red battery mode. One life. No mistakes.',
          participants: 89,
          timeLimit: 'Survival',
          difficulty: 'Hard',
          color: AppTheme.survivalRed,
          isLocked: true,
          onTap: () {},
        ),
        _CompetitionCard(
          title: 'Archivist Challenge',
          description: 'Find rare words in legendary scenes.',
          participants: 12,
          timeLimit: 'Unlimited',
          difficulty: 'Expert',
          color: AppTheme.abstractViolet,
          isLocked: true,
          onTap: () {},
        ),
      ],
    );
  }

  void _startAsyncHunt(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.shadowGray,
        title: const Text('Ghost Trails Enabled', style: TextStyle(color: Colors.white)),
        content: const Text(
          'You will see translucent trails of other players\' flashlight paths. '
          'Can you find faster routes through the darkness?',
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
              context.go('/game?mode=competition');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.foodGold,
              foregroundColor: Colors.black,
            ),
            child: const Text('ENTER HUNT'),
          ),
        ],
      ),
    );
  }
}

class _LiveHuntsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.people_outline,
            size: 64,
            color: Colors.white24,
          ),
          const SizedBox(height: 24),
          Text(
            'Live Shadow Duels',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Two explorers enter the same room simultaneously. '
              'First to illuminate the target word wins the battery charge.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // Matchmaking logic
              HapticFeedback.mediumImpact();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.flashlightYellow,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text('FIND OPPONENT'),
          ),
          const SizedBox(height: 16),
          const Text(
            '12 hunters waiting in the dark',
            style: TextStyle(
              color: Colors.white30,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _RankingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _LeaderboardItem(
          rank: 1,
          name: 'PhantomSeeker',
          score: '2,451',
          isUser: false,
        ),
        const _LeaderboardItem(
          rank: 2,
          name: 'DarkWhisper',
          score: '2,389',
          isUser: false,
        ),
        const _LeaderboardItem(
          rank: 3,
          name: 'You',
          score: '1,204',
          isUser: true,
        ),
        const _LeaderboardItem(
          rank: 4,
          name: 'VoidWalker',
          score: '987',
          isUser: false,
        ),
        const Divider(color: Colors.white10, height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'This Week',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white38,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const _StatRow(label: 'Words Found', value: '47'),
        const _StatRow(label: 'Win Rate', value: '68%'),
        const _StatRow(label: 'Best Time', value: '32s'),
      ],
    );
  }
}

class _CompetitionCard extends StatelessWidget {
  final String title;
  final String description;
  final int participants;
  final String timeLimit;
  final String difficulty;
  final Color color;
  final bool isLocked;
  final VoidCallback onTap;

  const _CompetitionCard({
    required this.title,
    required this.description,
    required this.participants,
    required this.timeLimit,
    required this.difficulty,
    required this.color,
    this.isLocked = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.shadowGray,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isLocked ? Colors.white10 : color.withValues(alpha: 0.3),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLocked ? null : onTap,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          difficulty.toUpperCase(),
                          style: TextStyle(
                            color: color,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (isLocked)
                        const Icon(Icons.lock, color: Colors.white30, size: 20)
                      else
                        Icon(Icons.arrow_forward, color: color, size: 20),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyle(
                      color: isLocked ? Colors.white38 : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: isLocked ? 0.3 : 0.6),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.people, color: Colors.white30, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        '$participants hunting',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.timer, color: Colors.white30, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        timeLimit,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LeaderboardItem extends StatelessWidget {
  final int rank;
  final String name;
  final String score;
  final bool isUser;

  const _LeaderboardItem({
    required this.rank,
    required this.name,
    required this.score,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    Color rankColor;
    if (rank == 1) {
      rankColor = AppTheme.foodGold;
    } else if (rank == 2) {
      rankColor = Colors.white70;
    } else if (rank == 3) {
      rankColor = const Color(0xFFCD7F32); // Bronze
    } else {
      rankColor = Colors.white38;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isUser ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isUser ? Border.all(color: Colors.white24) : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '$rank',
              style: TextStyle(
                color: rankColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.white70,
                fontWeight: isUser ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            score,
            style: TextStyle(
              color: isUser ? AppTheme.flashlightYellow : Colors.white54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white54),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
