// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tag_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TagEntityTearOff {
  const _$TagEntityTearOff();

  _TagEntity call({required String color}) {
    return _TagEntity(
      color: color,
    );
  }
}

/// @nodoc
const $TagEntity = _$TagEntityTearOff();

/// @nodoc
mixin _$TagEntity {
  String get color => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TagEntityCopyWith<TagEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagEntityCopyWith<$Res> {
  factory $TagEntityCopyWith(TagEntity value, $Res Function(TagEntity) then) =
      _$TagEntityCopyWithImpl<$Res>;
  $Res call({String color});
}

/// @nodoc
class _$TagEntityCopyWithImpl<$Res> implements $TagEntityCopyWith<$Res> {
  _$TagEntityCopyWithImpl(this._value, this._then);

  final TagEntity _value;
  // ignore: unused_field
  final $Res Function(TagEntity) _then;

  @override
  $Res call({
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$TagEntityCopyWith<$Res> implements $TagEntityCopyWith<$Res> {
  factory _$TagEntityCopyWith(
          _TagEntity value, $Res Function(_TagEntity) then) =
      __$TagEntityCopyWithImpl<$Res>;
  @override
  $Res call({String color});
}

/// @nodoc
class __$TagEntityCopyWithImpl<$Res> extends _$TagEntityCopyWithImpl<$Res>
    implements _$TagEntityCopyWith<$Res> {
  __$TagEntityCopyWithImpl(_TagEntity _value, $Res Function(_TagEntity) _then)
      : super(_value, (v) => _then(v as _TagEntity));

  @override
  _TagEntity get _value => super._value as _TagEntity;

  @override
  $Res call({
    Object? color = freezed,
  }) {
    return _then(_TagEntity(
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TagEntity implements _TagEntity {
  const _$_TagEntity({required this.color});

  @override
  final String color;

  @override
  String toString() {
    return 'TagEntity(color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TagEntity &&
            const DeepCollectionEquality().equals(other.color, color));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(color));

  @JsonKey(ignore: true)
  @override
  _$TagEntityCopyWith<_TagEntity> get copyWith =>
      __$TagEntityCopyWithImpl<_TagEntity>(this, _$identity);
}

abstract class _TagEntity implements TagEntity {
  const factory _TagEntity({required String color}) = _$_TagEntity;

  @override
  String get color;
  @override
  @JsonKey(ignore: true)
  _$TagEntityCopyWith<_TagEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
