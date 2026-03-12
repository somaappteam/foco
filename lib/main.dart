import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'core/supabase_config.dart';
import 'core/theme.dart';
import 'core/router.dart';
import 'services/lifecycle_service.dart';
import 'services/notification_service.dart';
import 'services/deep_link_handler.dart';
import 'services/image_preloader.dart';
import 'models/scene_model.dart';
import 'models/user_progress_model.dart';
import 'models/word_model.dart';
import 'models/subscription_tier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Orientations
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  
  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(WordAdapter());
  Hive.registerAdapter(SceneAdapter());
  Hive.registerAdapter(UserProgressAdapter());
  Hive.registerAdapter(SubscriptionTierAdapter());
  Hive.registerAdapter(IlluminationRecordAdapter());
  
  await Hive.openBox<Scene>('scenes');
  await Hive.openBox<Word>('discovered_words');
  await Hive.openBox<UserProgress>('user_progress');
  await Hive.openBox<IlluminationRecord>('illuminations');
  await Hive.openBox('settings');
  await Hive.openBox('sync_queue');
  await Hive.openBox('auth');
  
  // Supabase
  await SupabaseConfig.initialize();
  
  // Notifications (critical for decay mechanic)
  await NotificationService().initialize();
  
  // Wakelock (keep screen on during hunt)
  await WakelockPlus.enable();
  
  runApp(const ProviderScope(child: FocoApp()));
}

class FocoApp extends ConsumerStatefulWidget {
  const FocoApp({super.key});

  @override
  ConsumerState<FocoApp> createState() => _FocoAppState();
}

class _FocoAppState extends ConsumerState<FocoApp> {
  @override
  void initState() {
    super.initState();
    
    // Initialize lifecycle observer (pauses battery when backgrounded)
    ref.read(lifecycleObserverProvider);
    
    // Initialize deep links (OAuth callbacks)
    ref.read(deepLinkHandlerProvider).initialize();
    
    // Preload images
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(imagePreloaderProvider).preloadScenes(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'FOCO',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: router,
      builder: (context, child) {
        // Global error handling
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return _buildErrorScreen(details);
        };
        return child!;
      },
    );
  }

  Widget _buildErrorScreen(FlutterErrorDetails details) {
    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.broken_image, color: AppTheme.survivalRed, size: 64),
            const SizedBox(height: 24),
            const Text('Sector Corrupted', style: TextStyle(color: Colors.white, fontSize: 24)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() {}), // Force rebuild
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.flashlightYellow),
              child: const Text('RETRY', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
