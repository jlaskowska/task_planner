import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/domain/database/tasks_sorter.dart';
import 'package:task_planner/domain/database/use_cases/complete_task_use_case.dart';
import 'package:task_planner/domain/database/use_cases/create_task_use_case.dart';
import 'package:task_planner/domain/database/use_cases/watch_all_tasks_use_case.dart';

class TaskOverviewViewModel extends ChangeNotifier {
  TaskOverviewViewModel({
    CreateTaskUseCase? createTaskUseCase,
    WatchAllTasksUseCase? watchAllTasksUseCase,
    CompleteTaskUseCase? completeTaskUseCase,
  })  : _createTaskUseCase = createTaskUseCase ?? CreateTaskUseCase(),
        _watchAllTasksUseCase = watchAllTasksUseCase ?? WatchAllTasksUseCase(),
        _completeTaskUseCase = completeTaskUseCase ?? CompleteTaskUseCase();

  final CreateTaskUseCase _createTaskUseCase;
  final WatchAllTasksUseCase _watchAllTasksUseCase;
  final CompleteTaskUseCase _completeTaskUseCase;
  StreamSubscription<List<TaskEntity>>? _watchAllTasksSubscription;
  var _allTasks = <TaskEntity>[];
  var _isInitialized = false;

  bool get isInitialized => _isInitialized;

  void initialize() {
    _watchAllTasksSubscription?.cancel();
    _watchAllTasksSubscription = _watchAllTasksUseCase().listen((event) {
      _allTasks = event.where((task) => task.title.isNotEmpty).toList();
      _allTasks = TasksSorter.sort(_allTasks);
      _isInitialized = true;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _watchAllTasksSubscription?.cancel();
    super.dispose();
  }

  List<TaskEntity> get allTasks => _allTasks;

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
}
