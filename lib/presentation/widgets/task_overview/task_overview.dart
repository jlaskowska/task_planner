import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:task_planner/domain/database/task_entity.dart';
import 'package:task_planner/presentation/widgets/task_overview/task_overview_view_model.dart';
import 'package:task_planner/presentation/widgets/task_tile.dart';

class TasksOverview extends StatelessWidget {
  const TasksOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TaskOverviewViewModel()..initialize(),
        builder: (context, child) {
          final viewModel = Provider.of<TaskOverviewViewModel>(context);

          if (viewModel.isInitialized) {
            return TasksOverviewContent(
              viewModel: viewModel,
            );
          }

          return const SizedBox.shrink();
        });
  }
}

class TasksOverviewContent extends StatelessWidget {
  final TaskOverviewViewModel viewModel;

  const TasksOverviewContent({
    required this.viewModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          final id = await viewModel.createTask();
          Routemaster.of(context).push('/task/$id');
        },
      ),
      appBar: AppBar(
        title: const Text('Task Planner'),
      ),
      body: AnimatedTaskList(
        viewModel: viewModel,
      ),
    );
  }
}

class AnimatedTaskList extends StatefulWidget {
  final TaskOverviewViewModel viewModel;

  const AnimatedTaskList({
    required this.viewModel,
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedTaskList> createState() => _AnimatedTaskListState();
}

class _AnimatedTaskListState extends State<AnimatedTaskList> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final _tasks = <TaskEntity>[];

  @override
  void initState() {
    super.initState();

    _addItems();
  }

  void _removeItem(int index, bool isCompleted) {
    if (isCompleted) {
      // when last element, do not remove + add
      if (index != _tasks.length - 1) {
        _key.currentState!.removeItem(index, (_, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: const Offset(0, 0),
            ).animate(animation),
          );
        }, duration: const Duration(milliseconds: 400));

        _tasks.add(_tasks.removeAt(index));
        _key.currentState?.insertItem(
          _tasks.length - 1,
          duration: const Duration(milliseconds: 400),
        );
      }
    } else {
      final firstCompletedIndex =
          _tasks.indexWhere((element) => element.isCompleted);

      // only animate if position will change
      if (firstCompletedIndex != index) {
        _key.currentState!.removeItem(index, (_, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0),
              end: const Offset(-1, 0),
            ).animate(animation),
          );
        }, duration: const Duration(milliseconds: 400));

        _tasks.insert(firstCompletedIndex, _tasks.removeAt(index));
        _key.currentState?.insertItem(
          firstCompletedIndex,
          duration: const Duration(milliseconds: 400),
        );
      }
    }
  }

  void _addItems() async {
    for (var i = 0; i < widget.viewModel.allTasks.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100), () {
        _tasks.add(widget.viewModel.allTasks[i]);
        _key.currentState?.insertItem(_tasks.length - 1);
      });
    }
  }

  @override
  void didUpdateWidget(AnimatedTaskList oldWidget) {
    super.didUpdateWidget(oldWidget);

    for (final task in widget.viewModel.allTasks) {
      final localTasks = _tasks.where(
        (element) => element.id == task.id,
      );
      final localTask = localTasks.length == 1 ? localTasks.first : null;
      if (localTask == null) {
        // task is new and should be added to list
        _tasks.insert(0, task);
        _key.currentState?.insertItem(
          0,
          duration: const Duration(seconds: 0),
        );
      } else if (localTask != task) {
        // task has changed and should update
        final index = _tasks.indexOf(localTask);
        _tasks.removeAt(index);
        _tasks.insert(index, task);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _key,
      initialItemCount: _tasks.length,
      itemBuilder: ((_, index, animation) {
        final task = _tasks[index];
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          )),
          child: TaskTile(
            title: task.title,
            isCompleted: task.isCompleted,
            tag: task.tag?.label,
            onChanged: (value) {
              widget.viewModel
                  .toggleCompleteTask(taskId: task.id, value: value);
              _removeItem(index, value);
            },
            onTap: () => Routemaster.of(context).push('/task/${task.id}'),
          ),
        );
      }),
    );
  }
}
