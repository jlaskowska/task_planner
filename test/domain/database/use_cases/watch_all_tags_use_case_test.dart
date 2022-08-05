import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/watch_all_tags_use_case.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$WatchAllTagsUseCase', () {
    late MockDatabase mockDatabase;
    late WatchAllTagsUseCase useCase;

    setUp(() {
      mockDatabase = MockDatabase();
      useCase = WatchAllTagsUseCase(
        database: mockDatabase,
      );
    });

    test('expect use case works as intended', () async {
      final tag = testTagEntity();
      when(() => mockDatabase.watchAllTags())
          .thenAnswer((_) => Stream.value([tag]));

      final result = useCase();

      expect(
        result,
        emitsInOrder([
          [tag],
        ]),
      );
      verify(() => mockDatabase.watchAllTags());
    });
  });
}
