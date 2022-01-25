import 'package:task_planner/domain/tasks_database/task_entity.dart';
import 'package:task_planner/infrastructure/tasks_database/db.dart';

class TasksMapper {

TasksMapper._();

  static TaskEntity infToDom(Task task) => TaskEntity(
        id: task.id,
        title: task.title,
        isCompleted: task.completed,
      );

  static Task domToInf(TaskEntity entity) => Task(
        id: entity.id,
        title: entity.title,
        completed: entity.isCompleted,
      );
}
