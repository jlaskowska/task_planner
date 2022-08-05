import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_planner/domain/database/tag_entity.dart';
import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/infrastructure/database/db.dart';

void main() {
  group('Database', () {
    late Database db;

    setUp(() {
      db = Database(NativeDatabase.memory());
    });

    tearDown(() async {
      await db.close();
    });

    const title = 'title';
    const id = 1;

    group('createTask', () {
      group('when no tag is given', () {
        test('expect task is inserted into db', () async {
          final task = Task(id: id, title: title);

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

      group('when tag is given', () {
        const color = '12345678';
        final task = Task(
          id: id,
          title: title,
          tag: color,
        );
        final tagDTO = Tag(color: color);

        group('and label does not exist in db', () {
          test('expect task & tag are inserted into db', () async {
            final expectationA = expectLater(
              db.select(db.tags).watch(),
              emitsInOrder([
                [],
                [tagDTO],
              ]),
            );

            await db.createTask(title: title, tag: color);

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

        group('and tag exists in db', () {
          test('expect task is inserted into db', () async {
            await db.into(db.tags).insert(tagDTO);

            final expectationA = expectLater(
              db.select(db.tags).watch(),
              emitsInOrder([
                [tagDTO],
              ]),
            );

            await db.createTask(title: title, tag: color);

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

    group('updateTask', () {
      group('with completed', () {
        final now = DateTime(1).toUtc();

        test('when completed=true, expect a completed task', () async {
          const taskEntity = TaskEntity(id: id, title: title);
          final task = Task(id: id, title: title);

          await db.into(db.tasks).insert(task);

          final taskFromDatabase = await db.getTask(id);

          expect(taskFromDatabase, taskEntity);

          withClock(Clock.fixed(now), () async {
            await db.updateTask(id: id, completed: true);
          });

          final updatedTask = await db.getTask(id);

          expect(updatedTask, taskEntity.copyWith(completedAt: now));
        });

        test('when completed=false, expect an uncompleted task', () async {
          const taskEntity = TaskEntity(id: id, title: title);
          final task = Task(id: id, title: title);

          await db.into(db.tasks).insert(task);

          final taskFromDatabase = await db.getTask(id);

          expect(taskFromDatabase, taskEntity);

          withClock(Clock.fixed(now), () async {
            await db.updateTask(id: id, completed: false);
          });

          final updatedTask = await db.getTask(id);

          expect(updatedTask, taskEntity.copyWith(uncompletedAt: now));
        });
      });

      group('with title', () {
        test('expect a task with an updated title', () async {
          const newTitle = 'newTitle';
          const taskEntity = TaskEntity(id: id, title: title);
          final task = Task(id: id, title: title);

          await db.into(db.tasks).insert(task);

          final taskFromDatabase = await db.getTask(id);

          expect(taskFromDatabase, taskEntity);

          await db.updateTask(id: id, title: newTitle);

          final updatedTask = await db.getTask(id);

          expect(updatedTask, taskEntity.copyWith(title: newTitle));
        });
      });
    });

    group('getTask', () {
      group('when task exists in db', () {
        test('expect task is returned', () async {
          const taskEntity = TaskEntity(id: id, title: title);
          final task = Task(id: id, title: title);

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
        final task = Task(id: id, title: title);

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
          const taskEntity = TaskEntity(id: id, title: title);

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
        const task1 = TaskEntity(id: 1, title: title);
        const task2 = TaskEntity(id: 2, title: title);

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
    group('watchTask', () {
      test('expect stream is updated', () async {
        const task = TaskEntity(id: id, title: title);

        await db.createTask(title: title);

        final expectation = expectLater(
          db.watchTask(id),
          emits(task),
        );

        await expectation;
      });
    });
    group('addTag', () {
      test('expect tag is added to db', () async {
        const color = '12345678';
        final tag = Tag(color: color);
        await db.addTag(color);

        final expectation = expectLater(
          db.select(db.tags).watch(),
          emitsInOrder([
            [tag],
          ]),
        );

        await expectation;
      });
    });
    group(
      'watchAllTags',
      () {
        test('expect stream is updated', () async {
          const color1 = '12345678';
          const color2 = '87654321';
          const tag1 = TagEntity(color: color1);
          const tag2 = TagEntity(color: color2);

          await db.addTag(color1);

          final expectation = expectLater(
            db.watchAllTags(),
            emitsInOrder([
              [tag1],
              [],
              [tag2],
            ]),
          );

          await db.deleteTag(color1);
          await db.addTag(color2);

          await expectation;
        });
      },
      skip: true,
    );

    group('deleteTag', () {
      group('when tag exists in db', () {
        test('expect a tag is deleted from db and tasks are updated', () async {
          const color = '12345678';
          const task = TaskEntity(
            id: id,
            title: title,
            tag: TagEntity(color: color),
          );
          const taskWithoutTag = TaskEntity(
            id: id,
            title: title,
          );
          final tagDTO = Tag(color: color);

          await db.createTask(title: title, tag: color);

          final expectationA = expectLater(
            db.watchAllTasks(),
            emitsInOrder([
              [task],
              [taskWithoutTag]
            ]),
          );

          final expectationB = expectLater(
            db.select(db.tags).watch(),
            emitsInOrder([
              [tagDTO],
              []
            ]),
          );
          await db.deleteTag(color);

          await expectationA;
          await expectationB;
        });
      });
    });
  });
}
