import 'package:flutter_test/flutter_test.dart';
import 'package:task_planner/domain/database/task_entity.dart';

import '../../test_utils.dart';

void main() {
  group('$TaskEntity', () {
    test('completedAt != null, uncompletedAt == null', () {
      final taskEntity = testTaskEntity(completedAt: DateTime(1));
      expect(taskEntity.isCompleted, isTrue);
      expect(taskEntity.wasCompleted, isFalse);
      expect(taskEntity.neverCompleted, isFalse);
    });

    test('completedAt == null, uncompletedAt != null', () {
      final taskEntity = testTaskEntity(uncompletedAt: DateTime(1));
      expect(taskEntity.isCompleted, isFalse);
      expect(taskEntity.wasCompleted, isTrue);
      expect(taskEntity.neverCompleted, isFalse);
    });

    test('completedAt == null, uncompletedAt == null', () {
      final taskEntity = testTaskEntity();
      expect(taskEntity.isCompleted, isFalse);
      expect(taskEntity.wasCompleted, isFalse);
      expect(taskEntity.neverCompleted, isTrue);
    });
  });
}
