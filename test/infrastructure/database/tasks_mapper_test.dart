import 'package:flutter_test/flutter_test.dart';
import 'package:task_planner/domain/database/tag_entity.dart';
import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/infrastructure/database/db.dart';
import 'package:task_planner/infrastructure/database/tasks_mapper.dart';

void main() {
  group('$TasksMapper', () {
    group('base variables', () {
      final taskEntity = TaskEntity(id: 1, title: 'title', isCompleted: false);
      final task = Task(id: 1, title: 'title', completed: false);

      test('infToDom', () {
        expect(TasksMapper.infToDom(task), taskEntity);
      });

      test('domToInf', () {
        expect(TasksMapper.domToInf(taskEntity), task);
      });
    });

    group('tags', () {
      final taskEntity = TaskEntity(
        id: 1,
        title: 'title',
        isCompleted: false,
        tag: const TagEntity(label: 'label'),
      );
      final task = Task(id: 1, title: 'title', completed: false, tag: 'label');

      test('infToDom', () {
        expect(TasksMapper.infToDom(task), taskEntity);
      });

      test('domToInf', () {
        expect(TasksMapper.domToInf(taskEntity), task);
      });
    });

    group('complatedAt', () {
      final taskEntity = TaskEntity(
        id: 1,
        title: 'title',
        isCompleted: true,
        completedAt: DateTime(1),
      );
      final task = Task(
        id: 1,
        title: 'title',
        completed: true,
        completedAt: DateTime(1),
      );

      test('infToDom', () {
        expect(TasksMapper.infToDom(task), taskEntity);
      });

      test('domToInf', () {
        expect(TasksMapper.domToInf(taskEntity), task);
      });
    });

    group('uncomplatedAt', () {
      final taskEntity = TaskEntity(
        id: 1,
        title: 'title',
        isCompleted: false,
        uncompletedAt: DateTime(1),
      );
      final task = Task(
        id: 1,
        title: 'title',
        completed: false,
        uncompletedAt: DateTime(1),
      );

      test('infToDom', () {
        expect(TasksMapper.infToDom(task), taskEntity);
        expect(TasksMapper.infToDom(task).wasCompleted, isTrue);
      });

      test('domToInf', () {
        expect(TasksMapper.domToInf(taskEntity), task);
      });
    });
  });
}
