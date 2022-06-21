import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_planner/domain/database/tag_entity.dart';

part 'task_entity.freezed.dart';

@freezed
class TaskEntity with _$TaskEntity {
  const factory TaskEntity({
    required int id,
    required String title,
    required bool isCompleted,
    TagEntity? tag,
  }) = _TaskEntity;
}
