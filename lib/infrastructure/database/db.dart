import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:meta/meta.dart';
import 'package:task_planner/domain/database/i_tag_database.dart';
import 'package:task_planner/domain/database/i_tasks_database.dart';
import 'package:task_planner/domain/database/tag_entity.dart';
import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/infrastructure/database/converters/iso_date_time_converter.dart';
import 'package:task_planner/infrastructure/database/tables/tags.dart';
import 'package:task_planner/infrastructure/database/tables/tasks.dart';
import 'package:task_planner/infrastructure/database/tags_mapper.dart';
import 'package:task_planner/infrastructure/database/tasks_mapper.dart';

part 'db.g.dart';

@DriftDatabase(tables: [Tasks, Tags])
class Database extends _$Database implements ITasksDatabase, ITagDatabase {
  @visibleForTesting
  Database(QueryExecutor executor) : super(executor);

  static Database? _instance;

  static Database get instance {
    if (_instance == null) {
      throw ('db needs to be initialized');
    }

    return _instance!;
  }

  static void initialize(QueryExecutor executor) {
    assert(_instance == null);

    _instance = Database(executor);
  }

  @override
  int get schemaVersion => 1;

  @override
  Future<TaskEntity> createTask({
    required String title,
    String? tag,
  }) async {
    if (tag != null) {
      final tagObject = await (select(tags)
            ..where((tag1) => tag1.color.equals(tag)))
          .getSingleOrNull();
      if (tagObject == null) {
        await addTag(tag);
      }
    }
    final taskCompanion = TasksCompanion(
      title: Value(title),
      tag: tag != null ? Value(tag) : const Value.absent(),
    );
    final id = await into(tasks).insert(taskCompanion);

    return getTask(id);
  }

  @override
  Future<void> updateTask({
    required int id,
    String? title,
    bool? completed,
  }) {
    if (completed == true) {
      return (update(tasks)..where((task) => task.id.equals(id))).write(
        TasksCompanion(
          title: title != null ? Value(title) : const Value.absent(),
          completedAt: Value(clock.now().toUtc()),
          uncompletedAt: const Value(null),
        ),
      );
    } else if (completed == false) {
      return (update(tasks)..where((task) => task.id.equals(id))).write(
        TasksCompanion(
          title: title != null ? Value(title) : const Value.absent(),
          completedAt: const Value(null),
          uncompletedAt: Value(clock.now().toUtc()),
        ),
      );
    } else {
      return (update(tasks)..where((task) => task.id.equals(id))).write(
        TasksCompanion(
          title: title != null ? Value(title) : const Value.absent(),
          completedAt: const Value.absent(),
          uncompletedAt: const Value.absent(),
        ),
      );
    }
  }

  @override
  Future<void> updateTaskTag({required int id, String? tag}) =>
      (update(tasks)..where((task) => task.id.equals(id)))
          .write(TasksCompanion(tag: Value(tag)));

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
      .join([leftOuterJoin(tags, tags.color.equalsExp(tasks.tag))])
      .watch()
      .map((rows) => rows.map((row) {
            return TasksMapper.infToDom(row.readTable(tasks));
          }).toList());

    @override
      Stream<TaskEntity> watchTask(int id) =>  _getTaskQuery(id).watchSingle();

  @override
  Future<void> addTag(String color) async {
    final tag = Tag(color: color);
    into(tags).insert(tag);
  }

  @override
  Future<void> deleteTag(String color) async {
    (update(tasks)..where((task) => task.tag.equals(color))).write(
      const TasksCompanion(tag: Value(null)),
    );
    (delete(tags)..where((tag) => tag.color.equals(color))).go();
  }

  @override
  Stream<List<TagEntity>> watchAllTags() =>
      select(tags).map((tag) => TagsMapper.infToDom(tag)).watch();
}
