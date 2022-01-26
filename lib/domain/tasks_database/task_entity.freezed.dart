// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
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
      {required String title, required String id, required bool isCompleted}) {
    return _TaskEntity(
      title: title,
      id: id,
      isCompleted: isCompleted,
    );
  }
}

/// @nodoc
const $TaskEntity = _$TaskEntityTearOff();

/// @nodoc
mixin _$TaskEntity {
  String get title => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskEntityCopyWith<TaskEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskEntityCopyWith<$Res> {
  factory $TaskEntityCopyWith(
          TaskEntity value, $Res Function(TaskEntity) then) =
      _$TaskEntityCopyWithImpl<$Res>;
  $Res call({String title, String id, bool isCompleted});
}

/// @nodoc
class _$TaskEntityCopyWithImpl<$Res> implements $TaskEntityCopyWith<$Res> {
  _$TaskEntityCopyWithImpl(this._value, this._then);

  final TaskEntity _value;
  // ignore: unused_field
  final $Res Function(TaskEntity) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? id = freezed,
    Object? isCompleted = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$TaskEntityCopyWith<$Res> implements $TaskEntityCopyWith<$Res> {
  factory _$TaskEntityCopyWith(
          _TaskEntity value, $Res Function(_TaskEntity) then) =
      __$TaskEntityCopyWithImpl<$Res>;
  @override
  $Res call({String title, String id, bool isCompleted});
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
    Object? title = freezed,
    Object? id = freezed,
    Object? isCompleted = freezed,
  }) {
    return _then(_TaskEntity(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_TaskEntity implements _TaskEntity {
  const _$_TaskEntity(
      {required this.title, required this.id, required this.isCompleted});

  @override
  final String title;
  @override
  final String id;
  @override
  final bool isCompleted;

  @override
  String toString() {
    return 'TaskEntity(title: $title, id: $id, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TaskEntity &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.isCompleted, isCompleted));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(isCompleted));

  @JsonKey(ignore: true)
  @override
  _$TaskEntityCopyWith<_TaskEntity> get copyWith =>
      __$TaskEntityCopyWithImpl<_TaskEntity>(this, _$identity);
}

abstract class _TaskEntity implements TaskEntity {
  const factory _TaskEntity(
      {required String title,
      required String id,
      required bool isCompleted}) = _$_TaskEntity;

  @override
  String get title;
  @override
  String get id;
  @override
  bool get isCompleted;
  @override
  @JsonKey(ignore: true)
  _$TaskEntityCopyWith<_TaskEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
