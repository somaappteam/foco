// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_tier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubscriptionTier _$SubscriptionTierFromJson(Map<String, dynamic> json) {
  return _SubscriptionTier.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionTier {
  @HiveField(0)
  String get tierId =>
      throw _privateConstructorUsedError; // 'scout', 'illuminator', 'archivist'
  @HiveField(1)
  String get name =>
      throw _privateConstructorUsedError; // "Flashlight Battery: Standard"
  @HiveField(2)
  int get maxBattery =>
      throw _privateConstructorUsedError; // 100, 200, unlimited
  @HiveField(3)
  int get dailyScenes => throw _privateConstructorUsedError; // 1, 3, unlimited
  @HiveField(4)
  int get wordsPerScene => throw _privateConstructorUsedError; // 3, 5, 7
  @HiveField(5)
  bool get cloudSync => throw _privateConstructorUsedError;
  @HiveField(6)
  bool get exclusiveScenes => throw _privateConstructorUsedError;
  @HiveField(7)
  String get lightColor =>
      throw _privateConstructorUsedError; // White, Gold, Purple
  @HiveField(8)
  double get beamRadius => throw _privateConstructorUsedError; // 100, 150, 200
  @HiveField(9)
  bool get isActive => throw _privateConstructorUsedError;
  @HiveField(10)
  DateTime? get expiryDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubscriptionTierCopyWith<SubscriptionTier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionTierCopyWith<$Res> {
  factory $SubscriptionTierCopyWith(
          SubscriptionTier value, $Res Function(SubscriptionTier) then) =
      _$SubscriptionTierCopyWithImpl<$Res, SubscriptionTier>;
  @useResult
  $Res call(
      {@HiveField(0) String tierId,
      @HiveField(1) String name,
      @HiveField(2) int maxBattery,
      @HiveField(3) int dailyScenes,
      @HiveField(4) int wordsPerScene,
      @HiveField(5) bool cloudSync,
      @HiveField(6) bool exclusiveScenes,
      @HiveField(7) String lightColor,
      @HiveField(8) double beamRadius,
      @HiveField(9) bool isActive,
      @HiveField(10) DateTime? expiryDate});
}

/// @nodoc
class _$SubscriptionTierCopyWithImpl<$Res, $Val extends SubscriptionTier>
    implements $SubscriptionTierCopyWith<$Res> {
  _$SubscriptionTierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tierId = null,
    Object? name = null,
    Object? maxBattery = null,
    Object? dailyScenes = null,
    Object? wordsPerScene = null,
    Object? cloudSync = null,
    Object? exclusiveScenes = null,
    Object? lightColor = null,
    Object? beamRadius = null,
    Object? isActive = null,
    Object? expiryDate = freezed,
  }) {
    return _then(_value.copyWith(
      tierId: null == tierId
          ? _value.tierId
          : tierId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxBattery: null == maxBattery
          ? _value.maxBattery
          : maxBattery // ignore: cast_nullable_to_non_nullable
              as int,
      dailyScenes: null == dailyScenes
          ? _value.dailyScenes
          : dailyScenes // ignore: cast_nullable_to_non_nullable
              as int,
      wordsPerScene: null == wordsPerScene
          ? _value.wordsPerScene
          : wordsPerScene // ignore: cast_nullable_to_non_nullable
              as int,
      cloudSync: null == cloudSync
          ? _value.cloudSync
          : cloudSync // ignore: cast_nullable_to_non_nullable
              as bool,
      exclusiveScenes: null == exclusiveScenes
          ? _value.exclusiveScenes
          : exclusiveScenes // ignore: cast_nullable_to_non_nullable
              as bool,
      lightColor: null == lightColor
          ? _value.lightColor
          : lightColor // ignore: cast_nullable_to_non_nullable
              as String,
      beamRadius: null == beamRadius
          ? _value.beamRadius
          : beamRadius // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionTierImplCopyWith<$Res>
    implements $SubscriptionTierCopyWith<$Res> {
  factory _$$SubscriptionTierImplCopyWith(_$SubscriptionTierImpl value,
          $Res Function(_$SubscriptionTierImpl) then) =
      __$$SubscriptionTierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String tierId,
      @HiveField(1) String name,
      @HiveField(2) int maxBattery,
      @HiveField(3) int dailyScenes,
      @HiveField(4) int wordsPerScene,
      @HiveField(5) bool cloudSync,
      @HiveField(6) bool exclusiveScenes,
      @HiveField(7) String lightColor,
      @HiveField(8) double beamRadius,
      @HiveField(9) bool isActive,
      @HiveField(10) DateTime? expiryDate});
}

/// @nodoc
class __$$SubscriptionTierImplCopyWithImpl<$Res>
    extends _$SubscriptionTierCopyWithImpl<$Res, _$SubscriptionTierImpl>
    implements _$$SubscriptionTierImplCopyWith<$Res> {
  __$$SubscriptionTierImplCopyWithImpl(_$SubscriptionTierImpl _value,
      $Res Function(_$SubscriptionTierImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tierId = null,
    Object? name = null,
    Object? maxBattery = null,
    Object? dailyScenes = null,
    Object? wordsPerScene = null,
    Object? cloudSync = null,
    Object? exclusiveScenes = null,
    Object? lightColor = null,
    Object? beamRadius = null,
    Object? isActive = null,
    Object? expiryDate = freezed,
  }) {
    return _then(_$SubscriptionTierImpl(
      tierId: null == tierId
          ? _value.tierId
          : tierId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxBattery: null == maxBattery
          ? _value.maxBattery
          : maxBattery // ignore: cast_nullable_to_non_nullable
              as int,
      dailyScenes: null == dailyScenes
          ? _value.dailyScenes
          : dailyScenes // ignore: cast_nullable_to_non_nullable
              as int,
      wordsPerScene: null == wordsPerScene
          ? _value.wordsPerScene
          : wordsPerScene // ignore: cast_nullable_to_non_nullable
              as int,
      cloudSync: null == cloudSync
          ? _value.cloudSync
          : cloudSync // ignore: cast_nullable_to_non_nullable
              as bool,
      exclusiveScenes: null == exclusiveScenes
          ? _value.exclusiveScenes
          : exclusiveScenes // ignore: cast_nullable_to_non_nullable
              as bool,
      lightColor: null == lightColor
          ? _value.lightColor
          : lightColor // ignore: cast_nullable_to_non_nullable
              as String,
      beamRadius: null == beamRadius
          ? _value.beamRadius
          : beamRadius // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 4, adapterName: 'SubscriptionTierAdapter')
class _$SubscriptionTierImpl implements _SubscriptionTier {
  const _$SubscriptionTierImpl(
      {@HiveField(0) required this.tierId,
      @HiveField(1) required this.name,
      @HiveField(2) required this.maxBattery,
      @HiveField(3) required this.dailyScenes,
      @HiveField(4) required this.wordsPerScene,
      @HiveField(5) required this.cloudSync,
      @HiveField(6) required this.exclusiveScenes,
      @HiveField(7) required this.lightColor,
      @HiveField(8) required this.beamRadius,
      @HiveField(9) this.isActive = false,
      @HiveField(10) this.expiryDate});

  factory _$SubscriptionTierImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionTierImplFromJson(json);

  @override
  @HiveField(0)
  final String tierId;
// 'scout', 'illuminator', 'archivist'
  @override
  @HiveField(1)
  final String name;
// "Flashlight Battery: Standard"
  @override
  @HiveField(2)
  final int maxBattery;
// 100, 200, unlimited
  @override
  @HiveField(3)
  final int dailyScenes;
// 1, 3, unlimited
  @override
  @HiveField(4)
  final int wordsPerScene;
// 3, 5, 7
  @override
  @HiveField(5)
  final bool cloudSync;
  @override
  @HiveField(6)
  final bool exclusiveScenes;
  @override
  @HiveField(7)
  final String lightColor;
// White, Gold, Purple
  @override
  @HiveField(8)
  final double beamRadius;
// 100, 150, 200
  @override
  @JsonKey()
  @HiveField(9)
  final bool isActive;
  @override
  @HiveField(10)
  final DateTime? expiryDate;

  @override
  String toString() {
    return 'SubscriptionTier(tierId: $tierId, name: $name, maxBattery: $maxBattery, dailyScenes: $dailyScenes, wordsPerScene: $wordsPerScene, cloudSync: $cloudSync, exclusiveScenes: $exclusiveScenes, lightColor: $lightColor, beamRadius: $beamRadius, isActive: $isActive, expiryDate: $expiryDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionTierImpl &&
            (identical(other.tierId, tierId) || other.tierId == tierId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.maxBattery, maxBattery) ||
                other.maxBattery == maxBattery) &&
            (identical(other.dailyScenes, dailyScenes) ||
                other.dailyScenes == dailyScenes) &&
            (identical(other.wordsPerScene, wordsPerScene) ||
                other.wordsPerScene == wordsPerScene) &&
            (identical(other.cloudSync, cloudSync) ||
                other.cloudSync == cloudSync) &&
            (identical(other.exclusiveScenes, exclusiveScenes) ||
                other.exclusiveScenes == exclusiveScenes) &&
            (identical(other.lightColor, lightColor) ||
                other.lightColor == lightColor) &&
            (identical(other.beamRadius, beamRadius) ||
                other.beamRadius == beamRadius) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      tierId,
      name,
      maxBattery,
      dailyScenes,
      wordsPerScene,
      cloudSync,
      exclusiveScenes,
      lightColor,
      beamRadius,
      isActive,
      expiryDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionTierImplCopyWith<_$SubscriptionTierImpl> get copyWith =>
      __$$SubscriptionTierImplCopyWithImpl<_$SubscriptionTierImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionTierImplToJson(
      this,
    );
  }
}

abstract class _SubscriptionTier implements SubscriptionTier {
  const factory _SubscriptionTier(
      {@HiveField(0) required final String tierId,
      @HiveField(1) required final String name,
      @HiveField(2) required final int maxBattery,
      @HiveField(3) required final int dailyScenes,
      @HiveField(4) required final int wordsPerScene,
      @HiveField(5) required final bool cloudSync,
      @HiveField(6) required final bool exclusiveScenes,
      @HiveField(7) required final String lightColor,
      @HiveField(8) required final double beamRadius,
      @HiveField(9) final bool isActive,
      @HiveField(10) final DateTime? expiryDate}) = _$SubscriptionTierImpl;

  factory _SubscriptionTier.fromJson(Map<String, dynamic> json) =
      _$SubscriptionTierImpl.fromJson;

  @override
  @HiveField(0)
  String get tierId;
  @override // 'scout', 'illuminator', 'archivist'
  @HiveField(1)
  String get name;
  @override // "Flashlight Battery: Standard"
  @HiveField(2)
  int get maxBattery;
  @override // 100, 200, unlimited
  @HiveField(3)
  int get dailyScenes;
  @override // 1, 3, unlimited
  @HiveField(4)
  int get wordsPerScene;
  @override // 3, 5, 7
  @HiveField(5)
  bool get cloudSync;
  @override
  @HiveField(6)
  bool get exclusiveScenes;
  @override
  @HiveField(7)
  String get lightColor;
  @override // White, Gold, Purple
  @HiveField(8)
  double get beamRadius;
  @override // 100, 150, 200
  @HiveField(9)
  bool get isActive;
  @override
  @HiveField(10)
  DateTime? get expiryDate;
  @override
  @JsonKey(ignore: true)
  _$$SubscriptionTierImplCopyWith<_$SubscriptionTierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
