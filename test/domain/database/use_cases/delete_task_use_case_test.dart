import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/delete_task_use_case.dart';

import '../../../mocks.dart';

void main() {
  group('$DeleteTaskUseCase', () {
    late MockDatabase mockDatabase;
    late DeleteTaskUseCase useCase;

    setUp(() {
      mockDatabase = MockDatabase();
      useCase = DeleteTaskUseCase(database: mockDatabase);
    });

    test('expect use case works as intended', () async {
      const id = 1;

      when(() => mockDatabase.deleteTask(id)).thenAnswer((_) async => {});

      await useCase.call(id: id);

      verify(() => mockDatabase.deleteTask(id));
    });
  });
}
