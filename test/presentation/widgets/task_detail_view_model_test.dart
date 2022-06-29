import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/get_task_by_id_use_case.dart';
import 'package:task_planner/presentation/widgets/task_details/task_details_view_model.dart';

import '../../test_utils.dart';

class _MockGetTaskByIdUseCase extends Mock implements GetTaskByIdUseCase {}

void main() {
  group('$TaskDetailsViewModel', () {
    late _MockGetTaskByIdUseCase useCase;
    late TaskDetailsViewModel taskDetailsViewModel;

    setUp(() {
      useCase = _MockGetTaskByIdUseCase();
      taskDetailsViewModel = TaskDetailsViewModel(getTaskByIdUseCase: useCase);
    });
    group('initialize', () {
      group('when taskId is not null', () {
        test('expect isInitizlied & taskTitle', () async {
          const id = 1;
          final taskEnity = testTaskEntity(title: 'title');
          when(() => useCase.call(id))
              .thenAnswer((_) => Future.value(taskEnity));

          await taskDetailsViewModel.initialize(taskId: id);

          expect(taskDetailsViewModel.taskTitle, 'title');
          expect(taskDetailsViewModel.isInitialized, true);

          verify(() => useCase.call(id));
        });
      });
      group('when taskId is null', () {
        test('expect isInitizlied = false & taskTitle = null', () async {
          const id = 1;

          await taskDetailsViewModel.initialize();

          expect(taskDetailsViewModel.taskTitle, null);
          expect(taskDetailsViewModel.isInitialized, false);

          verifyNever(() => useCase.call(id));
        });
      });
    });
  });
}
