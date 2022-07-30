import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/add_tag_use_case.dart';

import '../../../mocks.dart';

void main() {
  group('$AddTagUseCase', () {
    late MockDatabase mockDatabase;
    late AddTagUseCase useCase;

    setUp(() {
      mockDatabase = MockDatabase();
      useCase = AddTagUseCase(database: mockDatabase);
    });

    test('expect use case works as intended', () async {
      const color = '12345678';

      when(() => mockDatabase.addTag(color)).thenAnswer((_) async => {});

      await useCase.call(color: color);

      verify(() => mockDatabase.addTag(color));
    });
  });
}
