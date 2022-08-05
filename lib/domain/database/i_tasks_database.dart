import 'package:task_planner/domain/database/task_entity.dart';

abstract class ITasksDatabase {
  Future<TaskEntity> createTask({required String title, String? tag});
  Future<void> updateTask({required int id, String? title, bool? completed});
  Future<void> updateTaskTag({required int id, String? tag});
  Future<void> deleteTask(int id);
  Future<TaskEntity> getTask(int id);
  Stream<TaskEntity> watchTask(int id);
  Future<List<TaskEntity>> getAllTasks();
  Stream<List<TaskEntity>> watchAllTasks();
}
