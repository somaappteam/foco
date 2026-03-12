import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../models/subscription_tier.dart';
import '../models/scene_model.dart';
import '../services/subscription_service.dart';
import '../services/auth_service.dart';
import '../core/theme.dart';
import '../screens/auth_screen.dart';
import 'auth_provider.dart';

final subscriptionProvider = StateNotifierProvider<SubscriptionNotifier, SubscriptionState>((ref) {
  return SubscriptionNotifier(
    ref.watch(subscriptionServiceProvider),
    ref.watch(authServiceProvider),
  );
});

class SubscriptionState {
  final SubscriptionTier currentTier;
  final bool isLoading;
  final String? error;
  final List<ProductDetails> products;
  final bool purchasePending;

  SubscriptionState({
    SubscriptionTier? currentTier,
    this.isLoading = false,
    this.error,
    this.products = const [],
    this.purchasePending = false,
  }) : currentTier = currentTier ?? SubscriptionTier.free();

  SubscriptionState copyWith({
    SubscriptionTier? currentTier,
    bool? isLoading,
    String? error,
    List<ProductDetails>? products,
    bool? purchasePending,
  }) {
    return SubscriptionState(
      currentTier: currentTier ?? this.currentTier,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      products: products ?? this.products,
      purchasePending: purchasePending ?? this.purchasePending,
    );
  }
}

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  final SubscriptionService _service;
  final AuthService _auth;

  SubscriptionNotifier(this._service, this._auth) : super(SubscriptionState()) {
    _init();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    // If guest, force free tier regardless of stored status (security)
    if (!_auth.isAuthenticated) {
      state = state.copyWith(currentTier: SubscriptionTier.free(), isLoading: false);
      return;
    }
    
    // If authenticated, check purchase status
    final savedTier = await _service.getSavedTier();
    state = state.copyWith(currentTier: savedTier, isLoading: false);
  }

  /// Attempt purchase with auth gate
  Future<void> purchasePremium(BuildContext context) async {
    // Check auth first
    if (!_auth.isAuthenticated) {
      // Show auth screen as modal
      await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: AppTheme.pureBlack,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: AuthGateScreen(
            onSuccess: () {
              // After auth, continue to purchase
              Navigator.pop(context, true);
              _proceedWithPurchase();
            },
          ),
        ),
      );
      
      return;
    }
    
    // Already authenticated, proceed directly
    await _proceedWithPurchase();
  }

  Future<void> _proceedWithPurchase() async {
    state = state.copyWith(purchasePending: true);
    
    try {
      final products = await _service.loadProducts();
      if (products.isEmpty) throw Exception('No products available');
      
      final success = await _service.purchase(products.first);
      
      if (success) {
        state = state.copyWith(
          currentTier: SubscriptionTier.premium(),
          purchasePending: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        purchasePending: false,
      );
    }
  }

  Future<void> restorePurchases() async {
    state = state.copyWith(isLoading: true);
    if (!_auth.isAuthenticated) {
      state = state.copyWith(error: 'Sign in required to restore purchases', isLoading: false);
      return;
    }
    
    try {
      final restored = await _service.restorePurchases();
      if (restored) {
        state = state.copyWith(
          currentTier: SubscriptionTier.premium(),
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  // Game Integration Helpers
  bool canAccessScene(Scene scene) {
    if (!scene.isPremium) return true;
    return state.currentTier.tierId == 'illuminator';
  }

  bool hasBatteryForWord() {
    return state.currentTier.maxBattery > 0; // Simplified check
  }
}
