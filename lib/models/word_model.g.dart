// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordAdapter extends TypeAdapter<_$WordImpl> {
  @override
  final int typeId = 1;

  @override
  _$WordImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$WordImpl(
      id: fields[0] as String,
      text: fields[1] as String,
      transliteration: fields[2] as String,
      translation: fields[3] as String,
      languageCode: fields[4] as String,
      positionX: fields[5] as double,
      positionY: fields[6] as double,
      category: fields[7] as String,
      isDiscovered: fields[8] as bool,
      discoveredAt: fields[9] as DateTime?,
      illuminationStrength: fields[10] as int,
      audioAsset: fields[11] as String?,
      isPremiumOnly: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$WordImpl obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.transliteration)
      ..writeByte(3)
      ..write(obj.translation)
      ..writeByte(4)
      ..write(obj.languageCode)
      ..writeByte(5)
      ..write(obj.positionX)
      ..writeByte(6)
      ..write(obj.positionY)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.isDiscovered)
      ..writeByte(9)
      ..write(obj.discoveredAt)
      ..writeByte(10)
      ..write(obj.illuminationStrength)
      ..writeByte(11)
      ..write(obj.audioAsset)
      ..writeByte(12)
      ..write(obj.isPremiumOnly);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WordImpl _$$WordImplFromJson(Map<String, dynamic> json) => _$WordImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      transliteration: json['transliteration'] as String,
      translation: json['translation'] as String,
      languageCode: json['languageCode'] as String,
      positionX: (json['positionX'] as num).toDouble(),
      positionY: (json['positionY'] as num).toDouble(),
      category: json['category'] as String,
      isDiscovered: json['isDiscovered'] as bool? ?? false,
      discoveredAt: json['discoveredAt'] == null
          ? null
          : DateTime.parse(json['discoveredAt'] as String),
      illuminationStrength:
          (json['illuminationStrength'] as num?)?.toInt() ?? 100,
      audioAsset: json['audioAsset'] as String?,
      isPremiumOnly: json['isPremiumOnly'] as bool? ?? false,
    );

Map<String, dynamic> _$$WordImplToJson(_$WordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'transliteration': instance.transliteration,
      'translation': instance.translation,
      'languageCode': instance.languageCode,
      'positionX': instance.positionX,
      'positionY': instance.positionY,
      'category': instance.category,
      'isDiscovered': instance.isDiscovered,
      'discoveredAt': instance.discoveredAt?.toIso8601String(),
      'illuminationStrength': instance.illuminationStrength,
      'audioAsset': instance.audioAsset,
      'isPremiumOnly': instance.isPremiumOnly,
    };
