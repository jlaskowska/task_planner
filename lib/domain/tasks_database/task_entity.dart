import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_entity.freezed.dart';

@freezed
class TaskEntity with _$TaskEntity {
  const factory TaskEntity({
    required String title,
    required String id,
    required bool isCompleted,
  }) = _TaskEntity;
}
