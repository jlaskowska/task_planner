import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/watch_all_tasks_use_case.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$WatchAllTasksUseCase', () {
    late MockDatabase mockDatabase;
    late WatchAllTasksUseCase useCase;

    setUp(() {
      mockDatabase = MockDatabase();
      useCase = WatchAllTasksUseCase(
        database: mockDatabase,
      );
    });

    test('expect use case works as intended', () async {
      final task = testTaskEntity();
      when(() => mockDatabase.watchAllTasks())
          .thenAnswer((_) => Stream.value([task]));

      final result = useCase();

      expect(
        result,
        emitsInOrder([
          [task],
        ]),
      );
      verify(() => mockDatabase.watchAllTasks());
    });
  });
}
