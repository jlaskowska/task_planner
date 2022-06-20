import 'package:flutter_test/flutter_test.dart';
import 'package:task_planner/domain/tasks_database/task_entity.dart';
import 'package:task_planner/infrastructure/tasks_database/db.dart';
import 'package:task_planner/infrastructure/tasks_database/tasks_mapper.dart';

void main() {
  group('$TasksMapper', () {
    const taskEntity = TaskEntity(id: 1, title: 'title', isCompleted: false);
    final task = Task(id: 1, title: 'title', completed: false);
    
    test('infToDom', () {
      expect(TasksMapper.infToDom(task), taskEntity);
    });

    test('domToInf', () {
      expect(TasksMapper.domToInf(taskEntity), task);
    });
  });
}
