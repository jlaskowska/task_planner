import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/complete_task_use_case.dart';
import 'package:task_planner/presentation/widgets/task_overview/task_overview_view_model.dart';

import '../../mocks.dart';
import '../../test_utils.dart';

void main() {
  group('$TaskOverviewViewModel', () {
    late MockCreateTaskUseCase mockCreateTaskUseCase;
    late MockWatchAllTasksUseCase mockWatchAllTasksUseCase;
    late CompleteTaskUseCase mockCompleteTaskUseCase;
    late TaskOverviewViewModel viewModel;

    setUp(() {
      mockCreateTaskUseCase = MockCreateTaskUseCase();
      mockWatchAllTasksUseCase = MockWatchAllTasksUseCase();
      mockCompleteTaskUseCase = MockCompleteTaskUseCase();
      viewModel = TaskOverviewViewModel(
        createTaskUseCase: mockCreateTaskUseCase,
        watchAllTasksUseCase: mockWatchAllTasksUseCase,
        completeTaskUseCase: mockCompleteTaskUseCase,
      );
    });

    group('initialize', () {
      test('expect list of tasks where title is not empty', () async {
        final task = testTaskEntity(title: 'title');
        when(() => mockWatchAllTasksUseCase.call())
            .thenAnswer((_) => Stream.value([task]));

        viewModel.initialize();

        await Future.delayed(const Duration(milliseconds: 1));

        expect(viewModel.allTasks, [task]);
        verify(() => mockWatchAllTasksUseCase.call());
      });

      test('expect no tasks when title is empty', () async {
        final task = testTaskEntity(title: '');
        when(() => mockWatchAllTasksUseCase.call())
            .thenAnswer((_) => Stream.value([task]));

        viewModel.initialize();

        await Future.delayed(const Duration(milliseconds: 1));

        expect(viewModel.allTasks, []);
        verify(() => mockWatchAllTasksUseCase.call());
      });
    });

    group('createTask', () {
      test('expect task id', () async {
        const title = '';

        final taskEnity = testTaskEntity(title: title);
        when(() => mockCreateTaskUseCase.call(title: title))
            .thenAnswer((_) => Future.value(taskEnity));

        final taskId = await viewModel.createTask();

        expect(taskId, 1);

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
  });
}
