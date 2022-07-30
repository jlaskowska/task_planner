import 'package:task_planner/infrastructure/database/db.dart';

class DeleteTagUseCase {
  DeleteTagUseCase({
    Database? database,
  }) : _database = database ?? Database.instance;

  final Database _database;

  Future<void> call({
    required String color,
   
  }) =>
      _database.deleteTag(color);
}
