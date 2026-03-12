// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_progress_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProgress _$UserProgressFromJson(Map<String, dynamic> json) {
  return _UserProgress.fromJson(json);
}

/// @nodoc
mixin _$UserProgress {
  @HiveField(0)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(1)
  String get sourceLanguageCode => throw _privateConstructorUsedError;
  @HiveField(2)
  String get targetLanguageCode => throw _privateConstructorUsedError;
  @HiveField(3)
  double get currentBattery => throw _privateConstructorUsedError;
  @HiveField(4)
  int get currentStreak => throw _privateConstructorUsedError;
  @HiveField(5)
  int get totalWordsIlluminated => throw _privateConstructorUsedError;
  @HiveField(6)
  int get totalScenesCompleted => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime? get lastSessionDate => throw _privateConstructorUsedError;
  @HiveField(8)
  DateTime? get streakLastDate => throw _privateConstructorUsedError;
  @HiveField(9)
  int get dailyScenesCompleted => throw _privateConstructorUsedError;
  @HiveField(10)
  DateTime? get lastResetDate => throw _privateConstructorUsedError;
  @HiveField(11)
  SubscriptionTier? get subscription => throw _privateConstructorUsedError;
  @HiveField(12)
  List<String> get unlockedLanguages => throw _privateConstructorUsedError;
  @HiveField(13)
  int get totalTimeSeconds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProgressCopyWith<UserProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProgressCopyWith<$Res> {
  factory $UserProgressCopyWith(
          UserProgress value, $Res Function(UserProgress) then) =
      _$UserProgressCopyWithImpl<$Res, UserProgress>;
  @useResult
  $Res call(
      {@HiveField(0) String userId,
      @HiveField(1) String sourceLanguageCode,
      @HiveField(2) String targetLanguageCode,
      @HiveField(3) double currentBattery,
      @HiveField(4) int currentStreak,
      @HiveField(5) int totalWordsIlluminated,
      @HiveField(6) int totalScenesCompleted,
      @HiveField(7) DateTime? lastSessionDate,
      @HiveField(8) DateTime? streakLastDate,
      @HiveField(9) int dailyScenesCompleted,
      @HiveField(10) DateTime? lastResetDate,
      @HiveField(11) SubscriptionTier? subscription,
      @HiveField(12) List<String> unlockedLanguages,
      @HiveField(13) int totalTimeSeconds});

  $SubscriptionTierCopyWith<$Res>? get subscription;
}

/// @nodoc
class _$UserProgressCopyWithImpl<$Res, $Val extends UserProgress>
    implements $UserProgressCopyWith<$Res> {
  _$UserProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? sourceLanguageCode = null,
    Object? targetLanguageCode = null,
    Object? currentBattery = null,
    Object? currentStreak = null,
    Object? totalWordsIlluminated = null,
    Object? totalScenesCompleted = null,
    Object? lastSessionDate = freezed,
    Object? streakLastDate = freezed,
    Object? dailyScenesCompleted = null,
    Object? lastResetDate = freezed,
    Object? subscription = freezed,
    Object? unlockedLanguages = null,
    Object? totalTimeSeconds = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      sourceLanguageCode: null == sourceLanguageCode
          ? _value.sourceLanguageCode
          : sourceLanguageCode // ignore: cast_nullable_to_non_nullable
              as String,
      targetLanguageCode: null == targetLanguageCode
          ? _value.targetLanguageCode
          : targetLanguageCode // ignore: cast_nullable_to_non_nullable
              as String,
      currentBattery: null == currentBattery
          ? _value.currentBattery
          : currentBattery // ignore: cast_nullable_to_non_nullable
              as double,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalWordsIlluminated: null == totalWordsIlluminated
          ? _value.totalWordsIlluminated
          : totalWordsIlluminated // ignore: cast_nullable_to_non_nullable
              as int,
      totalScenesCompleted: null == totalScenesCompleted
          ? _value.totalScenesCompleted
          : totalScenesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      lastSessionDate: freezed == lastSessionDate
          ? _value.lastSessionDate
          : lastSessionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      streakLastDate: freezed == streakLastDate
          ? _value.streakLastDate
          : streakLastDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dailyScenesCompleted: null == dailyScenesCompleted
          ? _value.dailyScenesCompleted
          : dailyScenesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      lastResetDate: freezed == lastResetDate
          ? _value.lastResetDate
          : lastResetDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subscription: freezed == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier?,
      unlockedLanguages: null == unlockedLanguages
          ? _value.unlockedLanguages
          : unlockedLanguages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalTimeSeconds: null == totalTimeSeconds
          ? _value.totalTimeSeconds
          : totalTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SubscriptionTierCopyWith<$Res>? get subscription {
    if (_value.subscription == null) {
      return null;
    }

    return $SubscriptionTierCopyWith<$Res>(_value.subscription!, (value) {
      return _then(_value.copyWith(subscription: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProgressImplCopyWith<$Res>
    implements $UserProgressCopyWith<$Res> {
  factory _$$UserProgressImplCopyWith(
          _$UserProgressImpl value, $Res Function(_$UserProgressImpl) then) =
      __$$UserProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String userId,
      @HiveField(1) String sourceLanguageCode,
      @HiveField(2) String targetLanguageCode,
      @HiveField(3) double currentBattery,
      @HiveField(4) int currentStreak,
      @HiveField(5) int totalWordsIlluminated,
      @HiveField(6) int totalScenesCompleted,
      @HiveField(7) DateTime? lastSessionDate,
      @HiveField(8) DateTime? streakLastDate,
      @HiveField(9) int dailyScenesCompleted,
      @HiveField(10) DateTime? lastResetDate,
      @HiveField(11) SubscriptionTier? subscription,
      @HiveField(12) List<String> unlockedLanguages,
      @HiveField(13) int totalTimeSeconds});

  @override
  $SubscriptionTierCopyWith<$Res>? get subscription;
}

/// @nodoc
class __$$UserProgressImplCopyWithImpl<$Res>
    extends _$UserProgressCopyWithImpl<$Res, _$UserProgressImpl>
    implements _$$UserProgressImplCopyWith<$Res> {
  __$$UserProgressImplCopyWithImpl(
      _$UserProgressImpl _value, $Res Function(_$UserProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? sourceLanguageCode = null,
    Object? targetLanguageCode = null,
    Object? currentBattery = null,
    Object? currentStreak = null,
    Object? totalWordsIlluminated = null,
    Object? totalScenesCompleted = null,
    Object? lastSessionDate = freezed,
    Object? streakLastDate = freezed,
    Object? dailyScenesCompleted = null,
    Object? lastResetDate = freezed,
    Object? subscription = freezed,
    Object? unlockedLanguages = null,
    Object? totalTimeSeconds = null,
  }) {
    return _then(_$UserProgressImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      sourceLanguageCode: null == sourceLanguageCode
          ? _value.sourceLanguageCode
          : sourceLanguageCode // ignore: cast_nullable_to_non_nullable
              as String,
      targetLanguageCode: null == targetLanguageCode
          ? _value.targetLanguageCode
          : targetLanguageCode // ignore: cast_nullable_to_non_nullable
              as String,
      currentBattery: null == currentBattery
          ? _value.currentBattery
          : currentBattery // ignore: cast_nullable_to_non_nullable
              as double,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalWordsIlluminated: null == totalWordsIlluminated
          ? _value.totalWordsIlluminated
          : totalWordsIlluminated // ignore: cast_nullable_to_non_nullable
              as int,
      totalScenesCompleted: null == totalScenesCompleted
          ? _value.totalScenesCompleted
          : totalScenesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      lastSessionDate: freezed == lastSessionDate
          ? _value.lastSessionDate
          : lastSessionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      streakLastDate: freezed == streakLastDate
          ? _value.streakLastDate
          : streakLastDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dailyScenesCompleted: null == dailyScenesCompleted
          ? _value.dailyScenesCompleted
          : dailyScenesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      lastResetDate: freezed == lastResetDate
          ? _value.lastResetDate
          : lastResetDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subscription: freezed == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier?,
      unlockedLanguages: null == unlockedLanguages
          ? _value._unlockedLanguages
          : unlockedLanguages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalTimeSeconds: null == totalTimeSeconds
          ? _value.totalTimeSeconds
          : totalTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 2, adapterName: 'UserProgressAdapter')
class _$UserProgressImpl implements _UserProgress {
  const _$UserProgressImpl(
      {@HiveField(0) required this.userId,
      @HiveField(1) this.sourceLanguageCode = 'en-US',
      @HiveField(2) this.targetLanguageCode = 'rw',
      @HiveField(3) this.currentBattery = 100.0,
      @HiveField(4) this.currentStreak = 0,
      @HiveField(5) this.totalWordsIlluminated = 0,
      @HiveField(6) this.totalScenesCompleted = 0,
      @HiveField(7) this.lastSessionDate,
      @HiveField(8) this.streakLastDate,
      @HiveField(9) this.dailyScenesCompleted = 0,
      @HiveField(10) this.lastResetDate,
      @HiveField(11) this.subscription,
      @HiveField(12)
      final List<String> unlockedLanguages = const ['en-US', 'rw'],
      @HiveField(13) this.totalTimeSeconds = 0})
      : _unlockedLanguages = unlockedLanguages;

  factory _$UserProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProgressImplFromJson(json);

  @override
  @HiveField(0)
  final String userId;
  @override
  @JsonKey()
  @HiveField(1)
  final String sourceLanguageCode;
  @override
  @JsonKey()
  @HiveField(2)
  final String targetLanguageCode;
  @override
  @JsonKey()
  @HiveField(3)
  final double currentBattery;
  @override
  @JsonKey()
  @HiveField(4)
  final int currentStreak;
  @override
  @JsonKey()
  @HiveField(5)
  final int totalWordsIlluminated;
  @override
  @JsonKey()
  @HiveField(6)
  final int totalScenesCompleted;
  @override
  @HiveField(7)
  final DateTime? lastSessionDate;
  @override
  @HiveField(8)
  final DateTime? streakLastDate;
  @override
  @JsonKey()
  @HiveField(9)
  final int dailyScenesCompleted;
  @override
  @HiveField(10)
  final DateTime? lastResetDate;
  @override
  @HiveField(11)
  final SubscriptionTier? subscription;
  final List<String> _unlockedLanguages;
  @override
  @JsonKey()
  @HiveField(12)
  List<String> get unlockedLanguages {
    if (_unlockedLanguages is EqualUnmodifiableListView)
      return _unlockedLanguages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unlockedLanguages);
  }

  @override
  @JsonKey()
  @HiveField(13)
  final int totalTimeSeconds;

  @override
  String toString() {
    return 'UserProgress(userId: $userId, sourceLanguageCode: $sourceLanguageCode, targetLanguageCode: $targetLanguageCode, currentBattery: $currentBattery, currentStreak: $currentStreak, totalWordsIlluminated: $totalWordsIlluminated, totalScenesCompleted: $totalScenesCompleted, lastSessionDate: $lastSessionDate, streakLastDate: $streakLastDate, dailyScenesCompleted: $dailyScenesCompleted, lastResetDate: $lastResetDate, subscription: $subscription, unlockedLanguages: $unlockedLanguages, totalTimeSeconds: $totalTimeSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProgressImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.sourceLanguageCode, sourceLanguageCode) ||
                other.sourceLanguageCode == sourceLanguageCode) &&
            (identical(other.targetLanguageCode, targetLanguageCode) ||
                other.targetLanguageCode == targetLanguageCode) &&
            (identical(other.currentBattery, currentBattery) ||
                other.currentBattery == currentBattery) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.totalWordsIlluminated, totalWordsIlluminated) ||
                other.totalWordsIlluminated == totalWordsIlluminated) &&
            (identical(other.totalScenesCompleted, totalScenesCompleted) ||
                other.totalScenesCompleted == totalScenesCompleted) &&
            (identical(other.lastSessionDate, lastSessionDate) ||
                other.lastSessionDate == lastSessionDate) &&
            (identical(other.streakLastDate, streakLastDate) ||
                other.streakLastDate == streakLastDate) &&
            (identical(other.dailyScenesCompleted, dailyScenesCompleted) ||
                other.dailyScenesCompleted == dailyScenesCompleted) &&
            (identical(other.lastResetDate, lastResetDate) ||
                other.lastResetDate == lastResetDate) &&
            (identical(other.subscription, subscription) ||
                other.subscription == subscription) &&
            const DeepCollectionEquality()
                .equals(other._unlockedLanguages, _unlockedLanguages) &&
            (identical(other.totalTimeSeconds, totalTimeSeconds) ||
                other.totalTimeSeconds == totalTimeSeconds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      sourceLanguageCode,
      targetLanguageCode,
      currentBattery,
      currentStreak,
      totalWordsIlluminated,
      totalScenesCompleted,
      lastSessionDate,
      streakLastDate,
      dailyScenesCompleted,
      lastResetDate,
      subscription,
      const DeepCollectionEquality().hash(_unlockedLanguages),
      totalTimeSeconds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProgressImplCopyWith<_$UserProgressImpl> get copyWith =>
      __$$UserProgressImplCopyWithImpl<_$UserProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProgressImplToJson(
      this,
    );
  }
}

abstract class _UserProgress implements UserProgress {
  const factory _UserProgress(
      {@HiveField(0) required final String userId,
      @HiveField(1) final String sourceLanguageCode,
      @HiveField(2) final String targetLanguageCode,
      @HiveField(3) final double currentBattery,
      @HiveField(4) final int currentStreak,
      @HiveField(5) final int totalWordsIlluminated,
      @HiveField(6) final int totalScenesCompleted,
      @HiveField(7) final DateTime? lastSessionDate,
      @HiveField(8) final DateTime? streakLastDate,
      @HiveField(9) final int dailyScenesCompleted,
      @HiveField(10) final DateTime? lastResetDate,
      @HiveField(11) final SubscriptionTier? subscription,
      @HiveField(12) final List<String> unlockedLanguages,
      @HiveField(13) final int totalTimeSeconds}) = _$UserProgressImpl;

  factory _UserProgress.fromJson(Map<String, dynamic> json) =
      _$UserProgressImpl.fromJson;

  @override
  @HiveField(0)
  String get userId;
  @override
  @HiveField(1)
  String get sourceLanguageCode;
  @override
  @HiveField(2)
  String get targetLanguageCode;
  @override
  @HiveField(3)
  double get currentBattery;
  @override
  @HiveField(4)
  int get currentStreak;
  @override
  @HiveField(5)
  int get totalWordsIlluminated;
  @override
  @HiveField(6)
  int get totalScenesCompleted;
  @override
  @HiveField(7)
  DateTime? get lastSessionDate;
  @override
  @HiveField(8)
  DateTime? get streakLastDate;
  @override
  @HiveField(9)
  int get dailyScenesCompleted;
  @override
  @HiveField(10)
  DateTime? get lastResetDate;
  @override
  @HiveField(11)
  SubscriptionTier? get subscription;
  @override
  @HiveField(12)
  List<String> get unlockedLanguages;
  @override
  @HiveField(13)
  int get totalTimeSeconds;
  @override
  @JsonKey(ignore: true)
  _$$UserProgressImplCopyWith<_$UserProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IlluminationRecord _$IlluminationRecordFromJson(Map<String, dynamic> json) {
  return _IlluminationRecord.fromJson(json);
}

/// @nodoc
mixin _$IlluminationRecord {
  @HiveField(0)
  String get wordId => throw _privateConstructorUsedError;
  @HiveField(1)
  DateTime get illuminatedAt => throw _privateConstructorUsedError;
  @HiveField(2)
  String get sceneId => throw _privateConstructorUsedError;
  @HiveField(3)
  int get timeToFindSeconds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IlluminationRecordCopyWith<IlluminationRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IlluminationRecordCopyWith<$Res> {
  factory $IlluminationRecordCopyWith(
          IlluminationRecord value, $Res Function(IlluminationRecord) then) =
      _$IlluminationRecordCopyWithImpl<$Res, IlluminationRecord>;
  @useResult
  $Res call(
      {@HiveField(0) String wordId,
      @HiveField(1) DateTime illuminatedAt,
      @HiveField(2) String sceneId,
      @HiveField(3) int timeToFindSeconds});
}

/// @nodoc
class _$IlluminationRecordCopyWithImpl<$Res, $Val extends IlluminationRecord>
    implements $IlluminationRecordCopyWith<$Res> {
  _$IlluminationRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? illuminatedAt = null,
    Object? sceneId = null,
    Object? timeToFindSeconds = null,
  }) {
    return _then(_value.copyWith(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as String,
      illuminatedAt: null == illuminatedAt
          ? _value.illuminatedAt
          : illuminatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sceneId: null == sceneId
          ? _value.sceneId
          : sceneId // ignore: cast_nullable_to_non_nullable
              as String,
      timeToFindSeconds: null == timeToFindSeconds
          ? _value.timeToFindSeconds
          : timeToFindSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IlluminationRecordImplCopyWith<$Res>
    implements $IlluminationRecordCopyWith<$Res> {
  factory _$$IlluminationRecordImplCopyWith(_$IlluminationRecordImpl value,
          $Res Function(_$IlluminationRecordImpl) then) =
      __$$IlluminationRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String wordId,
      @HiveField(1) DateTime illuminatedAt,
      @HiveField(2) String sceneId,
      @HiveField(3) int timeToFindSeconds});
}

/// @nodoc
class __$$IlluminationRecordImplCopyWithImpl<$Res>
    extends _$IlluminationRecordCopyWithImpl<$Res, _$IlluminationRecordImpl>
    implements _$$IlluminationRecordImplCopyWith<$Res> {
  __$$IlluminationRecordImplCopyWithImpl(_$IlluminationRecordImpl _value,
      $Res Function(_$IlluminationRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? illuminatedAt = null,
    Object? sceneId = null,
    Object? timeToFindSeconds = null,
  }) {
    return _then(_$IlluminationRecordImpl(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as String,
      illuminatedAt: null == illuminatedAt
          ? _value.illuminatedAt
          : illuminatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sceneId: null == sceneId
          ? _value.sceneId
          : sceneId // ignore: cast_nullable_to_non_nullable
              as String,
      timeToFindSeconds: null == timeToFindSeconds
          ? _value.timeToFindSeconds
          : timeToFindSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 3, adapterName: 'IlluminationRecordAdapter')
class _$IlluminationRecordImpl implements _IlluminationRecord {
  const _$IlluminationRecordImpl(
      {@HiveField(0) required this.wordId,
      @HiveField(1) required this.illuminatedAt,
      @HiveField(2) required this.sceneId,
      @HiveField(3) required this.timeToFindSeconds});

  factory _$IlluminationRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$IlluminationRecordImplFromJson(json);

  @override
  @HiveField(0)
  final String wordId;
  @override
  @HiveField(1)
  final DateTime illuminatedAt;
  @override
  @HiveField(2)
  final String sceneId;
  @override
  @HiveField(3)
  final int timeToFindSeconds;

  @override
  String toString() {
    return 'IlluminationRecord(wordId: $wordId, illuminatedAt: $illuminatedAt, sceneId: $sceneId, timeToFindSeconds: $timeToFindSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IlluminationRecordImpl &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.illuminatedAt, illuminatedAt) ||
                other.illuminatedAt == illuminatedAt) &&
            (identical(other.sceneId, sceneId) || other.sceneId == sceneId) &&
            (identical(other.timeToFindSeconds, timeToFindSeconds) ||
                other.timeToFindSeconds == timeToFindSeconds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, wordId, illuminatedAt, sceneId, timeToFindSeconds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IlluminationRecordImplCopyWith<_$IlluminationRecordImpl> get copyWith =>
      __$$IlluminationRecordImplCopyWithImpl<_$IlluminationRecordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IlluminationRecordImplToJson(
      this,
    );
  }
}

abstract class _IlluminationRecord implements IlluminationRecord {
  const factory _IlluminationRecord(
          {@HiveField(0) required final String wordId,
          @HiveField(1) required final DateTime illuminatedAt,
          @HiveField(2) required final String sceneId,
          @HiveField(3) required final int timeToFindSeconds}) =
      _$IlluminationRecordImpl;

  factory _IlluminationRecord.fromJson(Map<String, dynamic> json) =
      _$IlluminationRecordImpl.fromJson;

  @override
  @HiveField(0)
  String get wordId;
  @override
  @HiveField(1)
  DateTime get illuminatedAt;
  @override
  @HiveField(2)
  String get sceneId;
  @override
  @HiveField(3)
  int get timeToFindSeconds;
  @override
  @JsonKey(ignore: true)
  _$$IlluminationRecordImplCopyWith<_$IlluminationRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
