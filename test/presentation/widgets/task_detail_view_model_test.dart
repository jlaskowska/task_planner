import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/presentation/widgets/task_details/task_details_view_model.dart';

import '../../mocks.dart';
import '../../test_utils.dart';

void main() {
  group('$TaskDetailsViewModel', () {
    late MockGetTaskByIdUseCase getTaskByIdUseCase;
    late MockDeleteTaskUseCase deleteTaskUseCase;
    late MockUpdateTaskTitleUseCase updateTaskTitleUseCase;
    late TaskDetailsViewModel viewModel;

    setUp(() {
      deleteTaskUseCase = MockDeleteTaskUseCase();
      updateTaskTitleUseCase = MockUpdateTaskTitleUseCase();
      getTaskByIdUseCase = MockGetTaskByIdUseCase();
      viewModel = TaskDetailsViewModel(
        getTaskByIdUseCase: getTaskByIdUseCase,
        deleteTaskUseCase: deleteTaskUseCase,
        updateTaskTitleUseCase: updateTaskTitleUseCase,
      );
    });
    group('initialize', () {
      group('when taskId is not null', () {
        test('expect isInitizlied & taskTitle', () async {
          const id = 1;
          final taskEnity = testTaskEntity(title: 'title');
          when(() => getTaskByIdUseCase.call(id))
              .thenAnswer((_) => Future.value(taskEnity));

          await viewModel.initialize(taskId: id);

          expect(viewModel.taskTitle, 'title');
          expect(viewModel.isInitialized, true);

          verify(() => getTaskByIdUseCase.call(id));
        });
      });
      group('when taskId is null', () {
        test('expect isInitizlied = false & taskTitle = null', () async {
          const id = 1;

          await viewModel.initialize();

          expect(viewModel.taskTitle, null);
          expect(viewModel.isInitialized, false);

          verifyNever(() => getTaskByIdUseCase.call(id));
        });
      });
    });

    group('deleteTask', () {
      test('expect task to be deleted', () async {
        const id = 1;
        final taskEnity = testTaskEntity(id: id);
        when(() => getTaskByIdUseCase.call(id))
            .thenAnswer((_) => Future.value(taskEnity));

        when(() => deleteTaskUseCase.call(id: id))
            .thenAnswer((_) async => () {});

        await viewModel.initialize(taskId: id);

        await viewModel.deleteTask();

        verify(() => deleteTaskUseCase.call(id: id));
      });
    });
    group('updateTaskTitle', () {
      test('expect task title to be updated', () async {
        const title = 'title';
        const id = 1;
        const newTitle = 'newTitle';

        final taskEnity = testTaskEntity(title: title);
        when(() => getTaskByIdUseCase.call(id))
            .thenAnswer((_) => Future.value(taskEnity));

        when(() => updateTaskTitleUseCase.call(id: id, title: newTitle))
            .thenAnswer((_) async => () {});

        await viewModel.initialize(taskId: id);

        await viewModel.updateTaskTitle(newTitle);

        verify(() => updateTaskTitleUseCase.call(title: newTitle, id: id));
      });
    });
  });
}
