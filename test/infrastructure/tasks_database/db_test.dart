import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_planner/domain/tasks_database/task_entity.dart';
import 'package:task_planner/infrastructure/tasks_database/db.dart';

void main() {
  group('Database', () {
    late TasksDatabase db;

    setUp(() {
      db = TasksDatabase(NativeDatabase.memory());
    });

    tearDown(() async {
      await db.close();
    });
    const title = 'title';

    group('createTask', () {
      group('when no label is given', () {
        test('expect task is inserted into db', () async {
          final task = Task(id: 1, title: title, completed: false);

          await db.createTask(title: title);

          final expectation = expectLater(
            db.select(db.tasks).watch(),
            emitsInOrder([
              [task],
            ]),
          );

          await expectation;
        });
      });

      group('when label is given', () {
        const tag = 'tag';
        final task = Task(
          id: 1,
          title: title,
          tag: tag,
          completed: false,
        );
        final tagDTO = Tag(label: tag);

        group('and label does not exist in db', () {
          test('expect task & tag are inserted into db', () async {
            final expectationA = expectLater(
              db.select(db.tags).watch(),
              emitsInOrder([
                [],
                [tagDTO],
              ]),
            );

            await db.createTask(title: title, tag: tag);

            final expectationB = expectLater(
              db.select(db.tasks).watch(),
              emitsInOrder([
                [task],
              ]),
            );

            await expectationA;
            await expectationB;
          });
        });

        group('and label exists in db', () {
          test('expect task is inserted into db', () async {
            await db.into(db.tags).insert(tagDTO);

            final expectationA = expectLater(
              db.select(db.tags).watch(),
              emitsInOrder([
                [tagDTO],
              ]),
            );

            await db.createTask(title: title, tag: tag);

            final expectationB = expectLater(
              db.select(db.tasks).watch(),
              emitsInOrder([
                [task],
              ]),
            );

            await expectationA;
            await expectationB;
          });
        });
      });
    });

    group('getTask', () {
      const id = 1;

      group('when task exists in db', () {
        test('expect task is returned', () async {
          const taskEntity =
              TaskEntity(id: 1, title: 'title', isCompleted: false);
          final task = Task(id: 1, title: 'title', completed: false);

          await db.into(db.tasks).insert(task);

          final taskFromDatabase = await db.getTask(id);

          expect(taskFromDatabase, taskEntity);
        });
      });

      group('when task does not exist in db', () {
        test('expect error', () async {
          expect(() async => await db.getTask(id), throwsStateError);
        });
      });
    });

    group('deleteTask', () {
      test('expect task is deleted from db', () async {
        final task = Task(id: 1, title: title, completed: false);

        await db.createTask(title: title);

        final expectation = expectLater(
          db.select(db.tasks).watch(),
          emitsInOrder([
            [task],
            [],
          ]),
        );
        await db.deleteTask(1);

        await expectation;
      });
    });

    group('getAllTasks', () {
      group('when tasks exist in db', () {
        test('expect all tasks are returned', () async {
          const taskEntity =
              TaskEntity(id: 1, title: 'title', isCompleted: false);

          await db.createTask(title: title);
          final allTasks = await db.getAllTasks();

          expect(allTasks, [taskEntity]);
        });
      });

      group('when tasks do not exist in db', () {
        test('expect empty list', () async {
          final allTasks = await db.getAllTasks();
          expect(allTasks, []);
        });
      });
    });

    group('watchAllTasks', () {
      test('expect stream is updated', () async {
        const task1 = TaskEntity(id: 1, title: title, isCompleted: false);
        const task2 = TaskEntity(id: 2, title: title, isCompleted: false);

        await db.createTask(title: title);

        final expectation = expectLater(
          db.watchAllTasks(),
          emitsInOrder([
            [task1],
            [],
            [task2],
          ]),
        );

        await db.deleteTask(1);
        await db.createTask(title: title);

        await expectation;
      });
    });
  });
}