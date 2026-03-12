// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_tier.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubscriptionTierAdapter extends TypeAdapter<_$SubscriptionTierImpl> {
  @override
  final int typeId = 4;

  @override
  _$SubscriptionTierImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SubscriptionTierImpl(
      tierId: fields[0] as String,
      name: fields[1] as String,
      maxBattery: fields[2] as int,
      dailyScenes: fields[3] as int,
      wordsPerScene: fields[4] as int,
      cloudSync: fields[5] as bool,
      exclusiveScenes: fields[6] as bool,
      lightColor: fields[7] as String,
      beamRadius: fields[8] as double,
      isActive: fields[9] as bool,
      expiryDate: fields[10] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, _$SubscriptionTierImpl obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.tierId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.maxBattery)
      ..writeByte(3)
      ..write(obj.dailyScenes)
      ..writeByte(4)
      ..write(obj.wordsPerScene)
      ..writeByte(5)
      ..write(obj.cloudSync)
      ..writeByte(6)
      ..write(obj.exclusiveScenes)
      ..writeByte(7)
      ..write(obj.lightColor)
      ..writeByte(8)
      ..write(obj.beamRadius)
      ..writeByte(9)
      ..write(obj.isActive)
      ..writeByte(10)
      ..write(obj.expiryDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionTierAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionTierImpl _$$SubscriptionTierImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionTierImpl(
      tierId: json['tierId'] as String,
      name: json['name'] as String,
      maxBattery: (json['maxBattery'] as num).toInt(),
      dailyScenes: (json['dailyScenes'] as num).toInt(),
      wordsPerScene: (json['wordsPerScene'] as num).toInt(),
      cloudSync: json['cloudSync'] as bool,
      exclusiveScenes: json['exclusiveScenes'] as bool,
      lightColor: json['lightColor'] as String,
      beamRadius: (json['beamRadius'] as num).toDouble(),
      isActive: json['isActive'] as bool? ?? false,
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
    );

Map<String, dynamic> _$$SubscriptionTierImplToJson(
        _$SubscriptionTierImpl instance) =>
    <String, dynamic>{
      'tierId': instance.tierId,
      'name': instance.name,
      'maxBattery': instance.maxBattery,
      'dailyScenes': instance.dailyScenes,
      'wordsPerScene': instance.wordsPerScene,
      'cloudSync': instance.cloudSync,
      'exclusiveScenes': instance.exclusiveScenes,
      'lightColor': instance.lightColor,
      'beamRadius': instance.beamRadius,
      'isActive': instance.isActive,
      'expiryDate': instance.expiryDate?.toIso8601String(),
    };
