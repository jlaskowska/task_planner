import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/delete_tag_use_case.dart';

import '../../../mocks.dart';

void main() {
  group('$DeleteTagUseCase', () {
    late MockDatabase mockDatabase;
    late DeleteTagUseCase useCase;

    setUp(() {
      mockDatabase = MockDatabase();
      useCase = DeleteTagUseCase(database: mockDatabase);
    });

    test('expect use case works as intended', () async {
      const color = '12345678';

      when(() => mockDatabase.deleteTag(color)).thenAnswer((_) async => {});

      await useCase.call(color: color);

      verify(() => mockDatabase.deleteTag(color));
    });
  });
}
