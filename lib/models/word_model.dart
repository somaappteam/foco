import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_model.freezed.dart';
part 'word_model.g.dart';

@freezed
class Word with _$Word {
  @HiveType(typeId: 1, adapterName: 'WordAdapter')
  const factory Word({
    @HiveField(0) required String id,
    @HiveField(1) required String text, // Local script
    @HiveField(2) required String transliteration, // Romanization if needed
    @HiveField(3) required String translation,
    @HiveField(4) required String languageCode,
    @HiveField(5) required double positionX, // 0.0 to 1.0 (normalized)
    @HiveField(6) required double positionY,
    @HiveField(7) required String category, // survival, food, people, nature, abstract
    @HiveField(8) @Default(false) bool isDiscovered,
    @HiveField(9) DateTime? discoveredAt,
    @HiveField(10) @Default(100) int illuminationStrength, // 100 = bright, 0 = faded
    @HiveField(11) String? audioAsset,
    @HiveField(12) @Default(false) bool isPremiumOnly, // Hidden for free users
  }) = _Word;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
}
