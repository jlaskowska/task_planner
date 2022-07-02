import 'package:flutter/material.dart';
import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/domain/database/use_cases/get_task_by_id_use_case.dart';

class TaskDetailsViewModel extends ChangeNotifier {
  TaskDetailsViewModel({
    GetTaskByIdUseCase? getTaskByIdUseCase,
  }) : _getTaskByIdUseCase = getTaskByIdUseCase ?? GetTaskByIdUseCase();

  final GetTaskByIdUseCase _getTaskByIdUseCase;

  TaskEntity? _task;
  String? get taskTitle => _task?.title;

  bool get isInitialized => _task != null;

  Future<void> initialize({int? taskId}) async {
    if (taskId != null) {
      _task = await _getTaskByIdUseCase(taskId);
      notifyListeners();
    }
  }
}
