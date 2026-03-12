// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scene_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Scene _$SceneFromJson(Map<String, dynamic> json) {
  return _Scene.fromJson(json);
}

/// @nodoc
mixin _$Scene {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get imageAsset =>
      throw _privateConstructorUsedError; // Local path or URL
  @HiveField(2)
  String get thumbnailAsset => throw _privateConstructorUsedError;
  @HiveField(3)
  List<Word> get words => throw _privateConstructorUsedError;
  @HiveField(4)
  String get category => throw _privateConstructorUsedError;
  @HiveField(5)
  String get languageCode => throw _privateConstructorUsedError;
  @HiveField(6)
  String get title => throw _privateConstructorUsedError;
  @HiveField(7)
  String get description =>
      throw _privateConstructorUsedError; // "The Market at Dawn"
  @HiveField(8)
  bool get isCompleted => throw _privateConstructorUsedError;
  @HiveField(9)
  int get difficulty =>
      throw _privateConstructorUsedError; // 1-5 (affects word hiding depth)
  @HiveField(10)
  String? get ambientAudioAsset => throw _privateConstructorUsedError;
  @HiveField(11)
  DateTime? get completedAt => throw _privateConstructorUsedError;
  @HiveField(12)
  bool get isPremium => throw _privateConstructorUsedError; // Legendary scenes
  @HiveField(13)
  bool get isUnlocked => throw _privateConstructorUsedError;
  @HiveField(14)
  String? get requiredTier => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SceneCopyWith<Scene> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SceneCopyWith<$Res> {
  factory $SceneCopyWith(Scene value, $Res Function(Scene) then) =
      _$SceneCopyWithImpl<$Res, Scene>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String imageAsset,
      @HiveField(2) String thumbnailAsset,
      @HiveField(3) List<Word> words,
      @HiveField(4) String category,
      @HiveField(5) String languageCode,
      @HiveField(6) String title,
      @HiveField(7) String description,
      @HiveField(8) bool isCompleted,
      @HiveField(9) int difficulty,
      @HiveField(10) String? ambientAudioAsset,
      @HiveField(11) DateTime? completedAt,
      @HiveField(12) bool isPremium,
      @HiveField(13) bool isUnlocked,
      @HiveField(14) String? requiredTier});
}

/// @nodoc
class _$SceneCopyWithImpl<$Res, $Val extends Scene>
    implements $SceneCopyWith<$Res> {
  _$SceneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageAsset = null,
    Object? thumbnailAsset = null,
    Object? words = null,
    Object? category = null,
    Object? languageCode = null,
    Object? title = null,
    Object? description = null,
    Object? isCompleted = null,
    Object? difficulty = null,
    Object? ambientAudioAsset = freezed,
    Object? completedAt = freezed,
    Object? isPremium = null,
    Object? isUnlocked = null,
    Object? requiredTier = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageAsset: null == imageAsset
          ? _value.imageAsset
          : imageAsset // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailAsset: null == thumbnailAsset
          ? _value.thumbnailAsset
          : thumbnailAsset // ignore: cast_nullable_to_non_nullable
              as String,
      words: null == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as List<Word>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as int,
      ambientAudioAsset: freezed == ambientAudioAsset
          ? _value.ambientAudioAsset
          : ambientAudioAsset // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      requiredTier: freezed == requiredTier
          ? _value.requiredTier
          : requiredTier // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SceneImplCopyWith<$Res> implements $SceneCopyWith<$Res> {
  factory _$$SceneImplCopyWith(
          _$SceneImpl value, $Res Function(_$SceneImpl) then) =
      __$$SceneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String imageAsset,
      @HiveField(2) String thumbnailAsset,
      @HiveField(3) List<Word> words,
      @HiveField(4) String category,
      @HiveField(5) String languageCode,
      @HiveField(6) String title,
      @HiveField(7) String description,
      @HiveField(8) bool isCompleted,
      @HiveField(9) int difficulty,
      @HiveField(10) String? ambientAudioAsset,
      @HiveField(11) DateTime? completedAt,
      @HiveField(12) bool isPremium,
      @HiveField(13) bool isUnlocked,
      @HiveField(14) String? requiredTier});
}

