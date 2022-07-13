import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/update_task_title_use_case.dart';

import '../../../mocks.dart';

void main() {
  group('$UpdateTaskTitleUseCase', () {
    late MockDatabase mockDatabase;
    late UpdateTaskTitleUseCase useCase;

    setUp(() {
      mockDatabase = MockDatabase();
      useCase = UpdateTaskTitleUseCase(database: mockDatabase);
    });

    test('expect use case works as intended', () async {
      const id = 1;
      const title = 'title';

      when(() => mockDatabase.updateTask(id: id, title: title))
          .thenAnswer((_) async => {});

      await useCase.call(id: id, title: title);

      verify(() => mockDatabase.updateTask(id: id, title: title));
    });
  });
}
