import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:task_planner/presentation/widgets/task_tile.dart';
import 'package:task_planner/routes.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routes),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}

class TasksOverview extends StatefulWidget {
  const TasksOverview({Key? key}) : super(key: key);

  @override
  State<TasksOverview> createState() => _TasksOverviewState();
}

class _TasksOverviewState extends State<TasksOverview> {
  var _isTaskComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Routemaster.of(context).push('/task/1'),
      ),
      appBar: AppBar(
        title: const Text('Task Planner'),
      ),
      body: Column(
        children: [
          TaskTile(
            title: 'Walk the dog',
            isCompleted: _isTaskComplete,
            onChanged: (value) => setState(() => _isTaskComplete = value),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
