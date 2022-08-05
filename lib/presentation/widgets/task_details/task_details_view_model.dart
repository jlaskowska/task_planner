import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_planner/domain/database/tag_entity.dart';
import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/domain/database/use_cases/add_tag_use_case.dart';
import 'package:task_planner/domain/database/use_cases/delete_tag_use_case.dart';
import 'package:task_planner/domain/database/use_cases/delete_task_use_case.dart';
import 'package:task_planner/domain/database/use_cases/update_task_tag_use_case.dart';
import 'package:task_planner/domain/database/use_cases/update_task_title_use_case.dart';
import 'package:task_planner/domain/database/use_cases/watch_all_tags_use_case.dart';
import 'package:task_planner/domain/database/use_cases/watch_task_use_case.dart';

class TaskDetailsViewModel extends ChangeNotifier {
  TaskDetailsViewModel({
    WatchTaskUseCase? watchTaskUseCase,
    DeleteTaskUseCase? deleteTaskUseCase,
    UpdateTaskTitleUseCase? updateTaskTitleUseCase,
    DeleteTagUseCase? deleteTagUseCase,
    AddTagUseCase? addTagUseCase,
    WatchAllTagsUseCase? watchAllTagsUseCase,
    UpdateTaskTagUseCase? updateTasksTagUseCase,
  })  : _deleteTaskUseCase = deleteTaskUseCase ?? DeleteTaskUseCase(),
        _updateTaskTitleUseCase =
            updateTaskTitleUseCase ?? UpdateTaskTitleUseCase(),
        _deleteTagUseCase = deleteTagUseCase ?? DeleteTagUseCase(),
        _addTagUseCase = addTagUseCase ?? AddTagUseCase(),
        _watchAllTagsUseCase = watchAllTagsUseCase ?? WatchAllTagsUseCase(),
        _updateTasksTagUseCase =
            updateTasksTagUseCase ?? UpdateTaskTagUseCase(),
        _watchTaskUseCase = watchTaskUseCase ?? WatchTaskUseCase();

  final WatchTaskUseCase _watchTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final UpdateTaskTitleUseCase _updateTaskTitleUseCase;
  final DeleteTagUseCase _deleteTagUseCase;
  final AddTagUseCase _addTagUseCase;
  final WatchAllTagsUseCase _watchAllTagsUseCase;
  final UpdateTaskTagUseCase _updateTasksTagUseCase;

  StreamSubscription<List<TagEntity>>? _watchAllTagsSubscription;
  StreamSubscription<TaskEntity>? _watchTaskSubscription;
  var _allTags = <TagEntity>[];

  TaskEntity? _task;

  String? get taskTitle => _task?.title;
  int? get taskId => _task?.id;

  bool get isInitialized => _task != null;

  List<TagEntity> get allTags => _allTags;

  Future<void> initialize({int? taskId}) async {
    _watchAllTagsSubscription?.cancel();
    _watchTaskSubscription?.cancel();
    if (taskId != null) {
      _watchTaskSubscription = _watchTaskUseCase(taskId).listen((event) {
        _task = event;
        notifyListeners();
      });
      _watchAllTagsSubscription = _watchAllTagsUseCase().listen((event) {
        _allTags = event.toList();
        notifyListeners();
      });
    }
  }

  @override
  void dispose() {
    _watchAllTagsSubscription?.cancel();
    _watchTaskSubscription?.cancel();
    super.dispose();
  }

  Future<void> deleteTag(String color) async {
    if (isInitialized) {
      await _deleteTagUseCase(color: color);
    }
  }

  Future<void> addTag(String tag) async {
    if (isInitialized) {
      _addTagUseCase(color: tag);
    }
  }

  Future<void> updateTasksTag(String? tag) async {
    if (isInitialized) {
      _updateTasksTagUseCase(id: taskId!, tag: tag);
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
