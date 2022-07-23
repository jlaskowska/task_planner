// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String? tag;
  final String title;
  final bool completed;
  final DateTime? completedAt;
  final DateTime? uncompletedAt;
  Task(
      {required this.id,
      this.tag,
      required this.title,
      required this.completed,
      this.completedAt,
      this.uncompletedAt});
  factory Task.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Task(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      tag: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tag']),
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      completed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}completed'])!,
      completedAt: $TasksTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}completed_at'])),
      uncompletedAt: $TasksTable.$converter1.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uncompleted_at'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || tag != null) {
      map['tag'] = Variable<String?>(tag);
    }
    map['title'] = Variable<String>(title);
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || completedAt != null) {
      final converter = $TasksTable.$converter0;
      map['completed_at'] = Variable<String?>(converter.mapToSql(completedAt));
    }
    if (!nullToAbsent || uncompletedAt != null) {
      final converter = $TasksTable.$converter1;
      map['uncompleted_at'] =
          Variable<String?>(converter.mapToSql(uncompletedAt));
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      title: Value(title),
      completed: Value(completed),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      uncompletedAt: uncompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(uncompletedAt),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      tag: serializer.fromJson<String?>(json['tag']),
      title: serializer.fromJson<String>(json['title']),
      completed: serializer.fromJson<bool>(json['completed']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      uncompletedAt: serializer.fromJson<DateTime?>(json['uncompletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tag': serializer.toJson<String?>(tag),
      'title': serializer.toJson<String>(title),
      'completed': serializer.toJson<bool>(completed),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'uncompletedAt': serializer.toJson<DateTime?>(uncompletedAt),
    };
  }

  Task copyWith(
          {int? id,
          String? tag,
          String? title,
          bool? completed,
          DateTime? completedAt,
          DateTime? uncompletedAt}) =>
      Task(
        id: id ?? this.id,
        tag: tag ?? this.tag,
        title: title ?? this.title,
        completed: completed ?? this.completed,
        completedAt: completedAt ?? this.completedAt,
        uncompletedAt: uncompletedAt ?? this.uncompletedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('title: $title, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('uncompletedAt: $uncompletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tag, title, completed, completedAt, uncompletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.tag == this.tag &&
          other.title == this.title &&
          other.completed == this.completed &&
          other.completedAt == this.completedAt &&
          other.uncompletedAt == this.uncompletedAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String?> tag;
  final Value<String> title;
  final Value<bool> completed;
  final Value<DateTime?> completedAt;
  final Value<DateTime?> uncompletedAt;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.tag = const Value.absent(),
    this.title = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.uncompletedAt = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    this.tag = const Value.absent(),
    required String title,
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.uncompletedAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String?>? tag,
    Expression<String>? title,
    Expression<bool>? completed,
    Expression<DateTime?>? completedAt,
    Expression<DateTime?>? uncompletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tag != null) 'tag': tag,
      if (title != null) 'title': title,
      if (completed != null) 'completed': completed,
      if (completedAt != null) 'completed_at': completedAt,
      if (uncompletedAt != null) 'uncompleted_at': uncompletedAt,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String?>? tag,
      Value<String>? title,
      Value<bool>? completed,
      Value<DateTime?>? completedAt,
      Value<DateTime?>? uncompletedAt}) {
    return TasksCompanion(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
      uncompletedAt: uncompletedAt ?? this.uncompletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String?>(tag.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (completedAt.present) {
      final converter = $TasksTable.$converter0;
      map['completed_at'] =
          Variable<String?>(converter.mapToSql(completedAt.value));
    }
    if (uncompletedAt.present) {
      final converter = $TasksTable.$converter1;
      map['uncompleted_at'] =
          Variable<String?>(converter.mapToSql(uncompletedAt.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('title: $title, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('uncompletedAt: $uncompletedAt')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String?> tag = GeneratedColumn<String?>(
      'tag', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULL REFERENCES tags(label)');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool?> completed = GeneratedColumn<bool?>(
      'completed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (completed IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, String?> completedAt =
      GeneratedColumn<String?>('completed_at', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<DateTime>($TasksTable.$converter0);
  final VerificationMeta _uncompletedAtMeta =
      const VerificationMeta('uncompletedAt');
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, String?> uncompletedAt =
      GeneratedColumn<String?>('uncompleted_at', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<DateTime>($TasksTable.$converter1);
  @override
  List<GeneratedColumn> get $columns =>
      [id, tag, title, completed, completedAt, uncompletedAt];
  @override
  String get aliasedName => _alias ?? 'tasks';
  @override
  String get actualTableName => 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    context.handle(_completedAtMeta, const VerificationResult.success());
    context.handle(_uncompletedAtMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Task.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }

  static TypeConverter<DateTime, String> $converter0 =
      const IsoDateTimeConverter();
  static TypeConverter<DateTime, String> $converter1 =
      const IsoDateTimeConverter();
}

class Tag extends DataClass implements Insertable<Tag> {
  final String label;
  Tag({required this.label});
  factory Tag.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Tag(
      label: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}label'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['label'] = Variable<String>(label);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      label: Value(label),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      label: serializer.fromJson<String>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'label': serializer.toJson<String>(label),
    };
  }

  Tag copyWith({String? label}) => Tag(
        label: label ?? this.label,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => label.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Tag && other.label == this.label);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> label;
  const TagsCompanion({
    this.label = const Value.absent(),
  });
  TagsCompanion.insert({
    required String label,
  }) : label = Value(label);
  static Insertable<Tag> custom({
    Expression<String>? label,
  }) {
    return RawValuesInsertable({
      if (label != null) 'label': label,
    });
  }

  TagsCompanion copyWith({Value<String>? label}) {
    return TagsCompanion(
      label: label ?? this.label,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TagsTable(this._db, [this._alias]);
  final VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String?> label = GeneratedColumn<String?>(
      'label', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 10),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [label];
  @override
  String get aliasedName => _alias ?? 'tags';
  @override
  String get actualTableName => 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {label};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Tag.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TagsTable tags = $TagsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks, tags];
}
