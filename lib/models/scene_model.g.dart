// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SceneAdapter extends TypeAdapter<_$SceneImpl> {
  @override
  final int typeId = 0;

  @override
  _$SceneImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SceneImpl(
      id: fields[0] as String,
      imageAsset: fields[1] as String,
      thumbnailAsset: fields[2] as String,
      words: (fields[3] as List).cast<Word>(),
      category: fields[4] as String,
      languageCode: fields[5] as String,
      title: fields[6] as String,
      description: fields[7] as String,
      isCompleted: fields[8] as bool,
      difficulty: fields[9] as int,
      ambientAudioAsset: fields[10] as String?,
      completedAt: fields[11] as DateTime?,
      isPremium: fields[12] as bool,
      isUnlocked: fields[13] as bool,
      requiredTier: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$SceneImpl obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageAsset)
      ..writeByte(2)
      ..write(obj.thumbnailAsset)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.languageCode)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.isCompleted)
      ..writeByte(9)
      ..write(obj.difficulty)
      ..writeByte(10)
      ..write(obj.ambientAudioAsset)
      ..writeByte(11)
      ..write(obj.completedAt)
      ..writeByte(12)
      ..write(obj.isPremium)
      ..writeByte(13)
      ..write(obj.isUnlocked)
      ..writeByte(14)
      ..write(obj.requiredTier)
      ..writeByte(3)
      ..write(obj.words);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SceneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SceneImpl _$$SceneImplFromJson(Map<String, dynamic> json) => _$SceneImpl(
      id: json['id'] as String,
      imageAsset: json['imageAsset'] as String,
      thumbnailAsset: json['thumbnailAsset'] as String,
      words: (json['words'] as List<dynamic>)
          .map((e) => Word.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: json['category'] as String,
      languageCode: json['languageCode'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      difficulty: (json['difficulty'] as num?)?.toInt() ?? 1,
      ambientAudioAsset: json['ambientAudioAsset'] as String?,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      isPremium: json['isPremium'] as bool? ?? false,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      requiredTier: json['requiredTier'] as String?,
    );

Map<String, dynamic> _$$SceneImplToJson(_$SceneImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageAsset': instance.imageAsset,
      'thumbnailAsset': instance.thumbnailAsset,
      'words': instance.words,
      'category': instance.category,
      'languageCode': instance.languageCode,
      'title': instance.title,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'difficulty': instance.difficulty,
      'ambientAudioAsset': instance.ambientAudioAsset,
      'completedAt': instance.completedAt?.toIso8601String(),
      'isPremium': instance.isPremium,
      'isUnlocked': instance.isUnlocked,
      'requiredTier': instance.requiredTier,
    };
