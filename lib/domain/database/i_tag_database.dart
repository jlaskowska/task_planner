
import 'package:task_planner/domain/database/tag_entity.dart';

abstract class ITagDatabase {
  Future<void> addTag(String color);
  Future<void> deleteTag(String color);
  Stream<List<TagEntity>> watchAllTags();
}
