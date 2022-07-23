import 'package:flutter_test/flutter_test.dart';
import 'package:task_planner/domain/database/tasks_sorter.dart';

import '../../test_utils.dart';

void main() {
  group('$TasksSorter', () {
    group('sort', () {
      test('when tasks are empty, expect empty list', () {
        expect(TasksSorter.sort([]), isEmpty);
      });

      test(
          'when tasks are a mixture of uncompleted, noncompleted and completed, expect correct order',
          () {
        final tasks = [
          testTaskEntity(id: 1, completedAt: DateTime(1)),
          testTaskEntity(id: 2),
          testTaskEntity(id: 3, uncompletedAt: DateTime(2)),
          testTaskEntity(id: 4, completedAt: DateTime(3)),
          testTaskEntity(id: 5),
          testTaskEntity(id: 6, uncompletedAt: DateTime(4)),
        ];
        expect(TasksSorter.sort(tasks), [
          testTaskEntity(id: 6, uncompletedAt: DateTime(4)),
          testTaskEntity(id: 3, uncompletedAt: DateTime(2)),
          testTaskEntity(id: 5),
          testTaskEntity(id: 2),
          testTaskEntity(id: 1, completedAt: DateTime(1)),
          testTaskEntity(id: 4, completedAt: DateTime(3)),
        ]);
      });
    });
  });
}
