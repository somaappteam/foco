import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'word_model.dart';

part 'scene_model.freezed.dart';
part 'scene_model.g.dart';

@freezed
class Scene with _$Scene {
  const Scene._();
  @HiveType(typeId: 0, adapterName: 'SceneAdapter')
  const factory Scene({
    @HiveField(0) required String id,
    @HiveField(1) required String imageAsset, // Local path or URL
    @HiveField(2) required String thumbnailAsset,
    @HiveField(3) required List<Word> words,
    @HiveField(4) required String category,
    @HiveField(5) required String languageCode,
    @HiveField(6) required String title,
    @HiveField(7) required String description, // "The Market at Dawn"
    @HiveField(8) @Default(false) bool isCompleted,
    @HiveField(9) @Default(1) int difficulty, // 1-5 (affects word hiding depth)
    @HiveField(10) String? ambientAudioAsset,
    @HiveField(11) DateTime? completedAt,
    @HiveField(12) @Default(false) bool isPremium, // Legendary scenes
    @HiveField(13) @Default(false) bool isUnlocked,
    @HiveField(14) String? requiredTier, // 'illuminator' to access
  }) = _Scene;

  factory Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);
  
  int get discoveredCount => words.where((w) => w.isDiscovered).length;
  int get totalWords => words.length;
}
