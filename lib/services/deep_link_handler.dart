import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

final deepLinkHandlerProvider = Provider<DeepLinkHandler>((ref) {
  return DeepLinkHandler(ref);
});

class DeepLinkHandler {
  final Ref _ref;
  final _appLinks = AppLinks();

  DeepLinkHandler(this._ref);

  void initialize() {
    // Listen for incoming links
    _appLinks.uriLinkStream.listen((uri) {
      _handleLink(uri);
    });
    
    // Check initial link (app opened from link)
    _appLinks.getInitialAppLink().then((uri) {
      if (uri != null) _handleLink(uri);
    });
  }

  void _handleLink(Uri uri) {
    HapticFeedback.mediumImpact();
    
    // Supabase Auth callback
    if (uri.scheme == 'io.supabase.foco' && uri.host == 'callback') {
      _handleAuthCallback();
      return;
    }
    
    // Game deep links
    if (uri.path == '/decay') {
      // Navigate to decay alert
      final context = _ref.read(navigatorKeyProvider).currentContext;
      if (context != null) context.push('/recharge');
    }
    
    if (uri.path == '/scene' && uri.queryParameters.containsKey('id')) {
      final sceneId = uri.queryParameters['id']!;
      final context = _ref.read(navigatorKeyProvider).currentContext;
      if (context != null) {
        // Load specific scene
        context.go('/game', extra: sceneId);
      }
    }
  }

  Future<void> _handleAuthCallback() async {
    // Note: handleAuthCallback would need to be implemented in AuthService
    // For now, it's a placeholder for the integration logic
  }
}

// Global navigator key for context access outside widgets
final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});
