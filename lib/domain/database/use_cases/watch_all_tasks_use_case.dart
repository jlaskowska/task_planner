import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/infrastructure/database/db.dart';

class WatchAllTasksUseCase {
  WatchAllTasksUseCase({
    Database? database,
  }) : _database = database ?? Database.instance;

  final Database _database;

  Stream<List<TaskEntity>> call() => _database.watchAllTasks();
}
