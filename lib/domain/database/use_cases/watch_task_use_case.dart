import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/infrastructure/database/db.dart';

class WatchTaskUseCase {
  WatchTaskUseCase({
    Database? database,
  }) : _database = database ?? Database.instance;

  final Database _database;

  Stream<TaskEntity> call(int id) =>
      _database.watchTask(id);
}
