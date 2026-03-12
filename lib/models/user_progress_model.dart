import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'subscription_tier.dart';

part 'user_progress_model.freezed.dart';
part 'user_progress_model.g.dart';

@freezed
class UserProgress with _$UserProgress {
  @HiveType(typeId: 2, adapterName: 'UserProgressAdapter')
  const factory UserProgress({
    @HiveField(0) required String userId,
    @HiveField(1) @Default('en-US') String sourceLanguageCode,
    @HiveField(2) @Default('rw') String targetLanguageCode,
    @HiveField(3) @Default(100.0) double currentBattery,
    @HiveField(4) @Default(0) int currentStreak,
    @HiveField(5) @Default(0) int totalWordsIlluminated,
    @HiveField(6) @Default(0) int totalScenesCompleted,
    @HiveField(7) DateTime? lastSessionDate,
    @HiveField(8) DateTime? streakLastDate,
    @HiveField(9) @Default(0) int dailyScenesCompleted,
    @HiveField(10) DateTime? lastResetDate,
    @HiveField(11) SubscriptionTier? subscription,
    @HiveField(12) @Default(['en-US', 'rw']) List<String> unlockedLanguages,
    @HiveField(13) @Default(0) int totalTimeSeconds, // Game stats
  }) = _UserProgress;

  factory UserProgress.fromJson(Map<String, dynamic> json) => _$UserProgressFromJson(json);
}

@freezed
class IlluminationRecord with _$IlluminationRecord {
  @HiveType(typeId: 3, adapterName: 'IlluminationRecordAdapter')
  const factory IlluminationRecord({
    @HiveField(0) required String wordId,
    @HiveField(1) required DateTime illuminatedAt,
    @HiveField(2) required String sceneId,
    @HiveField(3) required int timeToFindSeconds, // How long it took to discover
  }) = _IlluminationRecord;

  factory IlluminationRecord.fromJson(Map<String, dynamic> json) => _$IlluminationRecordFromJson(json);
}
