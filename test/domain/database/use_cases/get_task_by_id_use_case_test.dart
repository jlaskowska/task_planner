import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/get_task_by_id_use_case.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$GetTaskByIdUseCase', () {
    late MockDatabase mockDatabase;
    late GetTaskByIdUseCase useCase;

    setUp(() {
      mockDatabase = MockDatabase();
      useCase = GetTaskByIdUseCase(database: mockDatabase);
    });

    test('expect use case works as intended', () async {
      const id = 1;
      final task = testTaskEntity();
      when(() => mockDatabase.getTask(id))
          .thenAnswer((_) => Future.value(task));

      final result = await useCase(id);
      expectLater(result, task);
      verify(() => mockDatabase.getTask(id));
    });
  });
}
