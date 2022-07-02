import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/create_task_use_case.dart';
import 'package:task_planner/domain/database/use_cases/watch_all_tasks_use_case.dart';
import 'package:task_planner/presentation/widgets/task_overview/task_overview_view_model.dart';

import '../../test_utils.dart';

class _MockCreateTaskUseCase extends Mock implements CreateTaskUseCase {}

class _MockWatchAllTasksUseCase extends Mock implements WatchAllTasksUseCase {}

void main() {
  group('$TaskOverviewViewModel', () {
    late _MockCreateTaskUseCase mockCreateTaskUseCase;
    late _MockWatchAllTasksUseCase mockWatchAllTasksUseCase;
    late TaskOverviewViewModel viewModel;

    setUp(() {
      mockCreateTaskUseCase = _MockCreateTaskUseCase();
      mockWatchAllTasksUseCase = _MockWatchAllTasksUseCase();
      viewModel = TaskOverviewViewModel(
        createTaskUseCase: mockCreateTaskUseCase,
        watchAllTasksUseCase: mockWatchAllTasksUseCase,
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
  });
}
