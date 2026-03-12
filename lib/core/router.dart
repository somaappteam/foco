import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../services/deep_link_handler.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/game_screen.dart';
import '../screens/gallery_screen.dart';
import '../screens/equipment_screen.dart'; // Subscription as Equipment
import '../screens/language_selection_screen.dart';
import '../screens/decay_alert_screen.dart'; // Battery dead screen
import '../screens/scene_selection_screen.dart';
import '../screens/competition_screen.dart';
import '../screens/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final navigatorKey = ref.watch(navigatorKeyProvider);
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
      GoRoute(path: '/game', builder: (context, state) => const GameScreen()),
      GoRoute(path: '/gallery', builder: (context, state) => const GalleryScreen()),
      GoRoute(path: '/equipment', builder: (context, state) => const EquipmentScreen()),
      GoRoute(path: '/languages', builder: (context, state) => const LanguageSelectionScreen()),
      GoRoute(path: '/recharge', builder: (context, state) => const DecayAlertScreen()),
      GoRoute(path: '/scenes', builder: (context, state) => const SceneSelectionScreen()),
      GoRoute(path: '/compete', builder: (context, state) => const CompetitionScreen()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
    ],
  );
});
