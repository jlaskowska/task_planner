import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:task_planner/main.dart';
import 'package:task_planner/presentation/widgets/task_details/task_detail.dart';

final routes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(
          child: TasksOverview(),
        ),
    '/task/:id': (route) => MaterialPage(
          child: TaskDetails(
            taskId: int.tryParse(route.pathParameters['id'] ?? '') ?? -1,
          ),
        ),
  },
);
