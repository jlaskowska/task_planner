import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/complete_task_use_case.dart';
import 'package:task_planner/presentation/widgets/task_overview/task_overview_view_model.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$TaskOverviewViewModel', () {
    late MockCreateTaskUseCase mockCreateTaskUseCase;
    late MockWatchAllSortedTasksUseCase mockWatchAllSortedTasksUseCase;
    late CompleteTaskUseCase mockCompleteTaskUseCase;
    late TaskOverviewViewModel viewModel;
    late MockDeleteTaskUseCase mockDeleteTaskUseCase;

    setUp(() {
      mockCreateTaskUseCase = MockCreateTaskUseCase();
      mockWatchAllSortedTasksUseCase = MockWatchAllSortedTasksUseCase();
      mockCompleteTaskUseCase = MockCompleteTaskUseCase();
      mockDeleteTaskUseCase = MockDeleteTaskUseCase();

      viewModel = TaskOverviewViewModel(
        createTaskUseCase: mockCreateTaskUseCase,
        watchAllTasksUseCase: mockWatchAllSortedTasksUseCase,
        completeTaskUseCase: mockCompleteTaskUseCase,
        deleteTaskUseCase: mockDeleteTaskUseCase,
      );
    });

    group('initialize', () {
      test('expect list of tasks where title is not empty', () async {
        final task = testTaskEntity(title: 'title');
        when(() => mockWatchAllSortedTasksUseCase.call())
            .thenAnswer((_) => Stream.value([task]));

        viewModel.initialize();

        await Future.delayed(const Duration(milliseconds: 1));

        expect(viewModel.allSortedTasks, [task]);
        verify(() => mockWatchAllSortedTasksUseCase.call());
      });

      test('expect no tasks when title is empty', () async {
        final task = testTaskEntity(title: '');
        when(() => mockWatchAllSortedTasksUseCase.call())
            .thenAnswer((_) => Stream.value([task]));

        viewModel.initialize();

        await Future.delayed(const Duration(milliseconds: 1));

        expect(viewModel.allSortedTasks, []);
        verify(() => mockWatchAllSortedTasksUseCase.call());
      });
    });

    group('createTask', () {
      test('expect task id', () async {
        const id = 1;
        const title = '';

        final taskEnity = testTaskEntity(id: id, title: title);
        when(() => mockCreateTaskUseCase.call(title: title))
            .thenAnswer((_) => Future.value(taskEnity));

        final taskId = await viewModel.createTask();

        expect(taskId, id);

        verify(() => mockCreateTaskUseCase.call(title: title));
      });
    });

    group('toggleCompleteTask', () {
      test('expect uncompleted task is completed', () async {
        const int id = 1;
        const bool completed = true;

        when(() => mockCompleteTaskUseCase.call(id: id, completed: completed))
            .thenAnswer((_) async => () {});

        await viewModel.toggleCompleteTask(taskId: id, value: completed);

        verify(
            () => mockCompleteTaskUseCase.call(id: id, completed: completed));
      });
    });

    group('deleteTask', () {
      test('expect task is deleted', () async {
        const id = 1;

        when(() => mockDeleteTaskUseCase.call(id: id)).thenAnswer((_) async {});

        await viewModel.deleteTask(id);
        
        verify(() => mockDeleteTaskUseCase.call(id: id));
      });
    });
  });
}
