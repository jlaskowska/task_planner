import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/add_tag_use_case.dart';
import 'package:task_planner/domain/database/use_cases/delete_tag_use_case.dart';
import 'package:task_planner/domain/database/use_cases/update_task_tag_use_case.dart';
import 'package:task_planner/domain/database/use_cases/watch_all_tags_use_case.dart';
import 'package:task_planner/presentation/widgets/task_details/task_details_view_model.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$TaskDetailsViewModel', () {
    late MockGetTaskByIdUseCase getTaskByIdUseCase;
    late MockDeleteTaskUseCase deleteTaskUseCase;
    late MockUpdateTaskTitleUseCase updateTaskTitleUseCase;
    late AddTagUseCase addTagUseCase;
    late UpdateTaskTagUseCase updateTaskTagUseCase;
    late DeleteTagUseCase deleteTagUseCase;
    late WatchAllTagsUseCase watchAllTagsUseCase;
    late TaskDetailsViewModel viewModel;

    setUp(() {
      deleteTaskUseCase = MockDeleteTaskUseCase();
      updateTaskTitleUseCase = MockUpdateTaskTitleUseCase();
      getTaskByIdUseCase = MockGetTaskByIdUseCase();
      addTagUseCase = MockAddTagUseCase();
      deleteTagUseCase = MockDeleteTagUseCase();
      updateTaskTagUseCase = MockUpdateTaskTagUseCase();
      watchAllTagsUseCase = MockWatchAllTagsUseCase();
      viewModel = TaskDetailsViewModel(
        getTaskByIdUseCase: getTaskByIdUseCase,
        deleteTaskUseCase: deleteTaskUseCase,
        updateTaskTitleUseCase: updateTaskTitleUseCase,
        watchAllTagsUseCase: watchAllTagsUseCase,
        addTagUseCase: addTagUseCase,
        deleteTagUseCase: deleteTagUseCase,
        updateTasksTagUseCase: updateTaskTagUseCase,
      );
    });
    group('initialize', () {
      group('when taskId is not null', () {
        test('expect isInitizlied & taskTitle', () async {
          const id = 1;
          final taskEnity = testTaskEntity(title: 'title');
          when(() => getTaskByIdUseCase.call(id))
              .thenAnswer((_) => Future.value(taskEnity));

          when(() => getTaskByIdUseCase.call(id))
              .thenAnswer((_) => Future.value(taskEnity));

          when(() => watchAllTagsUseCase.call())
              .thenAnswer((_) => Stream.value([]));

          await viewModel.initialize(taskId: id);

          expect(viewModel.taskTitle, 'title');
          expect(viewModel.isInitialized, true);
          expect(viewModel.allTags, []);

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

        when(() => watchAllTagsUseCase.call())
            .thenAnswer((_) => Stream.value([]));

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

        when(() => watchAllTagsUseCase.call())
            .thenAnswer((_) => Stream.value([]));

        await viewModel.initialize(taskId: id);

        await viewModel.updateTaskTitle(newTitle);

        verify(() => updateTaskTitleUseCase.call(title: newTitle, id: id));
      });
    });
    group('addTag', () {
      test('expect tag is added', () async {
        const color = '12345678';
        const id = 1;
        final taskEnity = testTaskEntity();
        when(() => getTaskByIdUseCase.call(id))
            .thenAnswer((_) => Future.value(taskEnity));

        when(() => addTagUseCase.call(color: color))
            .thenAnswer((_) async => () {});

        when(() => watchAllTagsUseCase.call())
            .thenAnswer((_) => Stream.value([]));

        await viewModel.initialize(taskId: id);
        await viewModel.addTag(color);

        verify(() => addTagUseCase.call(color: color));
      });
    });

    group('deleteTag', () {
      test('expect tag is deleted', () async {
        const color = '12345678';
        const id = 1;
        final taskEnity = testTaskEntity();
        when(() => getTaskByIdUseCase.call(id))
            .thenAnswer((_) => Future.value(taskEnity));

        when(() => deleteTagUseCase.call(color: color))
            .thenAnswer((_) async => () {});

        when(() => watchAllTagsUseCase.call())
            .thenAnswer((_) => Stream.value([]));

        await viewModel.initialize(taskId: id);
        await viewModel.deleteTag(color);

        verify(() => deleteTagUseCase.call(color: color));
      });
    });

    group('updateTaskTag', () {
      test('expect task tag to be updated', () async {
        const color = '12345678';
        const id = 1;

        final taskEntity = testTaskEntity();
        when(() => getTaskByIdUseCase.call(id))
            .thenAnswer((_) => Future.value(taskEntity));

        when(() => updateTaskTagUseCase.call(id: id, tag: color))
            .thenAnswer((_) async => () {});

        when(() => watchAllTagsUseCase.call())
            .thenAnswer((_) => Stream.value([]));

        await viewModel.initialize(taskId: id);

        await viewModel.updateTasksTag(color);

        verify(() => updateTaskTagUseCase.call(id: id, tag: color));
      });
    });
  });
}
