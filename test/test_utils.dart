import 'package:task_planner/domain/database/tag_entity.dart';
import 'package:task_planner/domain/database/task_entity.dart';

TaskEntity testTaskEntity({
  int? id,
  String? title,
  DateTime? completedAt,
  DateTime? uncompletedAt,
  String? tag,
}) =>
    TaskEntity(
      id: id ?? 1,
      title: title ?? '',
      completedAt: completedAt,
      uncompletedAt: uncompletedAt,
      tag: tag != null ? testTagEntity(label: tag) : null,
    );

TagEntity testTagEntity({
  String? label,
}) =>
    TagEntity(color: label ?? 'label');
