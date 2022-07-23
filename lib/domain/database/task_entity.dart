import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_planner/domain/database/tag_entity.dart';

part 'task_entity.freezed.dart';

@freezed
class TaskEntity with _$TaskEntity {
  const TaskEntity._();

  @Assert("isCompleted ? completedAt != null : completedAt == null")
  // @Assert("completedAt != null && uncompletedAt != null")
  const factory TaskEntity({
    required int id,
    required String title,
    required bool isCompleted,
    DateTime? completedAt,
    DateTime? uncompletedAt,
    TagEntity? tag,
  }) = _TaskEntity;

  /// A task which was completed in the past but is now not completed
  bool get wasCompleted => uncompletedAt != null;

  /// A task which was never completed nor uncompleted
  bool get neverCompleted => !isCompleted && !wasCompleted;
}
