import 'package:task_planner/domain/database/tag_entity.dart';
import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/infrastructure/database/db.dart';

class TasksMapper {
  TasksMapper._();

  static TaskEntity infToDom(Task task) => TaskEntity(
        id: task.id,
        title: task.title,
        completedAt: task.completedAt,
        uncompletedAt: task.uncompletedAt,
        tag: task.tag != null ? TagEntity(color: task.tag!) : null,
      );

  static Task domToInf(TaskEntity entity) => Task(
        id: entity.id,
        title: entity.title,
        completedAt: entity.completedAt,
        uncompletedAt: entity.uncompletedAt,
        tag: entity.tag?.color,
      );
}
