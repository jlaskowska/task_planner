import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/get_task_by_id_use_case.dart';
import 'package:task_planner/domain/database/use_cases/watch_task_use_case.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$GetTaskByIdUseCase', () {
    late MockDatabase mockDatabase;
    late WatchTaskUseCase useCase;

    setUp(() {
      mockDatabase = MockDatabase();
      useCase = WatchTaskUseCase(database: mockDatabase);
    });

    test('expect use case works as intended', () async {
      const id = 1;
      final task = testTaskEntity();
      when(() => mockDatabase.watchTask(id))
          .thenAnswer((_) => Stream.value(task));

      final result = useCase(id);

      expect(result, emits(task));

      verify(() => mockDatabase.watchTask(id));
    });
  });
}
