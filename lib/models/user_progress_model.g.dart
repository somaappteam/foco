// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProgressAdapter extends TypeAdapter<_$UserProgressImpl> {
  @override
  final int typeId = 2;

  @override
  _$UserProgressImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$UserProgressImpl(
      userId: fields[0] as String,
      sourceLanguageCode: fields[1] as String,
      targetLanguageCode: fields[2] as String,
      currentBattery: fields[3] as double,
      currentStreak: fields[4] as int,
      totalWordsIlluminated: fields[5] as int,
      totalScenesCompleted: fields[6] as int,
      lastSessionDate: fields[7] as DateTime?,
      streakLastDate: fields[8] as DateTime?,
      dailyScenesCompleted: fields[9] as int,
      lastResetDate: fields[10] as DateTime?,
      subscription: fields[11] as SubscriptionTier?,
      unlockedLanguages: (fields[12] as List).cast<String>(),
      totalTimeSeconds: fields[13] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$UserProgressImpl obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.sourceLanguageCode)
      ..writeByte(2)
      ..write(obj.targetLanguageCode)
      ..writeByte(3)
      ..write(obj.currentBattery)
      ..writeByte(4)
      ..write(obj.currentStreak)
      ..writeByte(5)
      ..write(obj.totalWordsIlluminated)
      ..writeByte(6)
      ..write(obj.totalScenesCompleted)
      ..writeByte(7)
      ..write(obj.lastSessionDate)
      ..writeByte(8)
      ..write(obj.streakLastDate)
      ..writeByte(9)
      ..write(obj.dailyScenesCompleted)
      ..writeByte(10)
      ..write(obj.lastResetDate)
      ..writeByte(11)
      ..write(obj.subscription)
      ..writeByte(13)
      ..write(obj.totalTimeSeconds)
      ..writeByte(12)
      ..write(obj.unlockedLanguages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IlluminationRecordAdapter extends TypeAdapter<_$IlluminationRecordImpl> {
  @override
  final int typeId = 3;

  @override
  _$IlluminationRecordImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$IlluminationRecordImpl(
      wordId: fields[0] as String,
      illuminatedAt: fields[1] as DateTime,
      sceneId: fields[2] as String,
      timeToFindSeconds: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$IlluminationRecordImpl obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.wordId)
      ..writeByte(1)
      ..write(obj.illuminatedAt)
      ..writeByte(2)
      ..write(obj.sceneId)
      ..writeByte(3)
      ..write(obj.timeToFindSeconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IlluminationRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProgressImpl _$$UserProgressImplFromJson(Map<String, dynamic> json) =>
    _$UserProgressImpl(
      userId: json['userId'] as String,
      sourceLanguageCode: json['sourceLanguageCode'] as String? ?? 'en-US',
      targetLanguageCode: json['targetLanguageCode'] as String? ?? 'rw',
      currentBattery: (json['currentBattery'] as num?)?.toDouble() ?? 100.0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      totalWordsIlluminated:
          (json['totalWordsIlluminated'] as num?)?.toInt() ?? 0,
      totalScenesCompleted:
          (json['totalScenesCompleted'] as num?)?.toInt() ?? 0,
      lastSessionDate: json['lastSessionDate'] == null
          ? null
          : DateTime.parse(json['lastSessionDate'] as String),
      streakLastDate: json['streakLastDate'] == null
          ? null
          : DateTime.parse(json['streakLastDate'] as String),
      dailyScenesCompleted:
          (json['dailyScenesCompleted'] as num?)?.toInt() ?? 0,
      lastResetDate: json['lastResetDate'] == null
          ? null
          : DateTime.parse(json['lastResetDate'] as String),
      subscription: json['subscription'] == null
          ? null
          : SubscriptionTier.fromJson(
              json['subscription'] as Map<String, dynamic>),
      unlockedLanguages: (json['unlockedLanguages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['en-US', 'rw'],
      totalTimeSeconds: (json['totalTimeSeconds'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserProgressImplToJson(_$UserProgressImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'sourceLanguageCode': instance.sourceLanguageCode,
      'targetLanguageCode': instance.targetLanguageCode,
      'currentBattery': instance.currentBattery,
      'currentStreak': instance.currentStreak,
      'totalWordsIlluminated': instance.totalWordsIlluminated,
      'totalScenesCompleted': instance.totalScenesCompleted,
      'lastSessionDate': instance.lastSessionDate?.toIso8601String(),
      'streakLastDate': instance.streakLastDate?.toIso8601String(),
      'dailyScenesCompleted': instance.dailyScenesCompleted,
      'lastResetDate': instance.lastResetDate?.toIso8601String(),
      'subscription': instance.subscription,
      'unlockedLanguages': instance.unlockedLanguages,
      'totalTimeSeconds': instance.totalTimeSeconds,
    };

_$IlluminationRecordImpl _$$IlluminationRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$IlluminationRecordImpl(
      wordId: json['wordId'] as String,
      illuminatedAt: DateTime.parse(json['illuminatedAt'] as String),
      sceneId: json['sceneId'] as String,
      timeToFindSeconds: (json['timeToFindSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$$IlluminationRecordImplToJson(
        _$IlluminationRecordImpl instance) =>
    <String, dynamic>{
      'wordId': instance.wordId,
      'illuminatedAt': instance.illuminatedAt.toIso8601String(),
      'sceneId': instance.sceneId,
      'timeToFindSeconds': instance.timeToFindSeconds,
    };
