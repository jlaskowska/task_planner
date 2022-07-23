// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'task_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TaskEntityTearOff {
  const _$TaskEntityTearOff();

  _TaskEntity call(
      {required int id,
      required String title,
      required bool isCompleted,
      DateTime? completedAt,
      DateTime? uncompletedAt,
      TagEntity? tag}) {
    return _TaskEntity(
      id: id,
      title: title,
      isCompleted: isCompleted,
      completedAt: completedAt,
      uncompletedAt: uncompletedAt,
      tag: tag,
    );
  }
}

/// @nodoc
const $TaskEntity = _$TaskEntityTearOff();

/// @nodoc
mixin _$TaskEntity {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get uncompletedAt => throw _privateConstructorUsedError;
  TagEntity? get tag => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskEntityCopyWith<TaskEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskEntityCopyWith<$Res> {
  factory $TaskEntityCopyWith(
          TaskEntity value, $Res Function(TaskEntity) then) =
      _$TaskEntityCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String title,
      bool isCompleted,
      DateTime? completedAt,
      DateTime? uncompletedAt,
      TagEntity? tag});

  $TagEntityCopyWith<$Res>? get tag;
}

/// @nodoc
class _$TaskEntityCopyWithImpl<$Res> implements $TaskEntityCopyWith<$Res> {
  _$TaskEntityCopyWithImpl(this._value, this._then);

  final TaskEntity _value;
  // ignore: unused_field
  final $Res Function(TaskEntity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? isCompleted = freezed,
    Object? completedAt = freezed,
    Object? uncompletedAt = freezed,
    Object? tag = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: completedAt == freezed
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      uncompletedAt: uncompletedAt == freezed
          ? _value.uncompletedAt
          : uncompletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as TagEntity?,
    ));
  }

  @override
  $TagEntityCopyWith<$Res>? get tag {
    if (_value.tag == null) {
      return null;
    }

    return $TagEntityCopyWith<$Res>(_value.tag!, (value) {
      return _then(_value.copyWith(tag: value));
    });
  }
}

/// @nodoc
abstract class _$TaskEntityCopyWith<$Res> implements $TaskEntityCopyWith<$Res> {
  factory _$TaskEntityCopyWith(
          _TaskEntity value, $Res Function(_TaskEntity) then) =
      __$TaskEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String title,
      bool isCompleted,
      DateTime? completedAt,
      DateTime? uncompletedAt,
      TagEntity? tag});

  @override
  $TagEntityCopyWith<$Res>? get tag;
}

/// @nodoc
class __$TaskEntityCopyWithImpl<$Res> extends _$TaskEntityCopyWithImpl<$Res>
    implements _$TaskEntityCopyWith<$Res> {
  __$TaskEntityCopyWithImpl(
      _TaskEntity _value, $Res Function(_TaskEntity) _then)
      : super(_value, (v) => _then(v as _TaskEntity));

  @override
  _TaskEntity get _value => super._value as _TaskEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? isCompleted = freezed,
    Object? completedAt = freezed,
    Object? uncompletedAt = freezed,
    Object? tag = freezed,
  }) {
    return _then(_TaskEntity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: completedAt == freezed
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      uncompletedAt: uncompletedAt == freezed
          ? _value.uncompletedAt
          : uncompletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as TagEntity?,
    ));
  }
}

/// @nodoc

class _$_TaskEntity extends _TaskEntity {
  const _$_TaskEntity(
      {required this.id,
      required this.title,
      required this.isCompleted,
      this.completedAt,
      this.uncompletedAt,
      this.tag})
      : assert(isCompleted ? completedAt != null : completedAt == null),
        super._();

  @override
  final int id;
  @override
  final String title;
  @override
  final bool isCompleted;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? uncompletedAt;
  @override
  final TagEntity? tag;

  @override
  String toString() {
    return 'TaskEntity(id: $id, title: $title, isCompleted: $isCompleted, completedAt: $completedAt, uncompletedAt: $uncompletedAt, tag: $tag)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TaskEntity &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.isCompleted, isCompleted) &&
            const DeepCollectionEquality()
                .equals(other.completedAt, completedAt) &&
            const DeepCollectionEquality()
                .equals(other.uncompletedAt, uncompletedAt) &&
            const DeepCollectionEquality().equals(other.tag, tag));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(isCompleted),
      const DeepCollectionEquality().hash(completedAt),
      const DeepCollectionEquality().hash(uncompletedAt),
      const DeepCollectionEquality().hash(tag));

  @JsonKey(ignore: true)
  @override
  _$TaskEntityCopyWith<_TaskEntity> get copyWith =>
      __$TaskEntityCopyWithImpl<_TaskEntity>(this, _$identity);
}

abstract class _TaskEntity extends TaskEntity {
  const factory _TaskEntity(
      {required int id,
      required String title,
      required bool isCompleted,
      DateTime? completedAt,
      DateTime? uncompletedAt,
      TagEntity? tag}) = _$_TaskEntity;
  const _TaskEntity._() : super._();

  @override
  int get id;
  @override
  String get title;
  @override
  bool get isCompleted;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get uncompletedAt;
  @override
  TagEntity? get tag;
  @override
  @JsonKey(ignore: true)
  _$TaskEntityCopyWith<_TaskEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
