import 'package:task_planner/infrastructure/database/db.dart';

class AddTagUseCase {
  AddTagUseCase({
    Database? database,
  }) : _database = database ?? Database.instance;

  final Database _database;

  Future<void> call({
    required String color,
   
  }) =>
      _database.addTag(color);
}
