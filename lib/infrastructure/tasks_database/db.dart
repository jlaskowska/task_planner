import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_planner/domain/tasks_database/i_tasks_database.dart';
import 'package:task_planner/domain/tasks_database/task_entity.dart';
import 'package:task_planner/infrastructure/tasks_database/tables/tasks.dart';
import 'package:task_planner/infrastructure/tasks_database/tasks_mapper.dart';

part 'db.g.dart';

@DriftDatabase(tables: [Tasks])
class TasksDatabase extends _$TasksDatabase implements ITasksDatabase {
  TasksDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  Future<void> completeTask(String id) async {
    (update(tasks)..where((task) => task.id.equals(id))).write(
      const TasksCompanion(
        completed: Value(true),
      ),
    );
  }

  @override
  Future<void> createTask({required String title, required String id}) async {
    final task = Task(title: title, id: id, completed: false);
    into(tasks).insert(task);
  }

  @override
  Future<void> deleteTask(String id) =>
      (delete(tasks)..where((task) => task.id.equals(id))).go();

  @override
  Future<List<TaskEntity>> getAllTasks() =>
      select(tasks).map((task) => TasksMapper.infToDom(task)).get();

  @override
  Future<TaskEntity> getTask(String id) => _getTaskQuery(id).getSingle();

  SingleSelectable<TaskEntity> _getTaskQuery(String id) =>
      (select(tasks)..where((task) => task.id.equals(id)))
          .map((task) => TasksMapper.infToDom(task));

  @override
  Stream<List<TaskEntity>> watchAllTasks() =>
      select(tasks).map((task) => TasksMapper.infToDom(task)).watch();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
