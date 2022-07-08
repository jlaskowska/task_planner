import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:task_planner/presentation/widgets/task_details/task_details_view_model.dart';

class TaskDetails extends StatelessWidget {
  final int taskId;

  const TaskDetails({
    required this.taskId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskDetailsViewModel()..initialize(taskId: taskId),
      builder: (context, child) {
        final viewModel = Provider.of<TaskDetailsViewModel>(context);

        if (viewModel.isInitialized) {
          return TaskDetailsContent(
            taskTitle: viewModel.taskTitle!,
            deleteTask: viewModel.deleteTask,
            updtateTaskTitle: viewModel.updateTaskTitle,
          );
        }

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ),
        );
      },
    );
  }
}

class TaskDetailsContent extends StatefulWidget {
  final String taskTitle;
  final VoidCallback deleteTask;
  final void Function(String) updtateTaskTitle;

  const TaskDetailsContent({
    required this.taskTitle,
    required this.deleteTask,
    required this.updtateTaskTitle,
    Key? key,
  }) : super(key: key);

  @override
  State<TaskDetailsContent> createState() => _TaskDetailsContentState();
}

class _TaskDetailsContentState extends State<TaskDetailsContent> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();

    _controller.text = widget.taskTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () async {
            if (_controller.text.isEmpty) {
              widget.deleteTask();
            } else {
              widget.updtateTaskTitle(_controller.text);
            }
            Routemaster.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Take a note...',
                  hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.color
                            ?.withOpacity(0.6),
                      ),
                ),
                controller: _controller,
                style: Theme.of(context).textTheme.bodyText2,
                cursorColor: Theme.of(context).textTheme.bodyText2?.color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
