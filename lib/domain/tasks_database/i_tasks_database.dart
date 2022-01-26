import 'package:task_planner/domain/tasks_database/task_entity.dart';

abstract class ITasksDatabase {
  Future<void> createTask({required String title, required String id});
  Future<void> deleteTask(String id);
  Future<void> completeTask(String id);
  Future<TaskEntity> getTask(String id);
  Future<List<TaskEntity>> getAllTasks();
  Stream<List<TaskEntity>> watchAllTasks();
}
