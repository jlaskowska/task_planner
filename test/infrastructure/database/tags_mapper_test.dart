import 'package:flutter_test/flutter_test.dart';
import 'package:task_planner/domain/database/tag_entity.dart';
import 'package:task_planner/infrastructure/database/db.dart';
import 'package:task_planner/infrastructure/database/tags_mapper.dart';

void main() {
  group('$TagsMapper', () {
    const tagEntity = TagEntity(label: 'label');
    final tag = Tag(label: 'label');
    
    test('infToDom', () {
      expect(TagsMapper.infToDom(tag), tagEntity);
    });

    test('domToInf', () {
      expect(TagsMapper.domToInf(tagEntity), tag);
    });
  });
}
