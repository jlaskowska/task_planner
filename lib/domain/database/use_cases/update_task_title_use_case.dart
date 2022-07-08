import 'package:task_planner/infrastructure/database/db.dart';

class UpdateTaskTitleUseCase {
  UpdateTaskTitleUseCase({
    Database? database,
  }) : _database = database ?? Database.instance;

  final Database _database;

  Future<void> call({required int id, required String title}) =>
      _database.updateTask(id: id, title: title);
}
