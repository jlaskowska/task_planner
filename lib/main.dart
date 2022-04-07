import 'package:flutter/material.dart';
import 'package:task_planner/presentation/widgets/task_tile.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _isTaskComplete = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
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
      ),
    );
  }
}
