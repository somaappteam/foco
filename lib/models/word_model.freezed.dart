// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Word _$WordFromJson(Map<String, dynamic> json) {
  return _Word.fromJson(json);
}

/// @nodoc
mixin _$Word {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get text => throw _privateConstructorUsedError; // Local script
  @HiveField(2)
  String get transliteration =>
      throw _privateConstructorUsedError; // Romanization if needed
  @HiveField(3)
  String get translation => throw _privateConstructorUsedError;
  @HiveField(4)
  String get languageCode => throw _privateConstructorUsedError;
  @HiveField(5)
  double get positionX =>
      throw _privateConstructorUsedError; // 0.0 to 1.0 (normalized)
  @HiveField(6)
  double get positionY => throw _privateConstructorUsedError;
  @HiveField(7)
  String get category =>
      throw _privateConstructorUsedError; // survival, food, people, nature, abstract
  @HiveField(8)
  bool get isDiscovered => throw _privateConstructorUsedError;
  @HiveField(9)
  DateTime? get discoveredAt => throw _privateConstructorUsedError;
  @HiveField(10)
  int get illuminationStrength =>
      throw _privateConstructorUsedError; // 100 = bright, 0 = faded
  @HiveField(11)
  String? get audioAsset => throw _privateConstructorUsedError;
  @HiveField(12)
  bool get isPremiumOnly => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WordCopyWith<Word> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordCopyWith<$Res> {
  factory $WordCopyWith(Word value, $Res Function(Word) then) =
      _$WordCopyWithImpl<$Res, Word>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String text,
      @HiveField(2) String transliteration,
      @HiveField(3) String translation,
      @HiveField(4) String languageCode,
      @HiveField(5) double positionX,
      @HiveField(6) double positionY,
      @HiveField(7) String category,
      @HiveField(8) bool isDiscovered,
      @HiveField(9) DateTime? discoveredAt,
      @HiveField(10) int illuminationStrength,
      @HiveField(11) String? audioAsset,
      @HiveField(12) bool isPremiumOnly});
}

/// @nodoc
class _$WordCopyWithImpl<$Res, $Val extends Word>
    implements $WordCopyWith<$Res> {
  _$WordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? transliteration = null,
    Object? translation = null,
    Object? languageCode = null,
    Object? positionX = null,
    Object? positionY = null,
    Object? category = null,
    Object? isDiscovered = null,
    Object? discoveredAt = freezed,
    Object? illuminationStrength = null,
    Object? audioAsset = freezed,
    Object? isPremiumOnly = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      transliteration: null == transliteration
          ? _value.transliteration
          : transliteration // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      positionX: null == positionX
          ? _value.positionX
          : positionX // ignore: cast_nullable_to_non_nullable
              as double,
      positionY: null == positionY
          ? _value.positionY
          : positionY // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      isDiscovered: null == isDiscovered
          ? _value.isDiscovered
          : isDiscovered // ignore: cast_nullable_to_non_nullable
              as bool,
      discoveredAt: freezed == discoveredAt
          ? _value.discoveredAt
          : discoveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      illuminationStrength: null == illuminationStrength
          ? _value.illuminationStrength
          : illuminationStrength // ignore: cast_nullable_to_non_nullable
              as int,
      audioAsset: freezed == audioAsset
          ? _value.audioAsset
          : audioAsset // ignore: cast_nullable_to_non_nullable
              as String?,
      isPremiumOnly: null == isPremiumOnly
          ? _value.isPremiumOnly
          : isPremiumOnly // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WordImplCopyWith<$Res> implements $WordCopyWith<$Res> {
  factory _$$WordImplCopyWith(
          _$WordImpl value, $Res Function(_$WordImpl) then) =
      __$$WordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String text,
      @HiveField(2) String transliteration,
      @HiveField(3) String translation,
      @HiveField(4) String languageCode,
      @HiveField(5) double positionX,
      @HiveField(6) double positionY,
      @HiveField(7) String category,
      @HiveField(8) bool isDiscovered,
      @HiveField(9) DateTime? discoveredAt,
      @HiveField(10) int illuminationStrength,
      @HiveField(11) String? audioAsset,
      @HiveField(12) bool isPremiumOnly});
}

