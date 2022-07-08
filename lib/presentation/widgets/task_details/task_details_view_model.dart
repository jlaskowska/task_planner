import 'package:flutter/material.dart';
import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/domain/database/use_cases/delete_task_use_case.dart';
import 'package:task_planner/domain/database/use_cases/get_task_by_id_use_case.dart';
import 'package:task_planner/domain/database/use_cases/update_task_title_use_case.dart';

class TaskDetailsViewModel extends ChangeNotifier {
  TaskDetailsViewModel({
    GetTaskByIdUseCase? getTaskByIdUseCase,
    DeleteTaskUseCase? deleteTaskUseCase,
    UpdateTaskTitleUseCase? updateTaskTitleUseCase,
  })  : _getTaskByIdUseCase = getTaskByIdUseCase ?? GetTaskByIdUseCase(),
        _deleteTaskUseCase = deleteTaskUseCase ?? DeleteTaskUseCase(),
        _updateTaskTitleUseCase =
            updateTaskTitleUseCase ?? UpdateTaskTitleUseCase();

  final GetTaskByIdUseCase _getTaskByIdUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final UpdateTaskTitleUseCase _updateTaskTitleUseCase;

  TaskEntity? _task;

  String? get taskTitle => _task?.title;
  int? get taskId => _task?.id;

  bool get isInitialized => _task != null;

  Future<void> initialize({int? taskId}) async {
    if (taskId != null) {
      _task = await _getTaskByIdUseCase(taskId);
      notifyListeners();
    }
  }

  Future<void> deleteTask() async {
    if (isInitialized) {
      _deleteTaskUseCase(id: taskId!);
    }
  }

  Future<void> updateTaskTitle(String title) async {
    if (isInitialized) {
      await _updateTaskTitleUseCase(id: taskId!, title: title);
    }
  }
}
