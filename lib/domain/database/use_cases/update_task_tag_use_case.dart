import 'package:task_planner/infrastructure/database/db.dart';

class UpdateTaskTagUseCase {
  UpdateTaskTagUseCase({
    Database? database,
  }) : _database = database ?? Database.instance;

  final Database _database;

  Future<void> call({required int id, String? tag}) =>
      _database.updateTaskTag(id: id, tag: tag);
}
