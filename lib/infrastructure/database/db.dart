import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_planner/domain/database/i_tag_database.dart';
import 'package:task_planner/domain/database/i_tasks_database.dart';
import 'package:task_planner/domain/database/tag_entity.dart';
import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/infrastructure/database/tables/tags.dart';
import 'package:task_planner/infrastructure/database/tables/tasks.dart';
import 'package:task_planner/infrastructure/database/tags_mapper.dart';
import 'package:task_planner/infrastructure/database/tasks_mapper.dart';

part 'db.g.dart';

@DriftDatabase(tables: [Tasks, Tags])
class Database extends _$TasksDatabase implements ITasksDatabase, ITagDatabase {
  @visibleForTesting
  Database([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static Database? _instance;

  static Database get instance => _instance ??= Database();

  @override
  int get schemaVersion => 1;

  @override
  Future<void> completeTask(int id) async {
    (update(tasks)..where((task) => task.id.equals(id))).write(
      const TasksCompanion(
        completed: Value(true),
      ),
    );
  }

  @override
  Future<void> createTask({
    required String title,
    String? tag,
  }) async {
    if (tag != null) {
      final tagObject = await (select(tags)
            ..where((tag1) => tag1.label.equals(tag)))
          .getSingleOrNull();
      if (tagObject == null) {
        await addTag(tag);
      }
    }
    final task = TasksCompanion(
      title: Value(title),
      tag: Value(tag),
      completed: const Value(false),
    );
    await into(tasks).insert(task);
  }

  @override
  Future<void> deleteTask(int id) =>
      (delete(tasks)..where((task) => task.id.equals(id))).go();

  @override
  Future<List<TaskEntity>> getAllTasks() =>
      select(tasks).map((task) => TasksMapper.infToDom(task)).get();

  @override
  Future<TaskEntity> getTask(int id) => _getTaskQuery(id).getSingle();

  SingleSelectable<TaskEntity> _getTaskQuery(int id) =>
      (select(tasks)..where((task) => task.id.equals(id)))
          .map((task) => TasksMapper.infToDom(task));

  @override
  Stream<List<TaskEntity>> watchAllTasks() => select(tasks)
      .join([leftOuterJoin(tags, tags.label.equalsExp(tasks.tag))])
      .watch()
      .map((rows) => rows.map((row) {
            return TasksMapper.infToDom(row.readTable(tasks));
          }).toList());

  @override
  Future<void> addTag(String label) async {
    final tag = Tag(label: label);
    into(tags).insert(tag);
  }

  @override
  Future<void> deleteTag(String label) async {
    (update(tasks)..where((task) => task.tag.equals(label))).write(
      const TasksCompanion(tag: Value(null)),
    );
    (delete(tags)..where((tag) => tag.label.equals(label))).go();
  }

  @override
  Future<List<TagEntity>> getAllTags() =>
      select(tags).map((tag) => TagsMapper.infToDom(tag)).get();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
