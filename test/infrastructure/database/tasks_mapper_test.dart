import 'package:flutter_test/flutter_test.dart';
import 'package:task_planner/domain/database/tag_entity.dart';
import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/infrastructure/database/db.dart';
import 'package:task_planner/infrastructure/database/tasks_mapper.dart';

void main() {
  group('$TasksMapper', () {
    group('base variables', () {
      const taskEntity = TaskEntity(id: 1, title: 'title');
      final task = Task(id: 1, title: 'title');

      test('infToDom', () {
        expect(TasksMapper.infToDom(task), taskEntity);
      });

      test('domToInf', () {
        expect(TasksMapper.domToInf(taskEntity), task);
      });
    });

    group('tags', () {
      const taskEntity = TaskEntity(
        id: 1,
        title: 'title',
        tag: TagEntity(color: 'label'),
      );
      final task = Task(id: 1, title: 'title', tag: 'label');

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
        completedAt: DateTime(1),
      );
      final task = Task(
        id: 1,
        title: 'title',
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
        uncompletedAt: DateTime(1),
      );
      final task = Task(
        id: 1,
        title: 'title',
        uncompletedAt: DateTime(1),
      );

      test('infToDom', () {
        expect(TasksMapper.infToDom(task), taskEntity);
      });

      test('domToInf', () {
        expect(TasksMapper.domToInf(taskEntity), task);
      });
    });
  });
}
