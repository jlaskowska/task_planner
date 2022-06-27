
import 'package:task_planner/domain/database/task_entity.dart';

abstract class ITasksDatabase {
  Future<void> createTask({required String title, String? tag});
  Future<void> deleteTask(int id);
  Future<void> completeTask(int id);
  Future<TaskEntity> getTask(int id);
  Future<List<TaskEntity>> getAllTasks();
  Stream<List<TaskEntity>> watchAllTasks();
}