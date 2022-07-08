import 'package:task_planner/infrastructure/database/db.dart';

class DeleteTaskUseCase {
  DeleteTaskUseCase({
    Database? database,
  }) : _database = database ?? Database.instance;

  final Database _database;

  Future<void> call({required int id}) => _database.deleteTask(id);
}
