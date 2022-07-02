import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/infrastructure/database/db.dart';

class CreateTaskUseCase {
  CreateTaskUseCase({
    Database? database,
  }) : _database = database ?? Database.instance;

  final Database _database;

  Future<TaskEntity> call({required String title, String? tag}) =>
      _database.createTask(title: title, tag: tag);
}
