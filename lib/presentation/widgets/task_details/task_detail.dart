import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_planner/presentation/widgets/task_details/task_details_view_model.dart';

class TaskDetails extends ConsumerWidget {
  final int taskId;

  const TaskDetails({
    required this.taskId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    TaskDetailsViewModel viewModel = ref.watch(taskDetailsProvider)
      ..initialize(taskId: taskId);

    if (viewModel.isInitialized) {
      return TaskDetailsContent(
        taskTitle: viewModel.taskTitle!,
      );
    }

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

final taskDetailsProvider =
    ChangeNotifierProvider.autoDispose<TaskDetailsViewModel>((ref) {
  return TaskDetailsViewModel();
});

class TaskDetailsContent extends StatefulWidget {
  final String taskTitle;

  const TaskDetailsContent({
    required this.taskTitle,
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
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Task',
                ),
                controller: _controller,
                cursorColor: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
