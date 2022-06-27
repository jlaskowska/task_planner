import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/infrastructure/database/db.dart';

class GetTaskByIdUseCase {
  GetTaskByIdUseCase({
    Database? database,
  }) : _database = database ?? Database.instance;

  final Database _database;

  Future<TaskEntity> call(int id) => _database.getTask(id);
}
