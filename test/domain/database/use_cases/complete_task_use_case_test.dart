import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/complete_task_use_case.dart';

import '../../../mocks.dart';

void main() {
  group('$CompleteTaskUseCase', () {
    late MockDatabase mockDatabase;
    late CompleteTaskUseCase useCase;

    setUp(() {
      mockDatabase = MockDatabase();
      useCase = CompleteTaskUseCase(database: mockDatabase);
    });

    test('expect use case works as intended', () async {
      const id = 1;
      const value = true;

      when(() => mockDatabase.updateTask(id: id, completed: value))
          .thenAnswer((_) async => {});

      await useCase.call(
        id: id,
        completed: value,
      );

      verify(() => mockDatabase.updateTask(id: id, completed: value));
    });
  });
}
