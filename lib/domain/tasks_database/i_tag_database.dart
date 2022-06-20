import 'package:task_planner/domain/tasks_database/tag_entity.dart';

abstract class ITagDatabase {
  Future<void> addTag(String label);
  Future<void> deleteTag(String label);
  Future<List<TagEntity>> getAllTags();
}