/// @nodoc
class __$$WordImplCopyWithImpl<$Res>
    extends _$WordCopyWithImpl<$Res, _$WordImpl>
    implements _$$WordImplCopyWith<$Res> {
  __$$WordImplCopyWithImpl(_$WordImpl _value, $Res Function(_$WordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? transliteration = null,
    Object? translation = null,
    Object? languageCode = null,
    Object? positionX = null,
    Object? positionY = null,
    Object? category = null,
    Object? isDiscovered = null,
    Object? discoveredAt = freezed,
    Object? illuminationStrength = null,
    Object? audioAsset = freezed,
    Object? isPremiumOnly = null,
  }) {
    return _then(_$WordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      transliteration: null == transliteration
          ? _value.transliteration
          : transliteration // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      positionX: null == positionX
          ? _value.positionX
          : positionX // ignore: cast_nullable_to_non_nullable
              as double,
      positionY: null == positionY
          ? _value.positionY
          : positionY // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      isDiscovered: null == isDiscovered
          ? _value.isDiscovered
          : isDiscovered // ignore: cast_nullable_to_non_nullable
              as bool,
      discoveredAt: freezed == discoveredAt
          ? _value.discoveredAt
          : discoveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      illuminationStrength: null == illuminationStrength
          ? _value.illuminationStrength
          : illuminationStrength // ignore: cast_nullable_to_non_nullable
              as int,
      audioAsset: freezed == audioAsset
          ? _value.audioAsset
          : audioAsset // ignore: cast_nullable_to_non_nullable
              as String?,
      isPremiumOnly: null == isPremiumOnly
          ? _value.isPremiumOnly
          : isPremiumOnly // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'WordAdapter')
class _$WordImpl implements _Word {
  const _$WordImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.text,
      @HiveField(2) required this.transliteration,
      @HiveField(3) required this.translation,
      @HiveField(4) required this.languageCode,
      @HiveField(5) required this.positionX,
      @HiveField(6) required this.positionY,
      @HiveField(7) required this.category,
      @HiveField(8) this.isDiscovered = false,
      @HiveField(9) this.discoveredAt,
      @HiveField(10) this.illuminationStrength = 100,
      @HiveField(11) this.audioAsset,
      @HiveField(12) this.isPremiumOnly = false});

  factory _$WordImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String text;
// Local script
  @override
  @HiveField(2)
  final String transliteration;
// Romanization if needed
  @override
  @HiveField(3)
  final String translation;
  @override
  @HiveField(4)
  final String languageCode;
  @override
  @HiveField(5)
  final double positionX;
// 0.0 to 1.0 (normalized)
  @override
  @HiveField(6)
  final double positionY;
  @override
  @HiveField(7)
  final String category;
// survival, food, people, nature, abstract
  @override
  @JsonKey()
  @HiveField(8)
  final bool isDiscovered;
  @override
  @HiveField(9)
  final DateTime? discoveredAt;
  @override
  @JsonKey()
  @HiveField(10)
  final int illuminationStrength;
// 100 = bright, 0 = faded
  @override
  @HiveField(11)
  final String? audioAsset;
  @override
  @JsonKey()
  @HiveField(12)
  final bool isPremiumOnly;

  @override
  String toString() {
    return 'Word(id: $id, text: $text, transliteration: $transliteration, translation: $translation, languageCode: $languageCode, positionX: $positionX, positionY: $positionY, category: $category, isDiscovered: $isDiscovered, discoveredAt: $discoveredAt, illuminationStrength: $illuminationStrength, audioAsset: $audioAsset, isPremiumOnly: $isPremiumOnly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.transliteration, transliteration) ||
                other.transliteration == transliteration) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.positionX, positionX) ||
                other.positionX == positionX) &&
            (identical(other.positionY, positionY) ||
                other.positionY == positionY) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isDiscovered, isDiscovered) ||
                other.isDiscovered == isDiscovered) &&
            (identical(other.discoveredAt, discoveredAt) ||
                other.discoveredAt == discoveredAt) &&
            (identical(other.illuminationStrength, illuminationStrength) ||
                other.illuminationStrength == illuminationStrength) &&
            (identical(other.audioAsset, audioAsset) ||
                other.audioAsset == audioAsset) &&
            (identical(other.isPremiumOnly, isPremiumOnly) ||
                other.isPremiumOnly == isPremiumOnly));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      text,
      transliteration,
      translation,
      languageCode,
      positionX,
      positionY,
      category,
      isDiscovered,
      discoveredAt,
      illuminationStrength,
      audioAsset,
      isPremiumOnly);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WordImplCopyWith<_$WordImpl> get copyWith =>
      __$$WordImplCopyWithImpl<_$WordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordImplToJson(
      this,
    );
  }
}

abstract class _Word implements Word {
  const factory _Word(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String text,
      @HiveField(2) required final String transliteration,
      @HiveField(3) required final String translation,
      @HiveField(4) required final String languageCode,
      @HiveField(5) required final double positionX,
      @HiveField(6) required final double positionY,
      @HiveField(7) required final String category,
      @HiveField(8) final bool isDiscovered,
      @HiveField(9) final DateTime? discoveredAt,
      @HiveField(10) final int illuminationStrength,
      @HiveField(11) final String? audioAsset,
      @HiveField(12) final bool isPremiumOnly}) = _$WordImpl;

  factory _Word.fromJson(Map<String, dynamic> json) = _$WordImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get text;
  @override // Local script
  @HiveField(2)
  String get transliteration;
  @override // Romanization if needed
  @HiveField(3)
  String get translation;
  @override
  @HiveField(4)
  String get languageCode;
  @override
  @HiveField(5)
  double get positionX;
  @override // 0.0 to 1.0 (normalized)
  @HiveField(6)
  double get positionY;
  @override
  @HiveField(7)
  String get category;
  @override // survival, food, people, nature, abstract
  @HiveField(8)
  bool get isDiscovered;
  @override
  @HiveField(9)
  DateTime? get discoveredAt;
  @override
  @HiveField(10)
  int get illuminationStrength;
  @override // 100 = bright, 0 = faded
  @HiveField(11)
  String? get audioAsset;
  @override
  @HiveField(12)
  bool get isPremiumOnly;
  @override
  @JsonKey(ignore: true)
  _$$WordImplCopyWith<_$WordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
