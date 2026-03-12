import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:hive/hive.dart';
import '../models/subscription_tier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subscriptionServiceProvider = Provider<SubscriptionService>((ref) => SubscriptionService());

class SubscriptionService {
  final InAppPurchase _iap = InAppPurchase.instance;
  static const String _premiumId = 'foco_illuminator_monthly';
  static const String _yearlyId = 'foco_illuminator_yearly';
  
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  Future<SubscriptionTier> getSavedTier() async {
    final box = Hive.box('settings');
    final tierId = box.get('subscription_tier', defaultValue: 'scout');
    if (tierId == 'illuminator') return SubscriptionTier.premium();
    return SubscriptionTier.free();
  }

  Future<void> saveTier(SubscriptionTier tier) async {
    final box = Hive.box('settings');
    await box.put('subscription_tier', tier.tierId);
  }

  Future<List<ProductDetails>> loadProducts() async {
    final available = await _iap.queryProductDetails({
      _premiumId,
      _yearlyId,
    });
    return available.productDetails;
  }

  Future<bool> purchase(ProductDetails product) => purchasePremium(product);

  Future<bool> purchasePremium(ProductDetails product) async {
    final purchaseParam = PurchaseParam(productDetails: product);
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    
    // Listen for completion
    final completer = Completer<bool>();
    _subscription = _iap.purchaseStream.listen((purchases) {
      for (final purchase in purchases) {
        if (purchase.productID == product.id) {
          if (purchase.status == PurchaseStatus.purchased || 
              purchase.status == PurchaseStatus.restored) {
            saveTier(SubscriptionTier.premium());
            completer.complete(true);
          } else if (purchase.status == PurchaseStatus.error) {
            completer.complete(false);
          }
        }
      }
    });
    
    return completer.future.timeout(const Duration(minutes: 2), onTimeout: () => false);
  }

  Future<bool> restorePurchases() async {
    await _iap.restorePurchases();
    // Check receipts
    return false; // Implement validation
  }
}
