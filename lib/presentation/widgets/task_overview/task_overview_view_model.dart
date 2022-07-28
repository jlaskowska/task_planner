import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/domain/database/use_cases/complete_task_use_case.dart';
import 'package:task_planner/domain/database/use_cases/create_task_use_case.dart';
import 'package:task_planner/domain/database/use_cases/delete_task_use_case.dart';
import 'package:task_planner/domain/database/use_cases/watch_all_sorted_tasks_use_case.dart';

class TaskOverviewViewModel extends ChangeNotifier {
  TaskOverviewViewModel({
    CreateTaskUseCase? createTaskUseCase,
    WatchAllSortedTasksUseCase? watchAllTasksUseCase,
    CompleteTaskUseCase? completeTaskUseCase,
    DeleteTaskUseCase? deleteTaskUseCase,
  })  : _createTaskUseCase = createTaskUseCase ?? CreateTaskUseCase(),
        _watchAllTasksUseCase =
            watchAllTasksUseCase ?? WatchAllSortedTasksUseCase(),
        _completeTaskUseCase = completeTaskUseCase ?? CompleteTaskUseCase(),
        _deleteTaskUseCase = deleteTaskUseCase ?? DeleteTaskUseCase();

  final CreateTaskUseCase _createTaskUseCase;
  final WatchAllSortedTasksUseCase _watchAllTasksUseCase;
  final CompleteTaskUseCase _completeTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  StreamSubscription<List<TaskEntity>>? _watchAllSortedTasksSubscription;
  var _allSortedTasks = <TaskEntity>[];
  var _isInitialized = false;

  bool get isInitialized => _isInitialized;

  void initialize() {
    _watchAllSortedTasksSubscription?.cancel();
    _watchAllSortedTasksSubscription = _watchAllTasksUseCase().listen((event) {
      _allSortedTasks = event.where((task) => task.title.isNotEmpty).toList();
      _isInitialized = true;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _watchAllSortedTasksSubscription?.cancel();
    super.dispose();
  }

  List<TaskEntity> get allSortedTasks => _allSortedTasks;

  Future<int> createTask() async {
    final newTask = await _createTaskUseCase.call(title: '');
    return newTask.id;
  }

  Future<void> toggleCompleteTask({
    required int taskId,
    required bool value,
  }) async =>
      _completeTaskUseCase.call(
        id: taskId,
        completed: value,
      );

  Future<void> deleteTask(int taskId) => _deleteTaskUseCase(id: taskId);
}
