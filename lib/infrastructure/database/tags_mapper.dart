import 'package:task_planner/domain/database/tag_entity.dart';
import 'package:task_planner/infrastructure/database/db.dart';

class TagsMapper {
  TagsMapper._();

  static TagEntity infToDom(Tag tag) => TagEntity(
        label: tag.label,
      );

  static Tag domToInf(TagEntity entity) => Tag(
        label: entity.label,
      );
}
