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
      group('when no label is given', () {
        test('expect task is inserted into db', () async {
          final task = Task(id: id, title: title, completed: false);

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
          id: id,
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
      

      group('when task exists in db', () {
        test('expect task is returned', () async {
          const taskEntity =
              TaskEntity(id: id, title: title, isCompleted: false);
          final task = Task(id: id, title: title, completed: false);

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
        final task = Task(id: id, title: title, completed: false);

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
              TaskEntity(id: id, title: title, isCompleted: false);

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
    group('addTag', () {
      test('expect tag is added to db', () async {
        final tag = Tag(label: 'label');
        await db.addTag('label');

        final expectation = expectLater(
          db.select(db.tags).watch(),
          emitsInOrder([
            [tag],
          ]),
        );

        await expectation;
      });
    });
    group('getAllTags', () {
      group('when tags exist in db', () {
        test('expect all tags are returned', () async {
          const tag = TagEntity(label: 'label');

          await db.addTag('label');
          final allTags = await db.getAllTags();

          expect(allTags, [tag]);
        });
      });

      group('when tags do not exist in db', () {
        test('expect empty []', () async {
          final allTags = await db.getAllTags();

          expect(allTags, []);
        });
      });
    });
    group('deleteTag', () {
      group('when tag exists in db', () {
        test('expect a tag is deleted from db and tasks are updated', () async {
          const tag = 'tag';
          const task = TaskEntity(
            id: id,
            title: title,
            tag: TagEntity(label: tag),
            isCompleted: false,
          );
          const taskWithoutTag = TaskEntity(
            id: id,
            title: title,
            isCompleted: false,
          );
          final tagDTO = Tag(label: tag);

          await db.createTask(title: title, tag: tag);

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
          await db.deleteTag(tag);

          await expectationA;
          await expectationB;
        });
      });
    });
  });
}
