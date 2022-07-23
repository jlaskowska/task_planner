import 'package:task_planner/domain/database/tag_entity.dart';
import 'package:task_planner/domain/database/task_entity.dart';

TaskEntity testTaskEntity({
  int? id,
  String? title,
  bool? isCompleted,
  String? tag,
  DateTime? completedAt,
  DateTime? uncompletedAt,
}) =>
    TaskEntity(
      id: id ?? 1,
      title: title ?? '',
      isCompleted: isCompleted ?? false,
      completedAt: completedAt,
      uncompletedAt: uncompletedAt,
      tag: tag != null ? testTagEntity(label: tag) : null,
    );

TagEntity testTagEntity({
  String? label,
}) =>
    TagEntity(label: label ?? 'label');
