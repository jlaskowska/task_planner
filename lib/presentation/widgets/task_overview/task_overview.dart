import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
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
      body: ListView(
        children: [
          for (final task in viewModel.allTasks)
            TaskTile(
              title: task.title,
              isCompleted: task.isCompleted,
              tag: task.tag?.label,
              onChanged: (value) => viewModel.toggleCompleteTask(
                taskId: task.id,
                value: value,
              ),
              onTap: () => Routemaster.of(context).push('/task/${task.id}'),
            ),
        ],
      ),
    );
  }
}
