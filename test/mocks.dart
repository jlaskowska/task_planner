import 'package:mocktail/mocktail.dart';
import 'package:task_planner/domain/database/use_cases/complete_task_use_case.dart';
import 'package:task_planner/domain/database/use_cases/create_task_use_case.dart';
import 'package:task_planner/domain/database/use_cases/delete_task_use_case.dart';
import 'package:task_planner/domain/database/use_cases/get_task_by_id_use_case.dart';
import 'package:task_planner/domain/database/use_cases/update_task_title_use_case.dart';
import 'package:task_planner/domain/database/use_cases/watch_all_sorted_tasks_use_case.dart';
import 'package:task_planner/infrastructure/database/db.dart';

class MockDatabase extends Mock implements Database {}

class MockCreateTaskUseCase extends Mock implements CreateTaskUseCase {}

class MockWatchAllSortedTasksUseCase extends Mock
    implements WatchAllSortedTasksUseCase {}

class MockCompleteTaskUseCase extends Mock implements CompleteTaskUseCase {}

class MockGetTaskByIdUseCase extends Mock implements GetTaskByIdUseCase {}

class MockDeleteTaskUseCase extends Mock implements DeleteTaskUseCase {}

class MockUpdateTaskTitleUseCase extends Mock
    implements UpdateTaskTitleUseCase {}
