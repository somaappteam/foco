import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_tier.freezed.dart';
part 'subscription_tier.g.dart';

@freezed
class SubscriptionTier with _$SubscriptionTier {
  @HiveType(typeId: 4, adapterName: 'SubscriptionTierAdapter')
  const factory SubscriptionTier({
    @HiveField(0) required String tierId, // 'scout', 'illuminator', 'archivist'
    @HiveField(1) required String name, // "Flashlight Battery: Standard"
    @HiveField(2) required int maxBattery, // 100, 200, unlimited
    @HiveField(3) required int dailyScenes, // 1, 3, unlimited
    @HiveField(4) required int wordsPerScene, // 3, 5, 7
    @HiveField(5) required bool cloudSync,
    @HiveField(6) required bool exclusiveScenes,
    @HiveField(7) required String lightColor, // White, Gold, Purple
    @HiveField(8) required double beamRadius, // 100, 150, 200
    @HiveField(9) @Default(false) bool isActive,
    @HiveField(10) DateTime? expiryDate,
  }) = _SubscriptionTier;

  factory SubscriptionTier.fromJson(Map<String, dynamic> json) => _$SubscriptionTierFromJson(json);
  
  // Predefined Tiers (Game Integration)
  static SubscriptionTier free() => const SubscriptionTier(
    tierId: 'scout',
    name: 'Field Scout',
    maxBattery: 50, // Drains fast, limited exploration
    dailyScenes: 1, // Only 1 room per day
    wordsPerScene: 3, // Can only find 3 words (others hidden)
    cloudSync: false,
    exclusiveScenes: false,
    lightColor: 'white',
    beamRadius: 80, // Narrow beam, harder to find
  );

  static SubscriptionTier premium() => const SubscriptionTier(
    tierId: 'illuminator',
    name: 'Master Illuminator',
    maxBattery: 200, // All day exploration
    dailyScenes: 999, // Unlimited
    wordsPerScene: 5, // Full scene completion
    cloudSync: true,
    exclusiveScenes: true, // Access to "Legendary" dark rooms
    lightColor: 'gold',
    beamRadius: 150, // Wide beam, easier hunting
  );
}