/// @nodoc
class __$$SceneImplCopyWithImpl<$Res>
    extends _$SceneCopyWithImpl<$Res, _$SceneImpl>
    implements _$$SceneImplCopyWith<$Res> {
  __$$SceneImplCopyWithImpl(
      _$SceneImpl _value, $Res Function(_$SceneImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageAsset = null,
    Object? thumbnailAsset = null,
    Object? words = null,
    Object? category = null,
    Object? languageCode = null,
    Object? title = null,
    Object? description = null,
    Object? isCompleted = null,
    Object? difficulty = null,
    Object? ambientAudioAsset = freezed,
    Object? completedAt = freezed,
    Object? isPremium = null,
    Object? isUnlocked = null,
    Object? requiredTier = freezed,
  }) {
    return _then(_$SceneImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageAsset: null == imageAsset
          ? _value.imageAsset
          : imageAsset // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailAsset: null == thumbnailAsset
          ? _value.thumbnailAsset
          : thumbnailAsset // ignore: cast_nullable_to_non_nullable
              as String,
      words: null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<Word>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as int,
      ambientAudioAsset: freezed == ambientAudioAsset
          ? _value.ambientAudioAsset
          : ambientAudioAsset // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      requiredTier: freezed == requiredTier
          ? _value.requiredTier
          : requiredTier // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 0, adapterName: 'SceneAdapter')
class _$SceneImpl extends _Scene {
  const _$SceneImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.imageAsset,
      @HiveField(2) required this.thumbnailAsset,
      @HiveField(3) required final List<Word> words,
      @HiveField(4) required this.category,
      @HiveField(5) required this.languageCode,
      @HiveField(6) required this.title,
      @HiveField(7) required this.description,
      @HiveField(8) this.isCompleted = false,
      @HiveField(9) this.difficulty = 1,
      @HiveField(10) this.ambientAudioAsset,
      @HiveField(11) this.completedAt,
      @HiveField(12) this.isPremium = false,
      @HiveField(13) this.isUnlocked = false,
      @HiveField(14) this.requiredTier})
      : _words = words,
        super._();

  factory _$SceneImpl.fromJson(Map<String, dynamic> json) =>
      _$$SceneImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String imageAsset;
// Local path or URL
  @override
  @HiveField(2)
  final String thumbnailAsset;
  final List<Word> _words;
  @override
  @HiveField(3)
  List<Word> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  @override
  @HiveField(4)
  final String category;
  @override
  @HiveField(5)
  final String languageCode;
  @override
  @HiveField(6)
  final String title;
  @override
  @HiveField(7)
  final String description;
// "The Market at Dawn"
  @override
  @JsonKey()
  @HiveField(8)
  final bool isCompleted;
  @override
  @JsonKey()
  @HiveField(9)
  final int difficulty;
// 1-5 (affects word hiding depth)
  @override
  @HiveField(10)
  final String? ambientAudioAsset;
  @override
  @HiveField(11)
  final DateTime? completedAt;
  @override
  @JsonKey()
  @HiveField(12)
  final bool isPremium;
// Legendary scenes
  @override
  @JsonKey()
  @HiveField(13)
  final bool isUnlocked;
  @override
  @HiveField(14)
  final String? requiredTier;

  @override
  String toString() {
    return 'Scene(id: $id, imageAsset: $imageAsset, thumbnailAsset: $thumbnailAsset, words: $words, category: $category, languageCode: $languageCode, title: $title, description: $description, isCompleted: $isCompleted, difficulty: $difficulty, ambientAudioAsset: $ambientAudioAsset, completedAt: $completedAt, isPremium: $isPremium, isUnlocked: $isUnlocked, requiredTier: $requiredTier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SceneImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageAsset, imageAsset) ||
                other.imageAsset == imageAsset) &&
            (identical(other.thumbnailAsset, thumbnailAsset) ||
                other.thumbnailAsset == thumbnailAsset) &&
            const DeepCollectionEquality().equals(other._words, _words) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.ambientAudioAsset, ambientAudioAsset) ||
                other.ambientAudioAsset == ambientAudioAsset) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked) &&
            (identical(other.requiredTier, requiredTier) ||
                other.requiredTier == requiredTier));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      imageAsset,
      thumbnailAsset,
      const DeepCollectionEquality().hash(_words),
      category,
      languageCode,
      title,
      description,
      isCompleted,
      difficulty,
      ambientAudioAsset,
      completedAt,
      isPremium,
      isUnlocked,
      requiredTier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SceneImplCopyWith<_$SceneImpl> get copyWith =>
      __$$SceneImplCopyWithImpl<_$SceneImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SceneImplToJson(
      this,
    );
  }
}

abstract class _Scene extends Scene {
  const factory _Scene(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String imageAsset,
      @HiveField(2) required final String thumbnailAsset,
      @HiveField(3) required final List<Word> words,
      @HiveField(4) required final String category,
      @HiveField(5) required final String languageCode,
      @HiveField(6) required final String title,
      @HiveField(7) required final String description,
      @HiveField(8) final bool isCompleted,
      @HiveField(9) final int difficulty,
      @HiveField(10) final String? ambientAudioAsset,
      @HiveField(11) final DateTime? completedAt,
      @HiveField(12) final bool isPremium,
      @HiveField(13) final bool isUnlocked,
      @HiveField(14) final String? requiredTier}) = _$SceneImpl;
  const _Scene._() : super._();

  factory _Scene.fromJson(Map<String, dynamic> json) = _$SceneImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get imageAsset;
  @override // Local path or URL
  @HiveField(2)
  String get thumbnailAsset;
  @override
  @HiveField(3)
  List<Word> get words;
  @override
  @HiveField(4)
  String get category;
  @override
  @HiveField(5)
  String get languageCode;
  @override
  @HiveField(6)
  String get title;
  @override
  @HiveField(7)
  String get description;
  @override // "The Market at Dawn"
  @HiveField(8)
  bool get isCompleted;
  @override
  @HiveField(9)
  int get difficulty;
  @override // 1-5 (affects word hiding depth)
  @HiveField(10)
  String? get ambientAudioAsset;
  @override
  @HiveField(11)
  DateTime? get completedAt;
  @override
  @HiveField(12)
  bool get isPremium;
  @override // Legendary scenes
  @HiveField(13)
  bool get isUnlocked;
  @override
  @HiveField(14)
  String? get requiredTier;
  @override
  @JsonKey(ignore: true)
  _$$SceneImplCopyWith<_$SceneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
