import 'package:task_planner/domain/database/tag_entity.dart';
import 'package:task_planner/infrastructure/database/db.dart';

class WatchAllTagsUseCase {
  WatchAllTagsUseCase({
    Database? database,
  }) : _database = database ?? Database.instance;

  final Database _database;

  Stream<List<TagEntity>> call() =>
      _database.watchAllTags();
}
