import 'package:task_planner/infrastructure/database/db.dart';

class CompleteTaskUseCase {
  CompleteTaskUseCase({
    Database? database,
  }) : _database = database ?? Database.instance;

  final Database _database;

  Future<void> call({
    required int id,
    required bool completed,
  }) =>
      _database.updateTask(id: id, completed: completed);
}
