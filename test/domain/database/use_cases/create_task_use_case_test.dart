import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/create_task_use_case.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$CreateTaskUseCase', () {
    late MockDatabase mockDatabase;
    late CreateTaskUseCase useCase;

    setUp(() {
      mockDatabase = MockDatabase();
      useCase = CreateTaskUseCase(database: mockDatabase);
    });

    test('expect use case works as intended', () async {
      const title = '';
      final task = testTaskEntity();
      when(() => mockDatabase.createTask(title: title))
          .thenAnswer((_) => Future.value(task));

      final result = await useCase.call(title: title);
      
      expect(result, task);
      verify(() => mockDatabase.createTask(title: title));
    });
  });
}
