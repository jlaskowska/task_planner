import 'package:task_planner/domain/database/task_entity.dart';

class TasksSorter {
  TasksSorter._();

  static List<TaskEntity> sort(List<TaskEntity> tasks) {
    if (tasks.isEmpty) {
      return tasks;
    }

    final uncompletedTasks = tasks.where((task) => task.wasCompleted).toList();
    uncompletedTasks
        .sort((a, b) => b.uncompletedAt!.compareTo(a.uncompletedAt!));

    final neverCompletedTasks =
        tasks.where((task) => task.neverCompleted).toList();
    neverCompletedTasks.sort(((a, b) => b.id.compareTo(a.id)));

    final completedTasks = tasks.where((task) => task.isCompleted).toList();
    completedTasks.sort((a, b) => a.completedAt!.compareTo(b.completedAt!));

    return [
      ...uncompletedTasks,
      ...neverCompletedTasks,
      ...completedTasks,
    ];
  }
}
